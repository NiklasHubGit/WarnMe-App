import 'package:firebase_messaging/firebase_messaging.dart';
import 'globals.dart';

Future<void> handleBackgroundMessage(RemoteMessage message) async {
  print('Handling a background message ${message.messageId}');
  print('Title: ${message.notification?.title}');
}

class FirebaseAPI {
  final _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initNotifications() async {
    await _firebaseMessaging.requestPermission();
    final fCMToken = await _firebaseMessaging.getToken();
    print('FCM Token: $fCMToken');
    fcmtoken = fCMToken;
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
    FirebaseMessaging.instance.subscribeToTopic("everyone").then((value) {
      print('Subscribed to topic successfully.');
    }).catchError((e) {
      print('Failed to subscribe to topic: $e');
    });
  }

  void subscribe(topic) {
    topic = topic.toString().split(".")[1];
    FirebaseMessaging.instance.unsubscribeFromTopic("mittel");
    FirebaseMessaging.instance.unsubscribeFromTopic("nah");
    FirebaseMessaging.instance.subscribeToTopic(topic).then((value) {
      print('Subscribed to topic $topic successfully.');
    }).catchError((e) {
      print('Failed to subscribe to topic: $e');
    });
  }
}
