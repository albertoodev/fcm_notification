part of fcm_notification;

typedef DoneSendFunction = Widget? Function()?;
typedef ErrorSendFunction = Widget? Function(Object error)?;

class LocalNotificationsService {
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();
  static String? _channelId;
  static String? _channelName;

  static void initialize({required String channelId,required String channelName}) {
    _channelName = channelName;
    _channelId = channelId;
    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
    );
    _notificationsPlugin.initialize(initializationSettings,
        onSelectNotification: (String? payload) {
      if (payload != null) {}
    });
  }

  static void show(RemoteMessage message) {
    NotificationDetails notificationDetails = NotificationDetails(
      android: AndroidNotificationDetails(
        _channelId!,
        _channelName!,
        importance: Importance.max,
        priority: Priority.high,
      ),
    );
    _notificationsPlugin.show(
        DateTime.now().microsecond,
        message.notification!.title,
        message.notification!.body,
        notificationDetails);
  }
  static _throw() {
    if (LocalNotificationsService._channelName == null ||
        LocalNotificationsService._channelId == null) {
      throw ('channelName and channelId can not be null');
    }
  }
}
