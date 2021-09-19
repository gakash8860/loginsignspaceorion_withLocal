// import 'package:flutter/material.dart';
// import 'package:awesome_notifications/awesome_notifications.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:loginsignspaceorion/SQLITE_database/testinghome2.dart';
// import 'dart:async';
// import 'dart:convert';
// import 'dart:io';
// import 'dart:typed_data';
// import 'dart:ui';
//
// import 'package:device_info/device_info.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:http/http.dart' as http;
// import 'package:path_provider/path_provider.dart';
// import 'package:rxdart/subjects.dart';
// final BehaviorSubject<ReceivedNotification> didReceiveLocalNotificationSubject =
// BehaviorSubject<ReceivedNotification>();
//
// final BehaviorSubject<String> selectNotificationSubject =
// BehaviorSubject<String>();
//
// const MethodChannel platform =
// MethodChannel('dexterx.dev/flutter_local_notifications_example');
//
// class ReceivedNotification {
//   ReceivedNotification({
//      this.id,
//      this.title,
//      this.body,
//      this.payload,
//   });
//
//   final int id;
//   final String title;
//   final String body;
//   final String payload;
// }
//
// String selectedNotificationPayload;
// // import 'package:notification_example/NavigationPage.dart';
// Future<void> main() async {
//   // needed if you intend to initialize in the `main` function
//   WidgetsFlutterBinding.ensureInitialized();
//
//   // await _configureLocalTimeZone();
//
//   final NotificationAppLaunchDetails notificationAppLaunchDetails =
//   await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
//
//
//   const AndroidInitializationSettings initializationSettingsAndroid =
//   AndroidInitializationSettings('app_icon');
//
//   /// Note: permissions aren't requested here just to demonstrate that can be
//   /// done later
//   final IOSInitializationSettings initializationSettingsIOS =
//   IOSInitializationSettings(
//       requestAlertPermission: false,
//       requestBadgePermission: false,
//       requestSoundPermission: false,
//       onDidReceiveLocalNotification: (
//           int id,
//           String title,
//           String body,
//           String payload,
//           ) async {
//         didReceiveLocalNotificationSubject.add(
//           ReceivedNotification(
//             id: id,
//             title: title,
//             body: body,
//             payload: payload,
//           ),
//         );
//       });
//    MacOSInitializationSettings initializationSettingsMacOS =
//   MacOSInitializationSettings(
//     requestAlertPermission: false,
//     requestBadgePermission: false,
//     requestSoundPermission: false,
//   );
//
//   final InitializationSettings initializationSettings = InitializationSettings(
//     android: initializationSettingsAndroid,
//     iOS: initializationSettingsIOS,
//     macOS: initializationSettingsMacOS,
//   );
//   await flutterLocalNotificationsPlugin.initialize(initializationSettings,
//       onSelectNotification: (String? payload) async {
//         if (payload != null) {
//           debugPrint('notification payload: $payload');
//         }
//         selectedNotificationPayload = payload;
//         selectNotificationSubject.add(payload);
//       });
//   runApp(
//     MyApp(
//     ),
//   );
// }
// class MyApp extends StatelessWidget {
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       routes: {
//         // '/navigationPage' :(context)=>NavigationPage()
//       },
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: MyHomePage(),
//     );
//   }
// }
// class MyHomePage extends StatefulWidget {
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }
// class _MyHomePageState extends State<MyHomePage> {
//
//   Future<void> _showNotification() async {
//     const AndroidNotificationDetails androidPlatformChannelSpecifics =
//     AndroidNotificationDetails(
//         'your channel id', 'your channel name', 'your channel description',
//         importance: Importance.Max,
//         priority: Priority.High,
//         ticker: 'ticker');
//     const NotificationDetails platformChannelSpecifics =
//     NotificationDetails(android: androidPlatformChannelSpecifics);
//     await flutterLocalNotificationsPlugin.show(
//         0, 'plain title', 'plain body', platformChannelSpecifics,
//         payload: 'item x');
//   }
//
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             ElevatedButton(
//               onPressed: (){
//  //localnotification method call below
//                 // when user top on notification this listener will work and user will be navigated to notification page
//
//                 },
//               child: Text("Local Notification"),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
//
