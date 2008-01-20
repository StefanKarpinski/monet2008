#!/usr/bin/ruby

require 'yaml'

models = YAML.load_file("models.yaml")

models.each do |l|
  level = l.keys.first
  mods = l[level]
  puts '\noindent'
  puts "\\textbf{#{level}:}"
  puts '\begin{itemize}'
  mods.each do |m|
    mod = m.keys.first
    items = m[mod]
    puts "  \\item \\textit{#{mod}}"
    puts '  \begin{itemize}'
    items.each do |item|
      item.gsub!(/&/,'\\\&')
      puts "    \\item #{item}"
    end
    puts '  \end{itemize}'
  end
  puts '\end{itemize}'
end
