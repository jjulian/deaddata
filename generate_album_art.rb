require 'json'
require 'date'
require './setlists'
require 'create_dir_tree'
require 'rmagick'
include Magick

# create the data dirs to hold the generated art
create_dir_tree('out')

def generate(fnames)
  fnames = [
    '04-03-70.jpg', '19700403_0396.jpg'
  ]
  target_cols = 500 # how wide we want the final image
  target_rows = 425 # how much space to leave at the bottom
  fnames.each do |file|
    puts file
    img = Image.read(file).first
    if img.columns < target_cols || img.rows < target_rows # not perfect; small images will crop horizontally
      puts "too small"
      next
    end

    # keep the image aspect, but make it as tall as the image area
    img.change_geometry!("x#{target_rows}") { |cols, rows, i|
      puts cols, rows
      i.resize!(cols, rows)
    }

    # create a new white image and overlay the image from above
    white_bg = Image.new(target_cols, target_cols) { |options| options.background_color = 'white' }
    target = white_bg.composite(img, NorthGravity, OverCompositeOp)

    # annotate with text
    text = Draw.new
    text.pointsize = 20
    text.font = '/Users/jjulian/Library/Fonts/ChewedPenBB.otf'
    text.gravity = WestGravity
    text.fill = '#151B54' # ballpoint pen blue
    text_row = 202
    x_margin = 10
    text_height = 24
    text.annotate(target, 0, 0, x_margin, text_row, "Armory Fieldhouse, University of Cincinnati, Cincinnati, OH")
    text.annotate(target, 0, 0, x_margin, text_row + text_height, "April 3, 1970")

    target.write("final-#{file}")
  end
end

# generate album art for search results
if true
  setlists = Setlists.new
  setlists.each do |show|
    date = Date.strptime(show.eventDate, '%d-%m-%Y')
    catalog_date = "#{date.year}-#{'%02d' % date.month}-#{'%02d' % date.day}"
    if date.year == 1975
      data_dir = "data/#{date.year}/#{catalog_date}"
      Dir.children(data_dir).each do |file|
        puts catalog_date, file
        json_results = JSON.parse(File.read("data/#{date.year}/#{catalog_date}/#{file}"))
        json_results["images_results"].each do |image|
          if image["source"] =~ /grateful|dead|jerrygarcia|liveforlivemusic|flickr/
            puts image["original"]
            # TODO generate album art
          end
        end
      end
    end
  end
end

# TODO generate html for easy viewing



