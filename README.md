# Kraftig

**Kraftig** (which means “powerful" in German) is a mobile application designed to connect users with personal trainers. It enables them to receive customized fitness plans tailored to their specific needs, goals, and available equipment. The app facilitates interaction between users and trainers and supports the management of subscription payments.

It's a playground project inspired by one of the projects I participated in as a developer. Given I can’t just copy-paste the production code, I recreate the basic concepts by writing something similar to expand my GitHub portfolio and provide code samples for the sake of job seeking.

## Features
* **User Registration**: Sign up using a mobile number.
* **Profile Management**: Users can enter and update their fitness levels, goals, and available equipment.
* **Custom Workout Plans**: Users can request customized workout plans from certified personal trainers.
* **Payment Integration**: Supports one-time and installment payments for workout plans.

## Architecture
The project follows the MVVM (Model-View-ViewModel) architecture approach.

## Technical Stack
* Flutter: For cross-platform mobile app development.
* Provider: For state management and dependency injection.

## Notes
Updated 'Info.plist' 
> <key>NSPhotoLibraryUsageDescription</key>
> <string>This app requires access to the photo library.</string>
> <key>NSMicrophoneUsageDescription</key>
> <string>This app requires access to the microphone.</string>
> <key>NSCameraUsageDescription</key>
> <string>This app requires access to the camera.</string>