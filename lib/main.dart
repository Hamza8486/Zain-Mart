import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:mart/app/home/controller/home_controller.dart';
import 'package:mart/app/splash/splash_view.dart';
import 'package:mart/services/fcm/local_notification.dart';



late AndroidNotificationChannel channel;
late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {

  await Firebase.initializeApp();
  debugPrint('Handling a background message ${message.messageId}');
}
void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  await NotificationService().init();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  if (!kIsWeb) {
    channel = const AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifications', // title
      description:
      'This channel is used for important notifications.', // description
      importance: Importance.high,
    );
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }
  runApp(Application());
}

int _messageCount = 0;


/// The API endpoint here accepts a raw FCM payload for demonstration purposes.
String constructFCMPayload(String? token) {
  _messageCount++;
  return jsonEncode({
    'token': token,
    'data': {
      'via': 'FlutterFire Cloud Messaging!!!',
      'count': _messageCount.toString(),
      "click_action": "FLUTTER_NOTIFICATION_CLICK",
    },
    'notification': {
      'title': 'Hello FlutterFire!',
      'body': 'This notification (#$_messageCount) was created via FCM!',
    },
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Zain Mart',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),

      home: SplashView(),
    );
  }
}

/// Renders the example application.
class Application extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _Application();
}

class _Application extends State<Application> {
  String? _token;
  String FCM_TOKEN = "";
  bool isNotification = false;

  late Stream<String> _tokenStream;

  void setToken(String? token) {
    debugPrint('FCM Token: $token');
    setState(() {
      _token = token;
      FCM_TOKEN = token!;
    });
    debugPrint('******************************************');
    debugPrint('FCM Token: ${FCM_TOKEN}');
    debugPrint('******************************************');
  }
  void messagePop() {
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      debugPrint('A new onMessageOpenedApp event was published!     $message');
    });
  }

  @override
  void initState() {
    super.initState();
    messagePop();
    FirebaseMessaging.instance
        .getToken(
        vapidKey:
        'BGpdLRsMJKvFDD9odfPk92uBg-JbQbyoiZdah0XlUyrjG4SDgUsE1iC_kdRgt4Kn0CO7K3RTswPZt61NNuO0XoA')
        .then(setToken);
    _tokenStream = FirebaseMessaging.instance.onTokenRefresh;
    _tokenStream.listen(setToken);
    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage? message) async {
      if (message != null) {}
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      debugPrint("Received...");
      Get.put(HomeController()).homeData(

      );
      Get.put(HomeController()).orderAllData();


      // if(message.data["type"]=="Order Created")
      // {
      //   debugPrint("Hamza...");
      //   Get.put(HomeBusinessController()).topOrderDataFilter(
      //       tokenId: Get.put(HomeBusinessController()).token
      //   );
      // }
      debugPrint(message.data.toString());

      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null && !kIsWeb) {
        NotificationService().showNotifications(id: 1,title: message.notification!.title,body: message.notification!.body);
        setState(() {

          isNotification = true;
          //ApiConstants.bidSlug = message.data["bid"].toString();
        });
        debugPrint(isNotification.toString());

      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MyApp();
  }
}
