import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:symptopharm/pages/category_page.dart';

import '../theme.dart';

class RatingBar extends StatefulWidget {
  final int initialRating;
  final void Function(int rating) onRatingChanged;

  RatingBar({this.initialRating = 0, required this.onRatingChanged});

  @override
  _RatingBarState createState() => _RatingBarState();
}

class _RatingBarState extends State<RatingBar> {
  late int _rating;

  @override
  void initState() {
    super.initState();
    _rating = widget.initialRating;
  }

  void _updateRating(int newRating) {
    setState(() {
      _rating = newRating;
    });
    widget.onRatingChanged(_rating);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(5, (index) {
        if (index < _rating) {
          return GestureDetector(
            onTap: () => _updateRating(index + 1),
            child: Icon(
              Icons.star,
              color: Color(0xfffbc02d),
            ),
          );
        } else {
          return GestureDetector(
            onTap: () => _updateRating(index + 1),
            child: Icon(
              Icons.star_border,
              color: Color(0xfffbc02d),
            ),
          );
        }
      }),
    );
  }
}