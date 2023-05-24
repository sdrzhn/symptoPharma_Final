import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:symptopharm/pages/category_page.dart';
import 'package:symptopharm/pages/product_detail_page.dart';
import 'package:symptopharm/theme.dart';

class HomePages extends StatefulWidget {
  const HomePages({Key? key});

  @override
  State<HomePages> createState() => _HomePagesState();
}

class _HomePagesState extends State<HomePages> {
  List<String> groups = [
    'Analgetic',
    'Angioprotective',
    'BAD',
    'Respiratory',
    'Nervous',
    'Gastrointestinal',
    'Vitamins',
    'Pregnant',
    'Gynecology',
    'Antifungal',
    'Ear',
    'Ophthalmic',
    'Nasal',
    'Antiplatelet',
    'Dermatotropic',
  ];

  late TextEditingController _searchController;
  List<Map<String, dynamic>> _products = [];

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _fetchProducts();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _fetchProducts() async {
    final snapshot =
        await FirebaseFirestore.instance.collection('products').get();

    setState(() {
      _products = snapshot.docs.map((doc) => doc.data()).toList();
    });
  }

  List<Map<String, dynamic>> _searchProducts(String query) {
    if (query.isEmpty) {
      return _products;
    }

    final lowerCaseQuery = query.toLowerCase();
    return _products.where((product) {
      final productName = product['productName'].toString().toLowerCase();
      final shortDesc = product['shortDesc'].toString().toLowerCase();
      return productName.contains(lowerCaseQuery) ||
          shortDesc.contains(lowerCaseQuery);
    }).toList();
  }

  void _showSearchResults(String query) {
    final searchResults = _searchProducts(query);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SearchResultsPage(
          searchQuery: query,
          searchResults: searchResults,
        ),
      ),
    );
  }

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
                    Text(
                      'SymptoPharm',
                      style: boldTextStyle.copyWith(
                        fontSize: 25,
                        color: greenColor,
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Text(
                      "Find a medicine or vitamins\n by symptoms with SymptoPharm",
                      style: regulerTextStyle.copyWith(
                        fontSize: 17,
                        color: greyBoldColor,
                      ),
                    ),
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
                color: Color(0xffe4faf0),
              ),
              child: TextField(
                controller: _searchController,
                onChanged: (value) {
                  setState(() {});
                },
                onSubmitted: _showSearchResults,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  prefixIcon: Icon(Icons.search, color: Color(0xff6ebe81)),
                  hintText: "Search medicine ...",
                  hintStyle: regulerTextStyle.copyWith(
                    color: Color(0xffb1d8b2),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 32,
            ),
            Text(
              'Groups',
              style: boldTextStyle.copyWith(
                fontSize: 19,
                color: greyBoldColor,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemCount: groups.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    // Navigate to category page for the selected group
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CategoryPage(
                          categoryName: groups[index],
                        ),
                      ),
                    );
                  },
                  child: Container(
                    width: 25, // Specify the desired width
                    height: 25,
                    decoration: BoxDecoration(
                      color: Color(0xff6ebe81),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Container(
                      width: 25, // Specify the desired width
                      height: 25, // Specify the desired height
                      child: Card(
                        child: Container(
                          width: double
                              .infinity, // Expand the width to fill the Card
                          height: double
                              .infinity, // Expand the height to fill the Card
                          padding: EdgeInsets.all(6),
                          child: Center(
                            child: Text(
                              groups[index],
                              style: regulerTextStyle.copyWith(fontSize: 13),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),

            //Popular Products
            SizedBox(height: 20),
            Text(
              'Popular Products',
              style: boldTextStyle.copyWith(
                fontSize: 19,
                color: greyBoldColor,
              ),
            ),
            SizedBox(height: 8),
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('recommendedProducts')
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                }

                final recommendedProducts = snapshot.data?.docs ?? [];

                return GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                  ),
                  itemCount: recommendedProducts.length,
                  itemBuilder: (context, index) {
                    final productData = recommendedProducts[index].data()
                        as Map<String, dynamic>;

                    final productName = productData['productName'] ?? '';

                    return GestureDetector(
                      onTap: () {
                        // Navigate to the product detail page for the selected product
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProductDetailPage(
                              productName: productName,
                            ),
                          ),
                        );
                      },
                      child: Card(
                        child: Container(
                          width: double.infinity,
                          height: double.infinity,
                          padding: EdgeInsets.all(8),
                          child: Center(
                            child: Text(
                              productName,
                              style: regulerTextStyle.copyWith(fontSize: 16),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

//Searching products
class SearchResultsPage extends StatelessWidget {
  final String searchQuery;
  final List<Map<String, dynamic>> searchResults;

  const SearchResultsPage({
    Key? key,
    required this.searchQuery,
    required this.searchResults,
  }) : super(key: key);

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
            icon: Icon(Icons.arrow_back, color: Color(0xff6ebe81))),
        centerTitle: true,
        title: Text(
          'Search Results for "$searchQuery"',
          style: TextStyle(
            color: Colors.black, // Set the text color to black
          ),
        ),
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // Set the number of grid columns
          crossAxisSpacing: 16, // Set the spacing between grid items horizontally
          mainAxisSpacing: 16, // Set the spacing between grid items vertically
        ),
        itemCount: searchResults.length,
        itemBuilder: (context, index) {
          final productData = searchResults[index];

          return GestureDetector(
            onTap: () {
              // Navigate to the product detail page for the selected product
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductDetailPage(
                    productName: productData['productName'],
                  ),
                ),
              );
            },
            child: Card(
              child: Column(
                children: [
                  Image.network(
                    productData['imgURL'],
                    fit: BoxFit.cover,
                    height: 130,
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      productData['productName'],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
