import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/cart_item.dart';
import '../models/product.dart';

class CartService {
  static const String _cartKey = 'cart_items';
  List<CartItem> _cartItems = [];

  List<CartItem> get cartItems => _cartItems;

  int get itemCount => _cartItems.fold(0, (sum, item) => sum + item.quantity);

  double get totalPrice => _cartItems.fold(0, (sum, item) => sum + item.totalPrice);

  Future<void> loadCart() async {
    final prefs = await SharedPreferences.getInstance();
    final cartJson = prefs.getString(_cartKey);

    if (cartJson != null) {
      final List<dynamic> cartList = jsonDecode(cartJson);
      _cartItems = cartList.map((item) => CartItem.fromJson(item)).toList();
    }
  }

  Future<void> _saveCart() async {
    final prefs = await SharedPreferences.getInstance();
    final cartJson = jsonEncode(_cartItems.map((item) => item.toJson()).toList());
    await prefs.setString(_cartKey, cartJson);
  }

  void addToCart(Product product) {
    final existingIndex = _cartItems.indexWhere((item) => item.product.id == product.id);

    if (existingIndex >= 0) {
      _cartItems[existingIndex].quantity++;
    } else {
      _cartItems.add(CartItem(product: product));
    }

    _saveCart();
  }

  void removeFromCart(String productId) {
    _cartItems.removeWhere((item) => item.product.id == productId);
    _saveCart();
  }

  void updateQuantity(String productId, int quantity) {
    final index = _cartItems.indexWhere((item) => item.product.id == productId);
    if (index >= 0) {
      if (quantity <= 0) {
        _cartItems.removeAt(index);
      } else {
        _cartItems[index].quantity = quantity;
      }
      _saveCart();
    }
  }

  void clearCart() {
    _cartItems.clear();
    _saveCart();
  }
}
