#!/usr/bin/env ruby

require_relative "./beta_pack_generator"
require "optionparser"

options = {remove_basics: false, sort: false}
OptionParser.new do |opts|
  opts.banner = "Usage: ruby gen.rb [options] PACKS_PER_POOL NUM_POOLS"
  opts.on_tail("-h", "--help", "Show this message") do
    puts opts
    exit
  end
  opts.on("-r", "--remove_basics", "Remove basic lands after generating packs.") do
    options[:remove_basics] = true
  end
  opts.on("-s", "--sort", "Sort each pool alphabetically.") do
    options[:sort] = true
  end
end.parse!

packs_per_pool = ARGV[0].to_i
num_pools = ARGV[1].to_i

puts "Generating #{num_pools} pools of #{packs_per_pool} boosters each."
if num_pools == 0 && packs_per_pool == 0
  puts "Try gen.rb --help for info"
end

gen = BetaPackGenerator.new

(1..num_pools).to_a.each do |i|
  pool = gen.packs(packs_per_pool)
  if options[:remove_basics]
    pool = gen.remove_basics(pool)
  end
  if options[:sort]
    pool.sort!
  end
  File.write "pool#{i}", pool.join("\n")
end

