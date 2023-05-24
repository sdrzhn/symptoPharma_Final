import 'package:flutter/material.dart';

class FavoriteProvider with ChangeNotifier {
  Set<String> _favoriteProducts = {};

  Set<String> get favoriteProducts => _favoriteProducts;

  void addFavoriteProduct(String productName) {
    _favoriteProducts.add(productName);
    notifyListeners();
  }

  void removeFavoriteProduct(String productName) {
    _favoriteProducts.remove(productName);
    notifyListeners();
  }

  bool isFavoriteProduct(String productName) {
    return _favoriteProducts.contains(productName);
  }
}