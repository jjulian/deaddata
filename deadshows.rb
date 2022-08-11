#!/usr/bin/env ruby

require 'json'
require 'date'

# https://github.com/MichaelAdamBerry/darkstar-project/tree/master/data
data = JSON.parse(File.read('./gratefulSetlist.json'))
data['setlists'].each do |show|
    date = Date.strptime(show['eventDate'], '%d-%m-%Y')
    catalog_date = "#{date.year}-#{'%02d' % date.month}-#{'%02d' % date.day}"
    puts "#{catalog_date} #{date.strftime('%B %d, %Y')} #{show['venue']['name']}, #{show['venue']['city']['name']}, #{show['venue']['city']['stateCode']}"
end
