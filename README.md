#  Photo Tracker

## Instructions:
Open project with Xcode, build and run :)

## Comments:
- App saves in background locations and it's when user puts app in foreground and see List when images are fetched. In this way resources are used in a better way as not all images might be seen. An improvement to this would be implementing some caching system where images that have been fetched are saved so they are not needed to befetched again saving more resources.
- Core Location is a framework where it makes sense to use Combine in order to make the app being reactive for each position is returned. That is why the app has been built using SwiftUI and Combine
- I thought about using CoreData, and actually I was able to get it working too, but I thought adding that framework would be too much for this pourpose (I could also update the project to use Core Date if needed)
- Althought I am confident using VIPER or Clean Swift in my day to day, and considering I used SwiftUI with Combine, I opted for a MVVM architecture for simplicity.

## Things learnt:
- Combine:
In MyWallSt we are still allowing users with iOS 12, and it's just recently when we moved to iOS 13. So at the moment I was only familiar with SwiftUI views but never worked with Combine yet. So this app has been a great challenge to start looking into it while creating something cool as a tracker app.
- Flickr API:
I have to admit I had some issues fetching images based on location as I didn't find Flickr API documentation very clear. However it's nice that it's not needed to use OAuth2 token in order to authorize search requests which has speed up the development.
Also, I am currently living in a town where even if it's beautiful there aren't many Flickr photos based on location (or Spanish people don't use to use Flickr here). So in my tests most of the times it only shows a boat in the see in all photos 😅 
- Core Location:
Last time I used Core Location I was a very junior developer using Objective-C. So I found this refresher very exciting :)

