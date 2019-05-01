#  PAD DB (iOS)

PAD DB is a pet project of mine to provide access to Puzzle and Dragons (PAD) data in an alternative source to already existing platforms. This specific repository refers to the
mobile implementation of the project that runs on devices running iOS 10+. 

The app provides access to Guerrilla Dungeons, Monsters, Dungeon information, and an arbitrary Reddit karma leaderboard for the PAD subreddit.

**The entire app was developed programatically so there is no storyboard involvement here. Tread carefully reading through the sludge of loops that set auto-layout constraints**

<div display="flex" align="center">
    <img src="Images/iphone_max_home.png" height="30%" width="30%">
    <img src="Images/ney_1.png" height="30%" width="30%">
    <img src="Images/ney_2.png" height="30%" width="30%">
</div>

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

## Contributions

If you would like to contribute, please open an issue first to discuss what you'd like to change so that I have a heads up. I will need to provide access to my API endpoints for you to run the app on your local machine as well.

Contributions are more than welcome, but I expect Pull Requests to follow good programming practices and try to adhere to the style that the project is currently in. 

## Small Disclaimer

Just a heads up, but this app and repository is in need of massive refactoring and is very much still a work in progress. The codebase will probably be subject to a whole lot of change over time.



