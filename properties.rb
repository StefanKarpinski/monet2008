#!/usr/bin/ruby

require 'yaml'

properties = YAML.load_file("properties.yaml")

bullet = '\\raisebox{1.5pt}{$\\centerdot$}'

properties.each_with_index do |l,i|
  puts '[3pt]' if i > 0
  level = l.keys.first
  props = l[level]
  puts "\\textbf{\\class{#{level}:}}\\\\"
  props.each do |prop|
    puts "\\hspace*{1ex}#{bullet}~#{prop}\\\\"
  end
end
