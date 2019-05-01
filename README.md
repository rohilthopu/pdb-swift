#  PAD DB (iOS)

PAD DB is a pet project of mine to provide access to Puzzle and Dragons (PAD) data in an alternative source to already existing platforms. This specific repository refers to the
mobile implementation of the project that runs on devices running iOS 10+. 

The app provides access to Guerrilla Dungeons, Monsters, Dungeon information, and an arbitrary Reddit karma leaderboard for the PAD subreddit.


<img src="Images/iphone_max_home.png" height="20%" width="20%">
<img src="Images/ney_1.png" height="20%" width="20%">

## Languages and Technologies

The app was initially written entirely in Swift 4 but has now been upgraded to Swift 5. 

I try to keep the number of dependencies to a minimum.

Here is a list of technologies the app uses:
1. Swift 4/5
2. CoreData
3. SwiftyJSON - Easier JSON parsing (similar to Python)
4. Kingfisher - Local image caching
5. QuickTableViewController - Easy settings menu generation

## Installation

If you want to install official releases, which I encourage, you can download them on [TestFlight](https://testflight.apple.com/join/JcBpe6eL). Hopefully I can get around to putting this on the App Store in the next month.

If you want to install directly to device from source, you're free to clone this repository and install via Xcode, however, there is one file missing that contains references to my own API endpoints, which currently are not public. It will effectively render the app useless without them. I will provide them if you plan on contributing, but because the backend is still pretty much under construction, the data structure
might change more often than I'd like, hence why it's not public.

Assuming you have CocoaPods installed, these can easily be installed via the Podfile provided by running

    pod install

from the root directory of the project in your choice of terminal. You will need to install these for the project to build in Xcode.

## Disclaimer

This app and repository is in need of massive refactoring and is very much still a work in progress. I will be updating the documentation and contributing information shortly. I'll also be adding in a couple images for viewing without downloading the app.



