# music-web-scraper
scrapes https://www.ultimate-guitar.com/ for chord progressions

data is fed to https://github.com/Chikey1/chord-generator for chord generation

## How to use:
1. use `GetSongs` to grab a list of urls for each song:
   - `#get_daily_list`
   - `#get_list`
   - `#get_key_list`
2. use `GetSongContent` to visit each song url to grab chords:
   - `#get_key_list_chords`
   - `#get_specific_key_list_chords`
3. use `GetChords` to format chords
   - `#get_key_list_chords`
   - `#get_specific_key_list_chords`

## Additional info:
- `WebScraper` you can customize the crawl delay
- `Mutex`s are awesome <3 (god bless "multi-threading")




