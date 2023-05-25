import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:symptopharm/pages/home_page.dart';
import 'package:symptopharm/pages/product_detail_page.dart';

class CategoryPage extends StatefulWidget {
  final String categoryName;

  const CategoryPage({Key? key, required this.categoryName}) : super(key: key);

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 1,
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomePages()),
            );
          },
          icon: Icon(Icons.arrow_back, color: Color(0xff6ebe81)),
        ),
        centerTitle: true,
        title: Text(
          widget.categoryName,
          style: TextStyle(
            color: Colors.black, // Set the text color to black
          ),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('products')
              .where('group', isEqualTo: widget.categoryName)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            final products = snapshot.data?.docs ?? [];

            if (products.isEmpty) {
              return Center(
                child: Text('No products available for this category.'),
              );
            }

            return GridView.builder(
              padding: EdgeInsets.all(16), // Add padding to all sides
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemCount: products.length,
              itemBuilder: (context, index) {
                final productData =
                    products[index].data() as Map<String, dynamic>;
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
                          rating: productRating
                        ),
                      ),
                    );
                  },
                  child: Padding(
                    padding: EdgeInsets.all(4),
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
                            padding: EdgeInsets.all(10),
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
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }),
    );
  }
}



