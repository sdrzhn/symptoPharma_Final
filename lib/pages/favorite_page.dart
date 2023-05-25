import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:symptopharm/pages/product_detail_page.dart';

class FavoritePages extends StatefulWidget {
  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePages> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream:
          FirebaseFirestore.instance.collection('favoriteProducts').snapshots(),
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
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            elevation: 1,
            centerTitle: true,
            title: Text(
              'Favorite Products',
              style: TextStyle(
                color: Colors.black, // Set the text color to black
              ),
            ),
          ),
          body: Container(
            height: MediaQuery.of(context)
                .size
                .height, // Set a fixed height or adjust according to your needs
            child: GridView.builder(
              padding: EdgeInsets.all(6), // Add padding to all sides
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemCount: favoriteProducts.length,
              itemBuilder: (context, index) {
                final productData =
                    favoriteProducts[index].data() as Map<String, dynamic>;
                final imgURL = productData['imgURL'] ?? '';
                final productName = productData['productName'] ?? '';
                final productGroup = productData['group'] ?? '';
                final productPrice = productData['price'] ?? '';
                final productRating = productData['rating'] ?? 0;

                return GestureDetector(
                  onTap: () {
                    final productName = productData['productName'];
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductDetailPage(
                            productName: productName,
                            imgURL: imgURL,
                            group: productGroup,
                            price: productPrice,
                            rating: productRating),
                      ),
                    );
                  },
                  child: Padding(
                    padding: EdgeInsets.all(4),
                    
                    child: SingleChildScrollView(
                      child: Card(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.network(
                              imgURL,
                              fit: BoxFit.cover,
                              height: 66,
                            ),
                            Padding(
                              padding: EdgeInsets.all(4),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    productName,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13,
                                    ),
                                  ),
                                  Text('Group: $productGroup'),
                                  Text('$productPrice T'),
                                  Text('Rating: $productRating'),
                                  Container(
                                    width: 160,
                                    child: Align(
                                      alignment: Alignment.topRight,
                                      child: IconButton(
                                        icon: Icon(Icons.favorite),
                                        color: Colors.red,
                                        onPressed: () {
                                          // Remove the favorite product
                                          FirebaseFirestore.instance
                                              .collection('favoriteProducts')
                                              .doc(favoriteProducts[index].id)
                                              .delete();
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
