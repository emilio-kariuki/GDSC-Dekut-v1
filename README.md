# GDSC DeKUT
GDSC DeKUT is a community based mobile application built on the flutter framework to help unite the tech Community in `Dedan Kimathi University` by helping the get access to upcoming events, resources, news, tech groups, and the leads contacts to allow them to contact them incase of any challenge in their learning process.
> The app is built courtesy of [GDSC](https://gdsc.community.dev/dedan-kimathi-university-of-technology/)

> **Note**
> The app is not built only for GDSC but the whole tech community or anybody that feels they need to get access to resources to help them learn new and cool things

**The app is on PlayStore**

You can find the application here

*[![Play Store Badge](https://developer.android.com/images/brand/en_app_rgb_wo_60.png)](https://play.google.com/store/apps/details?id=com.gdsc.gdsc_app&hl=en&gl=US)*

## Technologies Used in the project
> The mobile application is completely built on the the `flutter` framework and `firebase` platform
 1. Flutter 
 2. Firebase
 
    . Cloud Messaging
    
    . Firebase Storage
    
    . Firebase Firestore
    
    . Authentication
    
## Project Set up
### 1. Initialize firebase
To initialize firebase we are going to use `FlutterFire` for this work as it will do all the dirty work for us

You can check more about `flutterfire` from its [docs](https://firebase.flutter.dev/docs/cli/)

> **Note**
> Yoo need to have a Firebase account, incase you dont have you can create one [here](https://firebase.google.com/) 

After you have fully installed `flutterfire` you can now enable flutterfire for your project now

### 2. Enable FlutterFire for your Flutter Project
To get started, you need to run the following command in the terminal of your ide of your project's directory
```
// paste in your terminal
dart pub global activate flutterfire_cli
```
## 3. Login to Firebase from your account
> **Note**
> To get started, you need to install this you need to have [npm](https://docs.npmjs.com/downloading-and-installing-node-js-and-npm/)(node package manager installed) for you to install the `firebase tools`
```
// paste this
firebase login
```
## 4. Configure Flutterfire to your project
The FlutterFire CLI extracts information from your Firebase project and selected project applications to generate all the configuration for a specific platform.

In the root of your `application`, run the configure command:

```
//paste this
flutterfire configure
```

After you install, all the configurations in your `build.gradle` file are added and the `google-service.json` are added in the android folder and `Firebase` will be integrated in your system this will save you all the trouble of having to install all the configurations one by one and this may cause some of the things to be oeverlooked.


### 5. Event Page
All the events that are upcoming in the tech community can be found in the `event page`

<img src="https://firebasestorage.googleapis.com/v0/b/maps-333402.appspot.com/o/Screenshot_20221109-165831.jpg?alt=media&token=52b67c82-2de3-45b1-b27e-0f8df1e4d28a" alt="Event" width= 300 height= 600>

### 6. Resources Page
All the resources that the members of the tech community will be found `here`

In the `resources` page the members are given the ability to post new reources if they have any to share with the other members

<img src="https://github.com/emilio-kariuki/GDSC_DEKUT/blob/master/resources.jpg" alt="Event" width= 300 height= 600>

### 7. Groups Page
All the tech groups in the community will be found  `here`

In the `news` page the members are given the ability to get acess to the groups in the tech comunity and also the newly posted news in Community

<img src="https://github.com/emilio-kariuki/GDSC_DEKUT/blob/master/groups.jpg" alt="Event" width= 300 height= 600>

### Feel Free to contribute
You can `fork` the repo and feel free to contribute 

> **Note**
> You can reach me up on email `emilio113kariuki@gmail.com` or twitter `@EG_Kariuki`


