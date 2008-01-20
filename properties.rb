#!/usr/bin/ruby

require 'yaml'

properties = YAML.load_file("properties.yaml")

properties.each do |l|
  level = l.keys.first
  props = l[level]
  puts '\noindent'
  puts "\\textbf{#{level}:}"
  puts '\begin{itemize}'
  props.each do |prop|
    puts "  \\item #{prop}"
  end
  puts '\end{itemize}'
end
