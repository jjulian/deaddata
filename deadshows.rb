#!/usr/bin/env ruby

require 'json'
require 'date'

require 'google_search_results'
GoogleSearch.api_key = ENV["SERP_API_KEY"]
query = "1970-04-03 April 03, 1970 Armory Fieldhouse, University of Cincinnati, Cincinnati, OH"
search = GoogleSearch.new(
    q: query, 
    tbm: 'isch'
)
json_results = search.get_json
File.write("#{query}-#{Time.now.to_i}.json", json_results)


exit

# https://github.com/MichaelAdamBerry/darkstar-project/tree/master/data
data = JSON.parse(File.read('./gratefulSetlist.json'))
data['setlists'].each do |show|
    date = Date.strptime(show['eventDate'], '%d-%m-%Y')
    catalog_date = "#{date.year}-#{'%02d' % date.month}-#{'%02d' % date.day}"
    puts "#{catalog_date} #{date.strftime('%B %d, %Y')} #{show['venue']['name']}, #{show['venue']['city']['name']}, #{show['venue']['city']['stateCode']}"
end
