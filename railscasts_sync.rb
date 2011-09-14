#!/usr/bin/ruby

# Idea from http://maximilianoguzman.com.ar/2009/05/26/railscasts-downloader
# Improved by Kulbir Saini

require 'rss'

SIZE_THRESHOLD = 1024000

# Check if file already exists
def valid_file(filename)
  File.exist?(filename) and File.size?(filename) and File.size?(filename) > SIZE_THRESHOLD
end

# Create a temp directory for temporary files
def check_temp
  Dir.mkdir('temp') unless File.directory?('temp') 
end

check_temp()

puts 'Downloading rss index...'

rss_string = open('http://feeds.feedburner.com/railscasts').read
rss = RSS::Parser.parse(rss_string, false)
videos_urls = rss.items.map { |it| it.enclosure.url }.reverse

videos_filenames = videos_urls.map {|url| url.split('/').last }
existing_filenames = Dir.glob('*.mp4').select{ |filename| valid_file(filename) }
missing_filenames = videos_filenames - existing_filenames
puts "Downloading #{missing_filenames.size} missing videos..."

missing_videos_urls = videos_urls.select { |video_url| missing_filenames.any? { |filename| video_url.match filename } }

missing_videos_urls.each do |video_url|
  filename = video_url.split('/').last
  next if valid_file(filename)
  puts "Syncing : #{filename} ..."
  if %x(wget -c --quiet #{video_url} -O temp/#{filename}.tmp; echo $?).to_i == 0 and valid_file("temp/#{filename}.tmp")
    if %x(mv temp/#{filename}.tmp #{filename}; echo $?).to_i == 0
      puts "Synced  : #{filename}"
    else
      puts "Move Failed : temp/#{filename}.tmp => #{filename}"
    end
  else
    puts "Failed  : #{filename}"
  end
end
puts 'Finished synchronization'
