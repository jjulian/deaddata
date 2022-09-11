# Grateful Dead Live Album Covers

Create album covers for every Grateful Dead show. Uses SerpApi for to do image search by show date and venue name. Uses imagemagick to create album art.

Grateful Dead show data from the [darkstar-project](https://github.com/MichaelAdamBerry/darkstar-project/tree/master/data).

## Design
A multi-step process, repeatable at any step. 
* Grateful Dead show data is in the data dir
* Do an image search for each dead show, save result in data dir
* Generate album art for each dead show, save into output dir

