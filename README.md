# Grateful Dead Live Album Covers

Create album covers for every Grateful Dead show. Uses SerpApi for image search by show date and venue name. Uses imagemagick to create album art.

Grateful Dead show data comes from the [darkstar-project](https://github.com/MichaelAdamBerry/darkstar-project/tree/master/data) - thanks!

## Get Started
* Add `SERP_API_KEY` to your env (you'll need a [SerpApi](https://serpapi.com/) account to run 2000+ image search requests)
### Install local dependencies
```
bundle install
```
### Do an image search for each dead show, save search results in data dir
```
ruby fetch_images.rb
```
### Generate album art for each dead show, save artwork into output dir; create preview html as well
```
ruby generate_album_art.rb
```

## TODO
- [ ] sign up for serpapi and collect data
- [ ] generate album art; tweak results
- [ ] create html to publish generated art
