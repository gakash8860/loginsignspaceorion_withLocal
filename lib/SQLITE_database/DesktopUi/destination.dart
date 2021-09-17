import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Destination {
  const Destination(this.id, this.title, this.icon);
  final int id;
  final String title;
  final IconData icon;
}

const List<Destination> allDestinations = [
  Destination(0, 'Home', Icons.home),
  Destination(1, 'Add Place', FontAwesomeIcons.user),
  Destination(2, 'Sub Access Page', Icons.people),
  Destination(3, 'Temp Access Page', Icons.people),
  Destination(4, 'Show Temp User', Icons.people),
  Destination(5, 'Show Sub User', Icons.people),
  Destination(6, 'Bill Predection', Icons.people),
  Destination(7, 'Schedule Pin', Icons.people),
  Destination(8, 'Setting Page', Icons.people),
  Destination(9, 'About Page', Icons.people),
];
