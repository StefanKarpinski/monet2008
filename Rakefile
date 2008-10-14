def options(name)
  opt = ENV[name.to_s] || ENV[name.to_s.upcase]
  opt =~ /^(?:true|t|on|1)$/
end

$verbose  = options(:verbose)  || options(:dry_run)
$no_write = options(:no_write) || options(:dry_run)

include FileUtils::Verbose if $verbose
include FileUtils::NoWrite if $no_write
include FileUtils::DryRun  if $verbose and $no_write

def run cmd
  puts cmd if $verbose
  return if $no_write
  system cmd and return
  warn cmd unless $verbose
  raise "*** Command Failed ***"
end

directory "pub"

def process_tex(r,w)
  r.each_line do |line|
    case line
    when /^\s*%/ # next
    when /^\s*\\input\{(.*?)(\.tex)?\}\s*$/
      open("#{$1}.tex"){|i| process_tex(i,w)}
    when /\\includegraphics(\[.*?\])?\{(.*?)(\.pdf)?\}/
      pre, post = $~.pre_match, $~.post_match
      opts, name = $1, $2
      pdf_src = "graphics/#{$2}.pdf"
      pdf_dst = pdf_src.downcase.gsub(/[-\/]/,'_').sub(/\.pdf$/,'.pdf')
      cp pdf_src, "pub/#{pdf_dst}"
      w.print(pre,"\\includegraphics#{opts}{#{pdf_dst}}",post)
    else w.print(line)
    end
  end
end

file "pub/paper.tex" => ["paper.tex","pub","pub/svglov3.clo","pub/svjour3.cls"] do |t|
  open("paper.tex"){|r| open(t.name,'w'){|w| process_tex(r,w)}}
end
file "pub/references.bib" => ["references.bib","pub"] do |t|
  open("references.bib"){|r| open(t.name,'w'){|w| process_tex(r,w)}}
end
file "pub/svglov3.clo" => ["svglov3.clo","pub"] do |t|
  cp "svglov3.clo", t.name
end
file "pub/svjour3.cls" => ["svjour3.cls","pub"] do |t|
  cp "svjour3.cls", t.name
end

file "pub.tar.bz2" => ["pub/paper.tex","pub/references.bib"] do |t|
  files = FileList["pub/*.{tex,bib,clo,cls,pdf}"]
  run "tar cf - #{files.join(' ')} | bzip2 -9 >#{t.name}"
end

task :default => "pub.tar.bz2"

task(:clean){ rm_rf ["pub", "pub.tar.bz2"] }
