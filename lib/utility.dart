import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
const IMAGE_KEY='IMAGE_KEY';



class Utility{
  static Future<bool> saveImage(String value) async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.setString(IMAGE_KEY, value);
  }

  static Future<String> getImagefrompreference() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(IMAGE_KEY);
  }
  static String base64String(Uint8List data) {
    return base64Encode(data);
  }

  // decode bytes from a string
  static imageFrom64BaseString(String base64String) {
    return Image.memory(
      base64Decode(base64String),
      fit: BoxFit.fill,
    );
  }


}