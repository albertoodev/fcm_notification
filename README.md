<!-- 
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages). 

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages). 
-->

TODO: Put a short description of the package here that helps potential users
know whether this package might be useful for them.

## Features

TODO: List what your package can do. Maybe include images, gifs, or videos.

## Getting started
add this lines in 'android\app\main\AndroidManifest.xml'
```xml
<meta-data
    android:name="com.google.firebase.messaging.default_notification_channel_id"
    android:value="channelId"
    />
```

```xml

 <intent-filter>
     <action android:name="FLUTTER_NOTIFICATION_CLICK"/>
     <category android:name="android.intent.category.DEFAULT"/>
 </intent-filter>
```
## Usage

TODO: Include short and useful examples for package users. Add longer examples
to `/example` folder. 

## Additional information

TODO: Tell users more about the package: where to find more information, how to 
contribute to the package, how to file issues, what response they can expect 
from the package authors, and more.


