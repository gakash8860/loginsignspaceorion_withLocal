// import 'package:flutter/material.dart';
// import 'package:awesome_notifications/awesome_notifications.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:loginsignspaceorion/SQLITE_database/testinghome2.dart';
// // import 'package:notification_example/NavigationPage.dart';
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   AwesomeNotifications().initialize(
//       null,
//       [
//         NotificationChannel(
//             channelKey: 'key1',
//             channelName: 'Proto Coders Point',
//             channelDescription: "Notification example",
//             defaultColor: Color(0XFF9050DD),
//             ledColor: Colors.white,
//             playSound: true,
//             enableLights:true,
//             enableVibration: true
//         )
//       ]
//   );
//   runApp(MyApp());
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
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             ElevatedButton(
//               onPressed: (){
//                 showNotification();  //localnotification method call below
//                 // when user top on notification this listener will work and user will be navigated to notification page
//                 AwesomeNotifications().actionStream.listen((receivedNotifiction){
//                   Navigator.of(context).pushNamed(
//                     '/navigationPage',
//                   );
//                 });
//               },
//               child: Text("Local Notification"),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
// void Notify()  async{
//   String timezom = await AwesomeNotifications().getLocalTimeZoneIdentifier();
//   await AwesomeNotifications().createNotification(
//     content: NotificationContent(
//         id: 1,
//         channelKey: 'key1',
//         title: 'This is Notification title',
//         body: 'This is Body of Noti',
//         bigPicture: 'https://protocoderspoint.com/wp-content/uploads/2021/05/Monitize-flutter-app-with-google-admob-min-741x486.png',
//         notificationLayout: NotificationLayout.BigPicture
//     ),
//     schedule: NotificationInterval(interval: 2,timeZone: timezom,repeats: true),
//   );
// }
// showNotification() async {
//   var android = AndroidNotificationDetails(
//       'id', 'channel ', 'description',
//       priority: Priority.High, importance: Importance.Max);
//   var iOS = IOSNotificationDetails();
//   var platform = new NotificationDetails(android, iOS);
//   await flutterLocalNotificationsPlugin.show(
//       0, 'Flutter devs', 'Flutter Local Notification Demo', platform,
//       payload: 'Welcome to the Local Notification demo');
// }
