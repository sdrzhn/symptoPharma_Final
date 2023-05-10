import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:symptopharm/network/model/product_model.dart';
import 'package:symptopharm/theme.dart';
import 'package:symptopharm/widget/card_category.dart';
import 'package:http/http.dart' as http;
import '../network/api/url_api.dart';

class HomePages extends StatefulWidget {
  const HomePages({super.key});

  @override
  State<HomePages> createState() => _HomePagesState();
}

class _HomePagesState extends State<HomePages> {
  // List<CategoryWithProduct> listCategory = [];
  // getCategory() async {
  //   listCategory.clear();
  //   var urlCategory = Uri.parse(BASEURL.categoryWithProduct);
  //   final response = await http.get(urlCategory);
  //   if(response.statusCode == 200){
  //     setState(() {
  //       final data = jsonDecode(response.body);
  //       for (Map item in data){
  //         listCategory.add(CategoryWithProduct.fromJson(item));
  //         print(listCategory[0].category);
  //       }
  //     });
  //   }
  // }

  // @override
  // void initState(){
  //   super.initState();
  //   getCategory();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: ListView(
        padding: EdgeInsets.fromLTRB(24, 30, 24, 30),
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                  Text('SymptoPharm', style: boldTextStyle.copyWith(fontSize: 25, color: greenColor)),
                  SizedBox(height: 16,),
                  Text("Find a medicine or vitamins\n by symptoms with SymptoPharm", style: regulerTextStyle.copyWith(fontSize: 17, color: greyBoldColor),)
              ],
            ),
          ],
        ),
        SizedBox(height: 24,),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          height: 55,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Color(0xffe4faf0)),
            child: TextField(
              decoration: InputDecoration(
                border: InputBorder.none,
                prefixIcon: Icon(
                  Icons.search,
                  color: Color(0xff6ebe81)
                ),
                hintText: "Search medicine ...",
                hintStyle: regulerTextStyle.copyWith(color: Color(0xffb1d8b2))
                ),
            ),
        ),
        SizedBox(height: 32,),
        Text('Groups', style: boldTextStyle.copyWith(fontSize: 19, color: greyBoldColor),),
        // CardCategory(imageCategory: 'assets/capsules.png', nameCategory: 'Group 1')
        ],
      ))
    );
  }
}