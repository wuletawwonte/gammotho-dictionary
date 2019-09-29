import "package:flutter/material.dart";
import "package:flutter/services.dart";
import 'package:gamo_dict/pages/home.dart';

main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    // systemNavigationBarColor: Colors.transparent, // navigation bar color
    statusBarColor: Colors.orange, // status bar color
  ));
  runApp(MaterialApp(
    title: "Gamo Dictionary",
    home: HomeScreen(),
  ));
}


