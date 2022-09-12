require 'json'
require 'date'
require './setlists'
require 'google_search_results'
require './create_dir_tree'

exit 1 unless ENV["SERP_API_KEY"]
GoogleSearch.api_key = ENV["SERP_API_KEY"]

# create the data dirs to hold the search results
data_dir = 'data'
create_dir_tree(data_dir)

# do a google image search for each show, save the results in a file
setlists = Setlists.new
setlists.each do |show|
  date = Date.strptime(show.eventDate, '%d-%m-%Y')
  catalog_date = "#{date.year}-#{'%02d' % date.month}-#{'%02d' % date.day}"
  query = "\"grateful dead\" #{date.strftime('%B %d, %Y')} \"#{show.venue.name}\" #{show.venue.city.name} #{show.venue.city.stateCode}"
  puts query
  next
  search = GoogleSearch.new(
    q: query, 
    tbm: 'isch'
  )
  # slow down here https://serpapi.com/faq/general/what-s-your-guaranteed-throughput
  json_results = search.get_json
  results_fname = "#{data_dir}/#{date.year}/#{catalog_date}/results-#{Time.now.to_i}.json"
  File.write(results_fname, json_results)
  puts "saved search results for #{catalog_date} to #{results_fname}"
end


