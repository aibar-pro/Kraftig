# Kraftig

**Kraftig** (“powerful" in German) is a mobile application that connects users with wellbeing experts. It enables them to receive customized fitness and nutrition plans and online coaching services tailored to their needs, goals, and available equipment. The app facilitates interaction between users and trainers and supports the management of subscription payments.

It's a playground project inspired by one of the projects I participated in as a developer. Given that I can’t just copy-paste the production code, I recreate the basic concepts by writing something similar to expand my GitHub portfolio and provide code samples for the sake of job seeking.

## App Demo GIF
<img src="./resources/Kraftig_demo.gif" alt="App demo" width="350" height="auto"><br> App demo

## Features
* **User Registration**: Sign up using a mobile number (not validating rn).
* **Profile Management**: Users can enter their measurements and upload photos to encrypted storage.
* **Custom Wellbeing Plans**: Users can request customized fitness or nutrition plans or online coaching from certified professionals.
* **Payment Integration**: Supports one-time and recurring payments for selected services (won't implement; proprietary acquiring widget must be considered)

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