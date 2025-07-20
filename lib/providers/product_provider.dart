import 'package:flutter/material.dart';
import '../models/product.dart';
import '../services/product_service.dart';

class ProductProvider extends ChangeNotifier {
  List<Product> _allProducts = [];
  List<Product> _searchResults = [];
  List<Product> _featuredProducts = [];
  List<String> _categories = [];
  String _searchQuery = '';
  bool _isSearching = false;
  bool _isLoading = false;

  // Getters
  List<Product> get allProducts => _allProducts;
  List<Product> get searchResults => _searchResults;
  List<Product> get featuredProducts => _featuredProducts;
  List<String> get categories => _categories;
  String get searchQuery => _searchQuery;
  bool get isSearching => _isSearching;
  bool get isLoading => _isLoading;
  bool get hasSearchResults => _searchResults.isNotEmpty;

  // Load all product data
  Future<void> loadProducts() async {
    _isLoading = true;
    notifyListeners();

    try {
      _allProducts = ProductService.getAllProducts();
      _featuredProducts = ProductService.getFeaturedProducts();
      _categories = ProductService.getCategories();
    } catch (e) {
      debugPrint('Error loading products: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Get products by category
  List<Product> getProductsByCategory(String category) {
    return _allProducts.where((product) => product.category == category).toList();
  }

  // Get product by ID
  Product? getProductById(String id) {
    try {
      return _allProducts.firstWhere((product) => product.id == id);
    } catch (e) {
      return null;
    }
  }

  // Search products
  void searchProducts(String query) {
    _searchQuery = query.trim();
    _isSearching = _searchQuery.isNotEmpty;

    if (_isSearching) {
      final lowercaseQuery = _searchQuery.toLowerCase();
      _searchResults = _allProducts.where((product) {
        return product.name.toLowerCase().contains(lowercaseQuery) ||
               product.category.toLowerCase().contains(lowercaseQuery) ||
               product.description.toLowerCase().contains(lowercaseQuery);
      }).toList();
    } else {
      _searchResults.clear();
    }

    notifyListeners();
  }

  // Clear search
  void clearSearch() {
    _searchQuery = '';
    _isSearching = false;
    _searchResults.clear();
    notifyListeners();
  }

  // Filter products by price range
  List<Product> filterByPriceRange(double minPrice, double maxPrice) {
    return _allProducts.where((product) {
      return product.price >= minPrice && product.price <= maxPrice;
    }).toList();
  }

  // Get products sorted by price (low to high)
  List<Product> getProductsSortedByPrice({bool ascending = true}) {
    final sortedProducts = List<Product>.from(_allProducts);
    sortedProducts.sort((a, b) => ascending
        ? a.price.compareTo(b.price)
        : b.price.compareTo(a.price));
    return sortedProducts;
  }

  // Get products sorted by name (A to Z)
  List<Product> getProductsSortedByName({bool ascending = true}) {
    final sortedProducts = List<Product>.from(_allProducts);
    sortedProducts.sort((a, b) => ascending
        ? a.name.compareTo(b.name)
        : b.name.compareTo(a.name));
    return sortedProducts;
  }

  // Get featured products count
  int get featuredProductsCount => _featuredProducts.length;

  // Get total products count
  int get totalProductsCount => _allProducts.length;

  // Get products count by category
  int getProductsCountByCategory(String category) {
    return _allProducts.where((product) => product.category == category).length;
  }

  // Check if product is featured
  bool isProductFeatured(String productId) {
    return _featuredProducts.any((product) => product.id == productId);
  }

  // Get random featured products (for variety)
  List<Product> getRandomFeaturedProducts({int count = 4}) {
    final shuffled = List<Product>.from(_featuredProducts)..shuffle();
    return shuffled.take(count).toList();
  }
}
