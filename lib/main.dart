import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:symptopharm/pages/favorite_provider.dart';
import 'package:symptopharm/pages/splash_screen.dart';
import 'package:symptopharm/theme.dart';
import 'pages/home_page.dart';
import 'package:provider/provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
  
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => FavoriteProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primaryColor: greenColor),
        home: SplashScreen(),
      ),
    );
  }
}
