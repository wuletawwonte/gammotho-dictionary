import "package:flutter/material.dart";
import 'package:gamo_dict/pages/home.dart';

main() {
  runApp(MaterialApp(
    title: "Gamo-Dict",
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      primarySwatch: Colors.orange,
      primaryTextTheme: TextTheme(
        title: TextStyle(color: Colors.white),
      ),
      primaryIconTheme: IconThemeData(
        color: Colors.white,
      ),
      backgroundColor: Colors.black,
      ),
    home: HomeScreen(),

  
  ));
}


