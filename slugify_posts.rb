# encoding: UTF-8
require 'yaml'
require 'fileutils'
require 'date'

def read_file_without_bom(file_path)
  content = File.open(file_path, "rb") { |f| f.read }
  content.force_encoding("UTF-8")
  content.sub("\uFEFF", '')
end

def slugify(title)
  title.downcase.gsub(/[^\p{Alnum}]+/u, '-').gsub(/^-+|-+$/, '')
end

def remove_blank_lines(lines)
  lines.reject { |line| line.strip.empty? }
end

Dir.glob('_posts/*.md') do |file|
  puts "Processing: #{file}"

  lines = read_file_without_bom(file).lines(chomp: true)

  start_index = lines.index('---')
  end_index = lines[(start_index + 1)..]&.index('---') if start_index

  if start_index.nil? || end_index.nil?
    puts "No valid Front Matter start or end found in: #{file}"
    next
  end

  end_index += (start_index + 1)

  front_matter_lines = remove_blank_lines(lines[(start_index + 1)...end_index])

  begin
    front_matter = YAML.safe_load(front_matter_lines.join("\n"), permitted_classes: [Date, Time], aliases: true)
  rescue Psych::SyntaxError => e
    puts "Error parsing YAML front matter in: #{file}. Skipping file."
    next
  end

  if front_matter["title"] && !front_matter["permalink"]
    slug = slugify(front_matter["title"])
    front_matter["permalink"] = "/#{slug}/"
    puts "Adding permalink to #{file}: #{front_matter["permalink"]}"

    # front matter を新たに作成
    new_front_matter = YAML.dump(front_matter).lines.map(&:chomp)

    # 「---」はファイルにもともとあるので不要、単に front matter の中身だけ置き換える
    new_lines = lines.dup
    new_lines[(start_index + 1)...end_index] = new_front_matter

    File.write(file, new_lines.join("\n") + "\n") # 最後に改行を保証
  end
end
