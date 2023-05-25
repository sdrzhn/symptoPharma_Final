import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';


class FavoriteProvider with ChangeNotifier {
  Set<String> _favoriteProducts = {};
  late CollectionReference _favoriteCollection;

 FavoriteProvider() {
    // Initialize the Firestore collection reference
    final userId = FirebaseAuth.instance.currentUser!.uid;
    _favoriteCollection = FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('favorites');
    _loadFavoriteProducts();
  }

  Set<String> get favoriteProducts => _favoriteProducts;

  void _loadFavoriteProducts() async {
    // Load favorite products from Firestore
    final snapshot = await _favoriteCollection.get();
    _favoriteProducts = snapshot.docs.map((doc) => doc.id).toSet();
    notifyListeners();
  }

  void addFavoriteProduct(String productName) async {
    // Add the favorite product to Firestore
    await _favoriteCollection.doc(productName).set({});
    _favoriteProducts.add(productName);
    notifyListeners();
  }

  void removeFavoriteProduct(String productName) async {
    // Remove the favorite product from Firestore
    await _favoriteCollection.doc(productName).delete();
    _favoriteProducts.remove(productName);
    notifyListeners();
  }

  bool isFavoriteProduct(String productName) {
    return _favoriteProducts.contains(productName);
  }
}
