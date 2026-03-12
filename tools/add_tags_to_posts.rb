#!/usr/bin/env ruby
# Add tags to Jekyll posts from categories and title-derived keywords.
# Run from repo root: ruby tools/add_tags_to_posts.rb

require 'yaml'

POSTS_DIR = '_posts'
MAX_TAGS = 6

def extract_topic_from_title(title)
  return nil if title.nil? || title.empty?
  s = title.to_s
  s = s.sub(/\s+in\s+Action$/i, '').sub(/\s+in\s+action$/i, '')
  s = s.sub(/-in-action$/i, '').sub(/-in-Action$/i, '')
  s = s.strip
  return nil if s.empty?
  # Prefer segment before " - " (e.g. "OpenClaw - Personal AI Assistant" -> "OpenClaw")
  s = s.split(/\s+-\s+/, 2).first.strip if s.include?(' - ')
  # Long title: take before " (" or first word (e.g. "网游创业失败全攻略 (许怡然)" -> "网游创业失败全攻略")
  s = s.split(/\s+\(/, 2).first.strip if s.length > 20 && s.include?('(')
  s = s.split(/\s+/, 2).first.strip if s.length > 25
  s
end

def extract_topic_from_filename(path)
  basename = File.basename(path, File.extname(path))
  m = basename.match(/\d{4}-\d{2}-\d{2}-(.+)/)
  return nil unless m
  topic = m[1].sub(/-in-action$/i, '').sub(/-in-Action$/i, '')
  return nil if topic.empty?
  topic
end

def normalize_categories(cats)
  return [] if cats.nil?
  Array(cats).map { |c| c.to_s.strip }.reject(&:empty?)
end

def tag_exists?(tags, t)
  tags.any? { |e| e.to_s.casecmp(t.to_s) == 0 }
end

def build_tags(front_matter, path)
  categories = normalize_categories(front_matter['categories'])
  title = front_matter['title']
  topic_from_title = extract_topic_from_title(title)
  topic_from_file = extract_topic_from_filename(path)

  tags = []
  tags << topic_from_title if topic_from_title && !tag_exists?(tags, topic_from_title)
  tags << topic_from_file if topic_from_file && !tag_exists?(tags, topic_from_file)
  categories.each { |c| tags << c unless tag_exists?(tags, c) }
  tags.uniq.first(MAX_TAGS)
end

def process_file(path)
  content = File.read(path, encoding: 'UTF-8')
  m = content.match(/\A(---\r?\n)(.*?)(\r?\n---\r?\n)(.*)\z/m)
  return 0 unless m

  open_dash, front_yaml, close_dash, body = m[1], m[2], m[3], m[4]
  begin
    front = YAML.load("---\n#{front_yaml}\n---")
  rescue => e
    $stderr.puts "Skip #{path}: YAML error #{e.message}"
    return 0
  end

  return 0 if front.nil?

  force = ARGV.include?('--force')
  if !force && front['tags'] && front['tags'].respond_to?(:any?) && front['tags'].any?
    return 0
  end

  tags = build_tags(front, path)
  return 0 if tags.empty?

  # Replace existing tags block or insert new one
  if front_yaml =~ /\ntags:\s*\n(?:  [- ].*\n)*/
    front_yaml = front_yaml.sub(/\ntags:\s*\n(?:  [- ].*\n)*/, '')
  end
  tag_lines = tags.map { |t| "  - #{t}" }.join("\n")
  insert = "\ntags:\n#{tag_lines}\n"
  new_content = "#{open_dash}#{front_yaml}#{insert}#{close_dash}#{body}"
  File.write(path, new_content)
  1
end

count = 0
Dir.glob(File.join(POSTS_DIR, '*.{markdown,md}')).each do |path|
  count += process_file(path)
end
puts "Added tags to #{count} posts."
