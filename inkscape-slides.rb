#!/usr/bin/env ruby

require 'optparse'
require 'pathname'

IN_FILE = Pathname(ARGV.shift)

$opts = {geometry: "1280x720",
         rows: 1,
         cols: 5}

OptionParser.new do |opts|
  opts.banner = "Usage: #{$0} [options]"

  opts.on("-r", "--rows r", "number of rows (default: #{$opts[:rows]})") do |r|
    $opts[:rows] = r.to_i
  end

  opts.on("-c", "--cols c", "number of columns (default: #{$opts[:cols]})") do |c|
    $opts[:cols] = c.to_i
  end

  opts.on("-g", "--geometry g", "page geometry (default: #{$opts[:geometry]})") do |g|
    $opts[:geometry] = g
  end
end.parse ARGV

def basename
  IN_FILE.basename(IN_FILE.extname)
end

def width
  $opts[:geometry].split('x').first.to_i
end

def height
  $opts[:geometry].split('x').last.to_i
end

$opts[:cols].times do |x|
  (1-$opts[:rows]..0).each do |y|
    puts %Q{inkscape #{IN_FILE} --export-png=#{basename}-#{y.abs}-#{x}.png -a #{x*width}:#{y*height}:#{x.next*width}:#{y.next*height}}
  end
end
