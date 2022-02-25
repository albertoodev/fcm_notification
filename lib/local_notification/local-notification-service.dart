part of fcm_notification;

typedef OnClick = Function(Map<String, dynamic>);
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

  static void show(RemoteMessage message, OnClick onClick,) async {
    _onClick = onClick;
    final ByteArrayAndroidBitmap bigPicture = ByteArrayAndroidBitmap(
    await _getByteArrayFromUrl(message.notification!.android!.imageUrl!,));

    final BigPictureStyleInformation bigPictureStyleInformation =
    BigPictureStyleInformation(bigPicture,
    largeIcon: bigPicture,);
    // var _showImage;
    // if(message.notification!.android!.imageUrl != null){
    //   _showImage = DrawableResourceAndroidBitmap(
    //     message.notification!.android!.imageUrl!,
    //   );
    // }
    print('image Url ' + message.notification!.android!.imageUrl! + '\n\n^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^');
    NotificationDetails notificationDetails = NotificationDetails(
      android: AndroidNotificationDetails(
        _channelId!,
        _channelName!,
        importance: Importance.max,
        priority: Priority.high,
        largeIcon:DrawableResourceAndroidBitmap(
          message.notification!.android!.imageUrl!,
        ),
        styleInformation: bigPictureStyleInformation
      ),
    );
    _notificationsPlugin.show(
      DateTime.now().microsecond,
      message.notification!.title,
      message.notification!.body,
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
