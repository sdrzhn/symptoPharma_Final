import 'package:flutter/material.dart';

class GeneralLogoSpace extends StatelessWidget{
  final Widget child;
  GeneralLogoSpace({required this.child});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          SizedBox(
            height: 5,
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: Image.asset(
              "assets/Icon.png",
              width: 200,
            ),
          ),
          child ?? SizedBox()
        ],
      ),
    );
  }

}