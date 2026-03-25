#!/usr/bin/env ruby
# frozen_string_literal: true

# Parse each post body with Liquid (Jekyll runs Liquid on post content before Markdown).
# Catches unknown tags, stray {% endraw %}, invalid {{ }} expressions, etc.
#
# Usage (repository root):
#   bundle exec ruby tools/check_liquid_posts.rb
#   bundle exec ruby tools/check_liquid_posts.rb --encoding-report   # locate invalid UTF-8 (byte + line)
#   bundle exec ruby tools/check_liquid_posts.rb --verbose
#
# See tools/README.md if `bundle` fails with GemNotFoundException for bundler.

begin
  require "liquid"
rescue LoadError
  warn "check_liquid_posts.rb: cannot load the `liquid` gem."
  warn "  Fix: run `bundle install` in the repo root, then:"
  warn "    bundle exec ruby tools/check_liquid_posts.rb"
  warn "  Or install Bundler for your Ruby: `gem install bundler`, then `bundle install`."
  exit 2
end

# Jekyll registers {% post_url %} — plain Liquid does not. Stub so parse matches site build.
class StubJekyllPostUrlTag < Liquid::Tag
  def initialize(_tag_name, _markup, _options)
    super
  end

  def render(_context)
    ""
  end
end

Liquid::Template.register_tag("post_url", StubJekyllPostUrlTag)

def usage!
  warn "Usage: #{$PROGRAM_NAME} [--verbose] [--encoding-report] [_posts/foo.markdown ...]"
  exit 64
end

# MatchData#begin/#end are character indices for String#match on UTF-8 strings — use String#[], not byteslice.
def strip_front_matter(text)
  return text unless text.start_with?("---\n")

  m = text.match(/\A---\s*\n.*?\n---\s*\n/m)
  return text unless m

  text[m.end(0)..-1] || ""
end

# Liquid 4 tokenizes with String#split and requires valid UTF-8; binary garbage in posts needs scrubbing.
def read_post_as_utf8(path, verbose: false)
  bin = File.binread(path)
  unless bin.dup.force_encoding("UTF-8").valid_encoding?
    warn "#{path}: warning — raw file is not valid UTF-8; scrubbing for Liquid (re-save as UTF-8)" if verbose
  end
  bin.encode("UTF-8", invalid: :replace, undef: :replace, replace: "\uFFFD")
end

# First byte offset where a UTF-8 decoder would fail (binary search on prefix validity).
def first_invalid_utf8_byte_index(bin)
  return nil if bin.dup.force_encoding("UTF-8").valid_encoding?

  n = bin.bytesize
  lo = 1
  hi = n
  while lo < hi
    mid = (lo + hi) / 2
    if bin.byteslice(0, mid).force_encoding("UTF-8").valid_encoding?
      lo = mid + 1
    else
      hi = mid
    end
  end
  [lo - 1, 0].max
end

def encoding_report_for_file(path)
  bin = File.binread(path)
  return nil if bin.dup.force_encoding("UTF-8").valid_encoding?

  idx = first_invalid_utf8_byte_index(bin)
  line = idx.nil? || idx.negative? ? 1 : (bin.byteslice(0, idx).count("\n".b) + 1)
  ctx = bin.byteslice([idx.to_i - 8, 0].max, 32)
  hex = ctx.bytes.map { |b| format("%02X", b) }.join(" ")
  { idx: idx, line: line, hex: hex }
end

def report_encoding_issues(paths)
  bad = 0
  paths.each do |path|
    info = encoding_report_for_file(path)
    next unless info

    bad += 1
    warn "#{path}: invalid UTF-8 — first bad region around byte #{info[:idx]} (line ~#{info[:line]}), hex: #{info[:hex]}"
  end
  bad
end

def raw_tag_depth_warning(path, body)
  depth = 0
  body.scan(/\{%-?\s*(raw|endraw)\s*-?%\}/) do
    tag = Regexp.last_match(1)
    depth += (tag == "raw" ? 1 : -1)
    if depth.negative?
      warn "#{path}: warning — {% endraw %} without matching {% raw %} (text scan; line numbers not available)"
      return
    end
  end
  warn "#{path}: warning — unclosed {% raw %} (count=#{depth})" if depth.positive?
end

args = ARGV.dup
verbose = args.delete("--verbose")
encoding_report = args.delete("--encoding-report")
usage! if args.include?("-h") || args.include?("--help")

paths =
  if args.empty?
    Dir.glob("_posts/*.{markdown,md}").sort
  else
    args.flat_map { |p| File.directory?(p) ? Dir.glob(File.join(p, "*.{markdown,md}")).sort : p }
       .uniq
       .select { |p| File.file?(p) }
  end

if paths.empty?
  warn "No post files found."
  exit 1
end

if encoding_report
  n = report_encoding_issues(paths)
  if n.positive?
    warn "\n#{n} file(s) are not valid UTF-8 on disk. Re-save as UTF-8 (no BOM) or remove binary bytes."
    warn "Editor: VS Code status bar encoding;  vim: :set fileencoding=utf-8"
    exit 1
  end
  puts "Encoding report: all #{paths.size} file(s) are valid UTF-8."
  exit 0
end

errors = 0
paths.each do |path|
  body = strip_front_matter(read_post_as_utf8(path, verbose: verbose))
  raw_tag_depth_warning(path, body) if verbose

  Liquid::Template.parse(body)
  puts "OK #{path}" if verbose
rescue Liquid::SyntaxError => e
  errors += 1
  warn "#{path}: #{e.message}"
rescue ArgumentError => e
  errors += 1
  warn "#{path}: #{e.message}"
  warn "#{path}: hint — UTF-8 issue after front matter? run:  #{$PROGRAM_NAME} --encoding-report"
end

if errors.positive?
  warn "\n#{errors} file(s) failed Liquid parse."
  warn "For invalid UTF-8 locations:  #{$PROGRAM_NAME} --encoding-report"
  exit 1
end

puts "Checked #{paths.size} post(s), Liquid parse OK."
exit 0
