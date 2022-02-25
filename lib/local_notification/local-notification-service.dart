part of fcm_notification;

typedef OnClick = Function(Map<String, dynamic> data);
typedef MessageFunction = Function(RemoteMessage message);

class LocalNotificationsService {
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();
  static String? _channelId;
  static String? _channelName;
  static OnClick? _onClick;

  static void initialize(
      {required String channelId, required String channelName}) {
    _channelName = channelName;
    _channelId = channelId;
    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
    );
    _notificationsPlugin.initialize(initializationSettings,
        onSelectNotification: (String? payload) {
      if (payload != null) {
        Map<String, dynamic> data = jsonDecode(payload);
        _onClick!(data);
      }
    });
  }

  static void _showWithImage(RemoteMessage message, OnClick onClick) async {
    _onClick = onClick;
    final ByteArrayAndroidBitmap _image =
        ByteArrayAndroidBitmap(await _getByteArrayFromUrl(
      message.notification!.android!.imageUrl!,
    ));

    NotificationDetails notificationDetails = NotificationDetails(
      android: AndroidNotificationDetails(
        _channelId!,
        _channelName!,
        importance: Importance.max,
        priority: Priority.high,
        styleInformation: BigPictureStyleInformation(
          _image,
          htmlFormatContentTitle: true,
          htmlFormatSummaryText: true,
          hideExpandedLargeIcon: true,
        ),
        largeIcon: _image,
      ),
    );
    _notificationsPlugin.show(
      DateTime.now().microsecond,
      message.notification!.title!,
      message.notification!.body!,
      notificationDetails,
      payload: jsonEncode(message.data),
    );
  }
  static void _showWithoutImage(RemoteMessage message, OnClick onClick) {
    _onClick = onClick;
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
       message.notification!.title!,
      message.notification!.body!,
  notificationDetails,
      payload: jsonEncode(message.data),
    );
  }

  static _throw() {
    if (LocalNotificationsService._channelName == null ||
        LocalNotificationsService._channelId == null) {
      throw ('channelName and channelId can not be null');
    }
  }

  static Future<Uint8List> _getByteArrayFromUrl(String url) async {
    final http.Response response = await http.get(Uri.parse(url));
    return response.bodyBytes;
  }
}
