#!/usr/bin/env ruby
# Convert Markdown fenced code blocks (```lang ... ```) to Jekyll {% highlight lang %}...{% endhighlight %}
# Usage: ruby tools/convert_fenced_to_highlight.rb _posts/2019-09-02-bash-in-action.markdown

path = ARGV[0]
abort("Usage: #{$0} <path-to-post>") if path.nil? || !File.file?(path)

lines = File.readlines(path, chomp: false, encoding: "UTF-8")
out = []
i = 0
while i < lines.size
  line = lines[i]
  # Match opening fence: ```lang or ``` (lang optional)
  if line =~ /\A```(\w*)\s*\r?\n\z/
    lang = $1.empty? ? "text" : $1
    i += 1
    block = []
    while i < lines.size
      break if lines[i] =~ /\A```\s*\r?\n\z/
      block << lines[i]
      i += 1
    end
    i += 1 if i < lines.size # skip closing ```
    # Strip trailing newline from block content (endhighlight will add newline)
    block = block.join("")
    block = block.sub(/\r?\n\z/, "") if block.end_with?("\n")
    out << "{% highlight #{lang} %}\n"
    out << block
    out << "\n{% endhighlight %}\n"
    next
  end
  out << line
  i += 1
end

File.write(path, out.join(""), encoding: "UTF-8")
