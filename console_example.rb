#!/usr/bin/env ruby

require File.expand_path("../lib/csvmonster", __FILE__)

input_file = nil
delimiter = nil
ARGV.each_with_index do |arg, i|
  input_file = ARGV[i+1] if arg.to_s.strip =~ /^\-i$/
  delimiter  = ARGV[i+1] if arg.to_s.strip =~ /^\-d$/
end

unless input_file.nil?
  csv_monster = CSVMonster.new(input_file , delimiter)
  result = csv_monster.parse_csv
  puts "CSV Monster finished crunching your CSV file \"#{input_file}\" Successfully!\n\n"
  puts "The result set has #{result.size} records.\n\n"
  puts "The CSV Monster recognized the following set of attributes:\n#{csv_monster.object_attributes.map{|a| a.to_sym}}\n\n"
  puts "This is a sample of the csv data:\n#{result[2].inspect}\n\n"
else
  puts "Oops! it seems that the input file doesn't exist, or, may be it was kidnapped by Loki, the bad brother of Thor!"
end
