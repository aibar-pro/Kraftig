# Kraftig

**Kraftig** (which means “powerful" in German) is a mobile application designed to connect users with personal trainers. It enables them to receive customized fitness plans and online coaching service tailored to their specific needs, goals, and available equipment. The app facilitates interaction between users and trainers and supports the management of subscription payments.

It's a playground project inspired by one of the projects I participated in as a developer. Given I can’t just copy-paste the production code, I recreate the basic concepts by writing something similar to expand my GitHub portfolio and provide code samples for the sake of job seeking.

## App Demo GIF
<img src="./resources/Kraftig_demo_20240527.gif" alt="App demo" width="350" height="auto"><br> App demo

## Features
* **User Registration**: Sign up using a mobile number (not validating rn).
* **Profile Management**: Users can enter and update their measurements and upload photos.
* **Custom Workout Plans**: Users can request customized workout plans or online coaching from certified personal trainers.
* **Payment Integration**: Supports one-time and recurring payments for workout plans or online coaching (won't implement; proprietary acquiring widget must be considered)

## Architecture
The project follows the MVVM (Model-View-ViewModel) architecture approach.

## Technical Stack
* Flutter: For cross-platform mobile app development.
* Provider: For state management and dependency injection.
* Other Flutter libraries. 

## Notes
Image picker on iOS needs the following lines to be added to the 'ios\Runner\Info.plist' file.
> \<key\>NSPhotoLibraryUsageDescription\<\/key\>  
\<string\>This app requires access to the photo library.\<\/string\>  
\<key\>NSMicrophoneUsageDescription\<\/key\>  
\<string\>This app requires access to the microphone.\<\/string\>  
\<key\>NSCameraUsageDescription\<\/key\>  
\<string\>This app requires access to the camera.\<\/string\>

The app file storage is encrypted. Create a '.env' file at the root of this project with the following content.  
> ENCRYPTION_KEY="32-char-long-file-encryption-key"  