#parses a pack list from http://ccgdecks.com/sealed_gen.php
require 'pp'

packname = ARGV[0]

file = File.read(packname)
puts "Read #{packname}"

output = []

file.split("\n").each do |set_of_packs|
  set_of_packs.split("<tr>").delete_if(&:empty?).drop(1).each do |tr|
    td = tr.split("<td").delete_if(&:empty?)[0]
    output << td.split(">")[2].split("<")[0].strip
  end
end


puts "Writing #{packname}-out"
File.write "#{packname}-out", output.join("\n")