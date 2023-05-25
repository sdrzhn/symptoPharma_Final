import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:symptopharm/pages/category_page.dart';
import 'package:symptopharm/pages/rating_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../theme.dart';

class ProductDetailPage extends StatefulWidget {
  final String productName;
  final String imgURL;
  final String group;
  final String price;
  final int rating;

  ProductDetailPage({
    required this.productName,
    required this.imgURL,
    required this.group,
    required this.price,
    required this.rating,
  });

  @override
  _ProductDetailPageState createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  late SharedPreferences _preferences;
  bool isFavorite = false;
  int rating = 0;

   @override
  void initState() {
    super.initState();
    loadFavoriteStatus();
  }

  //  void toggleFavorite() {
  //   if (isFavorite) {
  //     removeFromFavorites();
  //   } else {
  //     addToFavorites();
  //   }
  // }

Future<void> loadFavoriteStatus() async {
    _preferences = await SharedPreferences.getInstance();
    setState(() {
      isFavorite = _preferences.getBool(widget.productName) ?? false;
    });
  }

  Future<void> saveFavoriteStatus(bool status) async {
    setState(() {
      isFavorite = status;
    });
    _preferences.setBool(widget.productName, status);
  }

  void toggleFavorite() {
    if (isFavorite) {
      removeFromFavorites();
    } else {
      addToFavorites();
    }
  }

  void addToFavorites() {
    FirebaseFirestore.instance.collection('favoriteProducts').add({
      'productName': widget.productName,
      'imgURL':widget.imgURL,
      'group':widget.group,
      'price':widget.price,
      'rating':widget.rating,
    });
    saveFavoriteStatus(true);
  }

  void removeFromFavorites() {
    FirebaseFirestore.instance
        .collection('favoriteProducts')
        .where('productName', isEqualTo: widget.productName)
        .get()
        .then((snapshot) {
      snapshot.docs.forEach((doc) {
        doc.reference.delete();

        saveFavoriteStatus(false);
      });
    });
  }



  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: FirebaseFirestore.instance.collection('products').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              elevation: 1,
              leading: IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CategoryPage(
                        categoryName: '',
                      ),
                    ),
                  );
                },
                icon: Icon(Icons.arrow_back, color: Color(0xff6ebe81)),
              ),
            ),
            body: Center(child: CircularProgressIndicator()),
          );
        }

        final products = snapshot.data!.docs;

        final selectedProducts = products.where((product) =>
            product.data()['productName'].toString() == widget.productName);

        if (selectedProducts.isEmpty) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(child: Text('Product not found')),
          );
        }

        final selectedProduct = selectedProducts.first;
        final productData = selectedProduct.data();
        rating = productData['rating'] ?? 0;

        return Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            elevation: 1,
            leading: IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CategoryPage(
                      categoryName: '',
                    ),
                  ),
                );
              },
              icon: Icon(Icons.arrow_back, color: Color(0xff6ebe81)),
            ),
            actions: [
              IconButton(
                icon: Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: isFavorite ? Colors.red : Color(0xff6ebe81),
                ),
                onPressed: toggleFavorite,
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 25,
                ),
                Image.network(
                  productData['imgURL'],
                  width: double.infinity,
                  height: 300,
                  fit: BoxFit.cover,
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 320.0, right: 20.0),
                  child: Text(
                    productData['price'],
                    style: lightTextStyle.copyWith(
                        fontSize: 17, color: Colors.black),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 245.0, right: 20.0),
                  child: RatingBar(
                    initialRating: rating,
                    onRatingChanged: (newRating) {
                      setState(() {
                        rating = newRating;
                      });
                      // Update the rating in the Firestore database
                      selectedProduct.reference.update({'rating': newRating});
                    },
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: Text(
                    'Симптомы',
                    style: lightTextStyle.copyWith(
                        fontSize: 17, color: Colors.black54),
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                  child: Text(
                    productData['shortDesc'],
                    style: regulerTextStyle.copyWith(
                      fontSize: 16,
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: Text(
                    'Информация',
                    style: lightTextStyle.copyWith(
                        fontSize: 17, color: Colors.black54),
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                  child: Text(
                    productData['description'],
                    style: regulerTextStyle.copyWith(
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}