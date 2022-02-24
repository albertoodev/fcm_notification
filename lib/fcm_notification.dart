library fcm_notification;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

part 'local_notification/local-notification-service.dart';

class FcmNotifications {
  static late final String _fcmKey;
  static void initialize({required String fcmKey,required String channelId,required String channelName,
  }) {
    _fcmKey = fcmKey;
    LocalNotificationsService.initialize(channelId: channelId, channelName: channelName);
  }

  static showNotification(RemoteMessage message) {
    _throw();
    LocalNotificationsService.show(message);
  }

  static Future<void> sendNotification({
    required String title,
    required String body,
    required String token,
    required Map<String, dynamic> data,
    DoneSendFunction enDone,
    ErrorSendFunction enError,
  }) async {
    try {
      var response = await http.post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization':
          'key=$_fcmKey'
        },
        body: jsonEncode({
          'to':
          token,
          'data': {
            'click_action': 'FLUTTER_NOTIFICATION-CLICK',
            ...data,
          },
          'priority': 'high',
          'notification': {
            'title': title,
            'body': body,
          },
        }),
      );
      if (response.statusCode == 200) {
        enDone!();
      }
    } catch (e) {
      enError!(e);
    }
  }


static _throw(){
  if(LocalNotificationsService._channelName == null || LocalNotificationsService._channelId == null){
    throw('channelName and channelId can not be null');
  }
}
}