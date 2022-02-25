library fcm_notification;

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

part 'local_notification/local-notification-service.dart';

class FcmNotifications {
  static late final String _fcmKey;
  static late final String _channelId;

  static void initialize({
    required String fcmKey,
    required String channelId,
    required String channelName,
  }) {
    _fcmKey = fcmKey;
    _channelId = channelId;
    LocalNotificationsService.initialize(
        channelId: channelId, channelName: channelName);
  }

  static showNotification(RemoteMessage message, {required OnClick onClick}) {
    LocalNotificationsService.show(message, onClick);
  }

  static Future<void> sendNotification({
    required String title,
    required String body,
    List<String>? tokens,
    String? topic,
    required Map<String, dynamic> data,
    String? image,
  }) async {
    Map<String, dynamic> _body = {
      'data': {
        'click_action': 'FLUTTER_NOTIFICATION-CLICK',
        ...data,
      },
      'priority': 'high',
      'notification': {
        'title': title,
        'body': body,
        'android_channel_id': _channelId,
        'sound': 'default',
      },
    };
    if (tokens != null && tokens.isNotEmpty) {
      _body.addAll({
        'registration_ids': tokens,
      });
    }
    if (topic != null) {
      _body.addAll({
        'to': topic,
      });
    }
    if (image != null) {
      _body['notification'].addAll({
        'image': image,
      });
    }

    await http.post(
      Uri.parse('https://fcm.googleapis.com/fcm/send'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'key=$_fcmKey'
      },
      body: jsonEncode(_body),
    );
  }

  /// get device fcm token
  static Future<String?> getToken() async =>
      await FirebaseMessaging.instance.getToken();

  static onMessage(Function(RemoteMessage msg) messageFunction) {
    FirebaseMessaging.onMessage.listen((message) {
      messageFunction(message);
    });
  }

  static getInitialMessage(Function(RemoteMessage msg) messageFunction) {
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      messageFunction(message!);
    });
  }

  static onMessageOpenedApp(Function(RemoteMessage msg) messageFunction) {
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      messageFunction(message);
    });
  }
}
