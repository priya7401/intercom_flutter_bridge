import 'package:firebase_messaging/firebase_messaging.dart';

FirebaseMessaging messaging = FirebaseMessaging.instance;

void setupFirebase() async {
  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  print('User granted permission: ${settings.authorizationStatus}');

  messaging.getToken().then((value) {
    print("============== FCM Token: $value");
  });

  // handle notifications received when app is in killed state
  RemoteMessage? initialMessage =
      await FirebaseMessaging.instance.getInitialMessage();

  if (initialMessage != null) {
    // handle notification onTap
    print('Message data: ${initialMessage.data}');
  }

  // handle foreground messages
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print('================ foreground message received ================');
    print('Got a message whilst in the foreground!');
    print('Message data: ${message.data}');

    if (message.notification != null) {
      print('Message also contained a notification: ${message.notification}');
    }
  });

  ///handle background messages
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    print('================ background message received ================');
    print('Message data: ${message.data}');
  });
}
