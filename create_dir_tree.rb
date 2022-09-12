require 'date'
require './setlists'

def create_dir_tree(prefix)
  Dir.mkdir prefix unless File.exists?("#{prefix}")

  # create the top-level year dirs
  setlists = Setlists.new
  years = setlists.hashie.setlists.reduce([]) do |years, show|
    date = Date.strptime(show.eventDate, '%d-%m-%Y')
    years << date.year unless years.include?(date.year)
    years
  end.each do |year|
    path = "#{prefix}/#{year}"
    Dir.mkdir path unless File.exists?(path)
  end

  # create the individual show dirs
  setlists.each do |show|
    date = Date.strptime(show.eventDate, '%d-%m-%Y')
    catalog_date = "#{date.year}-#{'%02d' % date.month}-#{'%02d' % date.day}"
    path = "#{prefix}/#{date.year}/#{catalog_date}"
    Dir.mkdir path unless File.exists?(path)
  end
end
