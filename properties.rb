#!/usr/bin/ruby

require 'yaml'

properties = YAML.load_file("properties.yaml")

print <<-'HEADER'
\begin{table}
\small
\framebox[3.47in][l]{
\begin{minipage}[t]{3.47in}
\vspace{0.4em}
HEADER
properties.each do |level|
  name = level.keys.first
  props = level[name]
  puts "  \\textbf{#{name}:}"
  puts '  \begin{itemize}'
  props.each do |prop|
    puts "    \\item #{prop}"
  end
  puts '  \end{itemize}'
end
print <<-'FOOTER'
\vspace{0.4em}
\end{minipage}
}
\caption{Properties of simulation objects at various levels.}
\end{table}
FOOTER
