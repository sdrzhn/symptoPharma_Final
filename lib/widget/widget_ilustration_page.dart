import 'package:flutter/material.dart';
import 'package:symptopharm/theme.dart';

class WidgetIlustration extends StatelessWidget{
  final Widget child;
  final String image;
  final String title;
  final String subtitle1;
  final String subtitle2;

  WidgetIlustration({required this.child, required this.image, required this.title, required this.subtitle1, required this.subtitle2});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(image,
        height: 250,
        width: 330,),
        SizedBox(height: 60,),
        Text(
          title, 
          style: regulerTextStyle.copyWith(fontSize: 22), 
          textAlign: TextAlign.center,),
          SizedBox(
            height: 14,
          ),
          Column(
            children: [
              Text(
                subtitle1,
                style: regulerTextStyle.copyWith(
                  fontSize: 15, color: greyLightColor
                ),
              )
            ],
          ),
          SizedBox(
            height: 14,
          ),
          Column(
            children: [
              Text(
              subtitle2,
                style: regulerTextStyle.copyWith(
                  fontSize: 15, color: greyLightColor
                ),
                
              )
            ],
          ),
          SizedBox(
            height: 48,
          ),
        child ?? SizedBox()
      ],
    );
  }

}