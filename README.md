#  Photo Tracker

App that presents photos based on device location when user is walking. App allows putting the app in background and walk without viewing the screen. It tracks device location every 100 meters.

## Instructions:
Open project with Xcode, build and run :)
If you are using a simulator use Features > Location > (City run | City bicycle ride) to emulate behaviour.

## Comments:
- App saves in background locations and it's when user puts app in foreground and see List when images are fetched. In this way resources are used in a better way as not all images might be seen. An improvement to this would be implementing some caching system where images that have been fetched are saved so they are not needed to be fetched again saving more resources.
- Core Location is a framework where it makes sense to use Combine in order to make the app being reactive for each position is returned. That is why the app has been built using SwiftUI and Combine
- I thought about using CoreData, and actually I was able to get it working too, but I thought adding that framework would be too much for this pourpose (I could also update the project to use Core Date if needed)
- I opted for a MVVM architecture for simplicity.
