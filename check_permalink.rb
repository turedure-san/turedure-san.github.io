Dir.glob("_posts/*.md") do |file|
  require 'yaml'
  data = YAML.load_file(file)
  if data['permalink'].is_a?(Hash)
    puts "Hash permalink found in: #{file} => #{data['permalink'].inspect}"
  end
end
