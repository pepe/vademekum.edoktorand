require 'yaml'

Document.destroy_all

string = File.read(File.join(File.dirname(__FILE__), 'docs.yml'))
docs = YAML::load(string)

puts "#{docs.size} documents to create"
docs.each do |doc|
  puts "Creating '#{doc['name']}' document"
  Document.create(doc)
end
