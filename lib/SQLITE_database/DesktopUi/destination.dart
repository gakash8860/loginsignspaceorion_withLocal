import 'package:flutter/material.dart';

class Destination {
  const Destination(this.id, this.title, this.icon);
  final int id;
  final String title;
  final IconData icon;
}

const List<Destination> allDestinations = <Destination>[
  Destination(0, 'Home', Icons.chat),
  Destination(1, 'Add Place', Icons.bookmark),
  Destination(2, 'Setting', Icons.people)
];
