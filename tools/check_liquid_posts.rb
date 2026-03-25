#!/usr/bin/env ruby
# frozen_string_literal: true

# Parse each post body with Liquid (Jekyll runs Liquid on post content before Markdown).
# Catches unknown tags, stray {% endraw %}, invalid {{ }} expressions, etc.
#
# Usage (repository root):
#   bundle exec ruby tools/check_liquid_posts.rb   # preferred (uses Gemfile lock)
#   ruby tools/check_liquid_posts.rb                # if the `liquid` gem is already installed
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

def usage!
  warn "Usage: #{$PROGRAM_NAME} [--verbose] [_posts/foo.markdown ...]"
  exit 64
end

def strip_front_matter(text)
  return text unless text.start_with?("---\n")

  m = text.match(/\A---\s*\n.*?\n---\s*\n/m)
  m ? text.byteslice(m.end(0)..-1) : text
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

errors = 0
paths.each do |path|
  body = strip_front_matter(File.read(path, encoding: "UTF-8"))
  raw_tag_depth_warning(path, body) if verbose

  Liquid::Template.parse(body)
  puts "OK #{path}" if verbose
rescue Liquid::SyntaxError => e
  errors += 1
  warn "#{path}: #{e.message}"
end

if errors.positive?
  warn "\n#{errors} file(s) failed Liquid parse."
  exit 1
end

puts "Checked #{paths.size} post(s), Liquid parse OK."
exit 0
