import 'package:flutter/material.dart';
import 'package:loginsignspaceorion/ProfilePage.dart';

import 'HomeDesktopUi.dart';
import 'contact.dart';
import 'destination.dart';

class DestinationView extends StatefulWidget {
  Destination destination;

  DestinationView(this.destination);

  @override
  State<DestinationView> createState() => _DestinationViewState();
}

class _DestinationViewState extends State<DestinationView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        alignment: Alignment.center,
        child: widget.destination.id == 0 ? DesktopHome() :  ProfilePage(),
      ),
    );
  }
}
