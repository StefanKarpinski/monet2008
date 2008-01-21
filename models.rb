#!/usr/bin/ruby

require 'yaml'

models = YAML.load_file("models.yaml")

bullet = '\\raisebox{1.5pt}{$\\centerdot$}'
fixups = {
  :Node   => [ 8,'2.5pt'],
  :Flow   => [11,'2.5pt'],
  :Packet => [ 5,'2.5pt']
}

puts <<'HEADER'
\begin{tabular}{|c|c|p{4.3in}|}
\multicolumn{1}{c}{\textbf{Level}} &
\multicolumn{1}{c}{\textbf{Model}} &
\multicolumn{1}{c}{\textbf{Overridden and inherited properties}} \\[2pt]
HEADER
models.each do |l|
  level = l.keys.first
  mods = l[level]
  fixup = fixups[level.to_sym]
  puts '\hline'
  puts "\\multirow{#{fixup.first}}{*}[#{fixup.last}]{#{level}}"
  mods.each_with_index do |m,j|
    model = m.keys.first
    items = m[model]
    items = [items] unless items.is_a?(Array)
    puts "& \\multirow{1}{*}[-0.05em]{#{model}} &"
    puts '\begin{minipage}[l]{4.3in}'
    puts '\vspace{2pt}'
    items.each_with_index do |item,k|
      item.gsub!(/&/,'\\\&')
      item.gsub!(/\*\s*$/,'\raisebox{1pt}{\footnotesize*}')
      line_end = (k < items.size-1) ? ' \\\\' : ''
      puts "#{bullet} #{item}" + line_end
    end
    puts '\vspace{2pt}'
    puts '\end{minipage} \\\\'
    puts '\cline{2-3}' if j < models.size
  end
end
puts <<'FOOTER'
\hline
\end{tabular}
FOOTER
