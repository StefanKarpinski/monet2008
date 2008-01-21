#!/usr/bin/ruby

require 'yaml'

properties = YAML.load_file("properties.yaml")

bullet = '\\raisebox{1.5pt}{$\\centerdot$}'

properties.each do |l|
  level = l.keys.first
  props = l[level]
  puts "\\textbf{\\submodel{#{level}:}}\\\\"
  props.each do |prop|
    puts "\\hspace*{1ex}#{bullet}~#{prop}\\\\"
  end
end
