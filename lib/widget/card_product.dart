import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:symptopharm/theme.dart';

class CardProduct extends StatelessWidget {
  final String imageProduct;
  final String nameProduct;
  final String price;
  CardProduct({required this.imageProduct, required this.nameProduct, required this.price});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: whiteColor, borderRadius: BorderRadius.circular(10),
      ),
        child: Column(children: [
          Image.network(imageProduct, width: 115, height: 76,),
          SizedBox(height: 16,),
          Text(nameProduct, style: regulerTextStyle, textAlign: TextAlign.center,),
          SizedBox(height: 14,),
          Text(price, style: boldTextStyle,)

        ],),
    );
  }
}