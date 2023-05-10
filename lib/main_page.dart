import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:symptopharm/pages/favorite_page.dart';
import 'package:symptopharm/pages/home_page.dart';
import 'package:symptopharm/pages/profile_page.dart';
import 'package:symptopharm/theme.dart';

class MainPages extends StatefulWidget {
  const MainPages({super.key});

  @override
  State<MainPages> createState() => _MainPagesState();
}

class _MainPagesState extends State<MainPages> {
  int _selectIndex = 0;

  final _pageList = [
    HomePages(),
    FavoritePages(),
    ProfilePages(),
  ];

  onTappedItem(int index){
    setState(() {
      _selectIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pageList.elementAt(_selectIndex),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Color(0xff6ebe81),
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.favorite_border_outlined), label: "Favorite"),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: "Profile"),
      ],
      currentIndex: _selectIndex,
      onTap: onTappedItem,
      unselectedItemColor: grey35Color,
      ),
    );
  }
}