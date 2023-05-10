import 'package:flutter/material.dart';
import 'package:symptopharm/main_page.dart';
import 'package:symptopharm/pages/splash_screen.dart';
import 'package:symptopharm/theme.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: greenColor),
      home: SplashScreen(),
    );
  }
}