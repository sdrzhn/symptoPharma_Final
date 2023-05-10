import 'package:flutter/material.dart';
import 'package:symptopharm/pages/register_page.dart';
import 'package:symptopharm/widget/button_primary.dart';
import 'package:symptopharm/widget/general_logo_space.dart';
import 'package:symptopharm/widget/widget_ilustration_page.dart';

class SplashScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: GeneralLogoSpace(
        child: Column(
          children: [
            SizedBox(
              height: 1,
            ),
            WidgetIlustration(image: 'assets/hero.png',
            subtitle1: 'Consult with a doctor',
            subtitle2: 'Do not self-medicate',
            title: 'Find informations about medicaments\nby symptoms',
            child: ButtonPrimary(text: "GET STARTED", 
            onTap: (){
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => RegisterPages()));
            }),)
          ],
        ),
        ),
    );
  }

}