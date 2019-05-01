#  PAD DB (iOS)

PAD DB is a pet project of mine to provide access to Puzzle and Dragons (PAD) data in an alternative source to already existing platforms. This specific repository refers to the
mobile implementation of the project that runs on devices running iOS 10+. 

The app provides access to Guerrilla Dungeons, Monsters, Dungeon information, and an arbitrary Reddit karma leaderboard for the PAD subreddit.


## Languages and Dependencies

The app was initially written entirely in Swift 4 but has now been upgraded to Swift 5. 

Here is a list of technologies the app uses

1. Swift 4/5
2. CoreData
3. SwiftyJSON - Easier JSON parsing (similar to Python)
4. Kingfisher - Local image caching

## Disclaimer

This app and repository is in need of massive refactoring and is very much still a work in progress. I will be updating the documentation and contributing information shortly. I'll also be adding in a couple images for viewing without downloading the app.


To those who want to contribute or clone the app for local use, there is one file missing that contains references to my own API endpoints, which currently are not public. It
will effectively render the app useless without them. I will provide them if you plan on contributing, but because the backend is still pretty much under construction, the data structure
might change more often than I'd like, hence why it's not public.


