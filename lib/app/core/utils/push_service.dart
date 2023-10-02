import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class PushService {
  static final PushService ins = PushService._();

  PushService._();

  static final _notification = FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    _notification.initialize(
      const InitializationSettings(
        android: AndroidInitializationSettings("bell"),
      ),
      onDidReceiveNotificationResponse: _onDidReceiveNotifications,
      // onDidReceiveBackgroundNotificationResponse:
      //     _onDidReceiveBackgroundNotificationResponse,
    );
  }

  Future showNotification({
    int id = 0,
    String? title,
    String? body,
    String? payload,
  }) async {
    final details = await _notificationDetails();
    return _notification.show(id, title, body, details, payload: payload);
  }

  Future<NotificationDetails> _notificationDetails() async {
    return const NotificationDetails(
      android: AndroidNotificationDetails(
        "channel id",
        "channel name",
        channelDescription: "channel des",
        priority: Priority.max,
        importance: Importance.max,
        playSound: true,
      ),
      iOS: DarwinNotificationDetails(),
    );
  }

  void clearAllNotify() {
    _notification.cancelAll();
  }

  void _onDidReceiveNotifications(NotificationResponse details) {
    // khi nhấn vô cái noti thì làm gì nè
  }

  void _onDidReceiveBackgroundNotificationResponse(
      NotificationResponse details) {
    // khi nhấn vô cái noti mà app đang ở background
  }
}
