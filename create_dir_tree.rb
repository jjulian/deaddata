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
    Dir.mkdir "#{prefix}/#{year}" unless File.exists?("#{prefix}/#{year}")
  end

  # create the individual show dirs
  setlists.each do |show|
    date = Date.strptime(show.eventDate, '%d-%m-%Y')
    catalog_date = "#{date.year}-#{'%02d' % date.month}-#{'%02d' % date.day}"
    Dir.mkdir "#{prefix}/#{date.year}/#{catalog_date}" unless File.exists?("#{prefix}/#{date.year}/#{catalog_date}")
  end
end
