# Fcm notifications

---

##### This is a Flutter package for sending push notifications using Firebase Cloud Messaging (FCM) service. The package provides a simple and easy-to-use interface for sending notifications to specific devices or topics.

## Features

- Send notifications to individual devices or topics
- Specify custom data payloads to be included with the notification
- Easily configure FCM credentials and notification settings

## Installation

To use this package, add `fcm_notification` as a dependency in your pubspec.yaml file.

```yaml
fcm_notification:
  git:
    url: https://github.com/albertoodev/fcm_notification.git
```

Then run `flutter pub get` to install the package.
## Getting started
add this lines in `android\app\main\AndroidManifest.xml`
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
## Contributing
 Contributions are welcome! Please submit any bug reports, feature requests, or pull requests through the Github repository.
