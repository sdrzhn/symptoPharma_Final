
import 'package:flutter/material.dart';
import 'package:symptopharm/theme.dart';

class HomePages extends StatefulWidget {
  const HomePages({super.key});

  @override
  State<HomePages> createState() => _HomePagesState();
}

class _HomePagesState extends State<HomePages> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: ListView(
      padding: EdgeInsets.fromLTRB(24, 30, 24, 30),
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('SymptoPharm',
                    style: boldTextStyle.copyWith(
                        fontSize: 25, color: greenColor)),
                SizedBox(
                  height: 16,
                ),
                Text(
                  "Find a medicine or vitamins\n by symptoms with SymptoPharm",
                  style: regulerTextStyle.copyWith(
                      fontSize: 17, color: greyBoldColor),
                )
              ],
            ),
          ],
        ),
        SizedBox(
          height: 24,
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          height: 55,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Color(0xffe4faf0)),
          child: TextField(
            decoration: InputDecoration(
                border: InputBorder.none,
                prefixIcon: Icon(Icons.search, color: Color(0xff6ebe81)),
                hintText: "Search medicine ...",
                hintStyle: regulerTextStyle.copyWith(color: Color(0xffb1d8b2))),
          ),
        ),
        SizedBox(
          height: 32,
        ),
        Text(
          'Groups',
          style: boldTextStyle.copyWith(fontSize: 19, color: greyBoldColor),
        ),
        // CardCategory(imageCategory: 'assets/capsules.png', nameCategory: 'Group 1')
      ],
    )));
  }
}
