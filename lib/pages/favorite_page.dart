import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FavoritePages extends StatefulWidget {
  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePages> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: FirebaseFirestore.instance.collection('favoriteProducts').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(child: CircularProgressIndicator()),
          );
        }

        final favoriteProducts = snapshot.data!.docs;
        return Scaffold(
          appBar: AppBar(
            title: Text('Favorite Products'),
          ),
          body: ListView.builder(
            itemCount: favoriteProducts.length,
            itemBuilder: (context, index) {
              final favoriteData = favoriteProducts[index].data();

              final imgURL = favoriteData['imgURL'] as String?;
              final productName = favoriteData['productName'] as String?;
              final price = favoriteData['price'] as String?;

              return Card(
                child: ListTile(
                  leading: imgURL != null
                      ? Image.network(
                          imgURL,
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                        )
                      : SizedBox(),
                  title: Text(productName ?? ' '),
                  subtitle: Text(price ?? ' '),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
