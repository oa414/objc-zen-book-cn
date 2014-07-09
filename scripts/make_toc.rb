#!/usr/bin/env ruby

File.open("../README.md", 'r') do |f|
  f.each_line do |line|
    forbidden_words = [
      'Table of contents', 
      'define', 
      'pragma', 
      'Zen and the Art of the Objective-C Craftsmanship']
      
    next if !line.start_with?("#") || forbidden_words.any? { |w| line =~ /#{w}/ }
     
    title = line.gsub("#", "").strip
    href = title.gsub(" ", "-").downcase
    puts "  " * (line.count("#")-1) + "* [#{title}](\##{href})"
  end
end
