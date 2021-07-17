import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class  Appliance {
  String switchValue;
  String id;
  String title;
  String subtitle;
  IconData leftIcon;
  IconData topRightIcon;
  IconData bottomRightIcon;
  bool isEnable;
  Slider slider;
  Appliance({this.title, this.subtitle, this.leftIcon, this.topRightIcon, this.bottomRightIcon,this.switchValue, this.isEnable,this.id, Color colors,});
}