require 'json'
require 'date'
require './setlists'
require 'google_search_results'
require 'create_dir_tree'

exit 1 unless ENV["SERP_API_KEY"]
GoogleSearch.api_key = ENV["SERP_API_KEY"]

# create the data dirs to hold the search results
create_dir_tree('data')

# do a google image search for each show, save the results in a file (to avoid future api hits)
if false
  setlists = Setlists.new
  setlists.each do |show|
    date = Date.strptime(show.eventDate, '%d-%m-%Y')
    catalog_date = "#{date.year}-#{'%02d' % date.month}-#{'%02d' % date.day}"
    # TEMP
    if date.year == 1975
      query = "\"#{catalog_date}\" #{date.strftime('%B %d, %Y')} \"#{show.venue.name}\" #{show.venue.city.name} #{show.venue.city.stateCode}"
      search = GoogleSearch.new(
        q: query, 
        tbm: 'isch'
      )
      json_results = search.get_json
      fname = "data/#{date.year}/#{catalog_date}/results-#{Time.now.to_i}.json"
      File.write(fname, json_results)
      puts "wrote #{fname}"
    end
  end
end

# TODO generate html for easy viewing



