import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/cart_item.dart';
import '../models/product.dart';

class CartProvider extends ChangeNotifier {
  static const String _cartKey = 'cart_items';
  List<CartItem> _cartItems = [];
  bool _isLoading = false;

  // Getters
  List<CartItem> get cartItems => _cartItems;
  bool get isLoading => _isLoading;
  int get itemCount => _cartItems.fold(0, (sum, item) => sum + item.quantity);
  double get totalPrice => _cartItems.fold(0, (sum, item) => sum + item.totalPrice);
  bool get isEmpty => _cartItems.isEmpty;
  bool get isNotEmpty => _cartItems.isNotEmpty;

  // Load cart from SharedPreferences
  Future<void> loadCart() async {
    _isLoading = true;
    notifyListeners();

    try {
      final prefs = await SharedPreferences.getInstance();
      final cartJson = prefs.getString(_cartKey);

      if (cartJson != null) {
        final List<dynamic> cartList = jsonDecode(cartJson);
        _cartItems = cartList.map((item) => CartItem.fromJson(item)).toList();
      }
    } catch (e) {
      debugPrint('Error loading cart: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Save cart to SharedPreferences
  Future<void> _saveCart() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final cartJson = jsonEncode(_cartItems.map((item) => item.toJson()).toList());
      await prefs.setString(_cartKey, cartJson);
    } catch (e) {
      debugPrint('Error saving cart: $e');
    }
  }

  // Add product to cart
  void addToCart(Product product) {
    final existingIndex = _cartItems.indexWhere((item) => item.product.id == product.id);

    if (existingIndex >= 0) {
      _cartItems[existingIndex].quantity++;
    } else {
      _cartItems.add(CartItem(product: product));
    }

    notifyListeners();
    _saveCart();
  }

  // Add multiple quantities of a product
  void addMultipleToCart(Product product, int quantity) {
    if (quantity <= 0) return;

    final existingIndex = _cartItems.indexWhere((item) => item.product.id == product.id);

    if (existingIndex >= 0) {
      _cartItems[existingIndex].quantity += quantity;
    } else {
      _cartItems.add(CartItem(product: product, quantity: quantity));
    }

    notifyListeners();
    _saveCart();
  }

  // Remove product from cart completely
  void removeFromCart(String productId) {
    _cartItems.removeWhere((item) => item.product.id == productId);
    notifyListeners();
    _saveCart();
  }

  // Update quantity of a product in cart
  void updateQuantity(String productId, int quantity) {
    final index = _cartItems.indexWhere((item) => item.product.id == productId);
    if (index >= 0) {
      if (quantity <= 0) {
        _cartItems.removeAt(index);
      } else {
        _cartItems[index].quantity = quantity;
      }
      notifyListeners();
      _saveCart();
    }
  }

  // Increase quantity by 1
  void increaseQuantity(String productId) {
    final index = _cartItems.indexWhere((item) => item.product.id == productId);
    if (index >= 0) {
      _cartItems[index].quantity++;
      notifyListeners();
      _saveCart();
    }
  }

  // Decrease quantity by 1
  void decreaseQuantity(String productId) {
    final index = _cartItems.indexWhere((item) => item.product.id == productId);
    if (index >= 0) {
      if (_cartItems[index].quantity > 1) {
        _cartItems[index].quantity--;
      } else {
        _cartItems.removeAt(index);
      }
      notifyListeners();
      _saveCart();
    }
  }

  // Clear entire cart
  void clearCart() {
    _cartItems.clear();
    notifyListeners();
    _saveCart();
  }

  // Check if a product is in cart
  bool isInCart(String productId) {
    return _cartItems.any((item) => item.product.id == productId);
  }

  // Get quantity of a specific product in cart
  int getProductQuantity(String productId) {
    final item = _cartItems.firstWhere(
      (item) => item.product.id == productId,
      orElse: () => CartItem(product: Product(
        id: '', name: '', category: '', price: 0, image: '', description: ''
      ), quantity: 0),
    );
    return item.quantity;
  }

  // Get cart item by product ID
  CartItem? getCartItem(String productId) {
    try {
      return _cartItems.firstWhere((item) => item.product.id == productId);
    } catch (e) {
      return null;
    }
  }
}
