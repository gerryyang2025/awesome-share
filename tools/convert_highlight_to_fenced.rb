#!/usr/bin/env ruby
# frozen_string_literal: true

# Convert Jekyll {% highlight lang %}...{% endhighlight %} to Markdown fenced blocks
# (Chirpy / kramdown + Rouge). Wraps with {% raw %} when body would be parsed as Liquid.
#
# Usage:
#   ruby tools/convert_highlight_to_fenced.rb _posts/some-post.markdown
#   ruby tools/convert_highlight_to_fenced.rb '_posts/*.markdown'

INVALID_LANG_FALLBACK = "plaintext"

LANG_ALIASES = {
  "golang" => "go",
  "call" => INVALID_LANG_FALLBACK,
  "6circle" => INVALID_LANG_FALLBACK,
  "a" => INVALID_LANG_FALLBACK,
  "countdown" => INVALID_LANG_FALLBACK,
  "dell" => INVALID_LANG_FALLBACK
}.freeze

def normalize_lang(raw)
  l = raw.to_s.strip.downcase
  return INVALID_LANG_FALLBACK if l.empty?

  LANG_ALIASES.fetch(l, l)
end

def fence_length_for(body)
  n = 3
  body.each_line do |line|
    m = line.match(/\A(`{3,})/)
    n = [n, m[1].length + 1].max if m
  end
  n
end

def liquid_sensitive?(body)
  body.match?(/\{\{|\{%/)
end

def convert_content(text)
  out = +""
  i = 0
  while i < text.length
    m = text.match(/\{%\s*highlight\s+([^%]+?)\s*%\}/m, i)
    unless m
      out << text[i..]
      break
    end

    out << text[i...m.begin(0)]
    inner = m[1].strip
    lang = normalize_lang(inner.split(/\s+/).first || "")
    j = m.end(0)
    em = text.match(/\{%\s*endhighlight\s*%\}/m, j)
    abort("unclosed {% highlight %} starting at byte #{m.begin(0)}") unless em

    body = text[j...em.begin(0)]
    fence = "`" * fence_length_for(body)
    inner_code = body.sub(/\A\n/, "").sub(/\n\z/, "")
    block = "#{fence}#{lang}\n#{inner_code}\n#{fence}\n"

    block =
      if liquid_sensitive?(inner_code)
        "{% raw %}\n#{block}{% endraw %}\n"
      else
        block
      end

    out << block
    i = em.end(0)
  end

  out
end

def convert_file(path)
  s = File.read(path, encoding: "UTF-8")
  t = convert_content(s)
  return false if t == s

  File.write(path, t, encoding: "UTF-8")
  true
end

paths = ARGV
abort("Usage: #{$PROGRAM_NAME} <path-or-glob> [...]") if paths.empty?

files = paths.flat_map do |p|
  if File.directory?(p)
    Dir.glob(File.join(p, "**/*.{markdown,md}")).sort
  else
    Dir.glob(p).sort
  end
end.uniq

changed = 0
files.each do |f|
  next unless File.file?(f)

  changed += 1 if convert_file(f)
end

warn "Updated #{changed} file(s)."
