import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

void main() => runApp(MaterialApp(
      home: FlutterNotification(),
    ));

class FlutterNotification extends StatefulWidget {
  const FlutterNotification({Key key}) : super(key: key);

  @override
  _FlutterNotificationState createState() => _FlutterNotificationState();
}

class _FlutterNotificationState extends State<FlutterNotification> {
  FlutterLocalNotificationsPlugin fltrNotification;

  @override
  void initState() {

    super.initState();
    var androidInit = new AndroidInitializationSettings('logo');
    var iosInit = new IOSInitializationSettings();
    var initializationSettings =
        new InitializationSettings(androidInit, iosInit);
    fltrNotification = new FlutterLocalNotificationsPlugin();
    fltrNotification.initialize(initializationSettings,
        onSelectNotification: notificationSelected);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: ElevatedButton(
          onPressed: showNotification, child: Text('Flutter Notification')),
    ));
  }

  Future showNotification() async {
    var androidDetails = await AndroidNotificationDetails(
        "Channel id", "Check ", "This is Notification",
        importance: Importance.Max);
    var IOSDetails = await IOSNotificationDetails();
    var generalNotificationDetails =
        new NotificationDetails(androidDetails, IOSDetails);
    // await fltrNotification.show(0, "Task", "Done", generalNotificationDetails,payload: "Task14");
      var scheduleTime= DateTime.now().add(Duration(seconds: 5));
      fltrNotification.schedule(0, "Task", "Scheduled Notification",scheduleTime,generalNotificationDetails);

  }

  Future notificationSelected(String payload) {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: Text("Notification Clicked"),
            ));
  }
}
