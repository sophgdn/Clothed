# Clothed
An IOS application that uses machine learning to detect clothing and fabric patterns. This application was designed to help low vision and visually impaired individuals organise and keep track of their clothing. This is a work in progress, some features may be only partially implemented. 

Built with the help of libraries from <a href="https://github.com/mortenjust/trainer-mac">@mortenjust</a> and <a href="https://github.com/tensorflow/tensorflow">@TensorFlow.</a>

![Clothed icon](https://s3-ap-southeast-2.amazonaws.com/www.sophiegardner.me/githubImages/clothed-icon-github.png)

## To run on a phone or tablet
* Clone or download this repository
* Download Xcode Version 9.3 or later and open `Tensorswift.xcodeproj`

### In Xcode
* Once the project is open, under Tensorswift > Identity, change the Bundle identifier to `com.YOURNAME.Tensorswift`. Under Tensorswift > Signing, change the Team to your Apple ID login and select `YOUR ID (Personal Team)` 
* Connect your phone to the computer and in the menu bar under Product > Destination select your device
* Select Product > Run and the application will be installed to your device

### On your device
* Open the application and you will recieve an alert about an untrusted developer
* Go to Settings > General > Device Management, then tap your your Apple ID and select "Trust Clothed" 

## UI design 
![Clothed UI mockups](https://s3-ap-southeast-2.amazonaws.com/www.sophiegardner.me/githubImages/clothed-github-1.png)
![Clothed UI mockups](https://s3-ap-southeast-2.amazonaws.com/www.sophiegardner.me/githubImages/clothed-github-2.png)
![Clothed UI mockups](https://s3-ap-southeast-2.amazonaws.com/www.sophiegardner.me/githubImages/clothed-github-4.png)


## To do 
- [x] Get image recognition working for patterns
- [x] Displays tag when modle is > %70 confidence 
- [x] Get text to speak working for `labels`
- [ ] Get image recognition working for colours
- [ ] Impliment `Correct` and `Incorrect`
- [ ] Create custom tagging system
