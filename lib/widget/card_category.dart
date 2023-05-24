import 'package:flutter/material.dart';
import 'package:symptopharm/theme.dart';

class CardCategory extends StatelessWidget {
  final String imageCategory;
  final String nameCategory;
  final VoidCallback onTap;

  const CardCategory({
    required this.imageCategory,
    required this.nameCategory,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: AssetImage(imageCategory),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(height: 8),
          Text(
            nameCategory,
            style: TextStyle(fontSize: 11),
          ),
        ],
      ),
    );
  }
}
