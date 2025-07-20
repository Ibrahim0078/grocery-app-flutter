import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/cart_item.dart';
import '../providers/cart_provider.dart';
import '../providers/app_state_provider.dart';
import '../widgets/product_image_widget.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shopping Cart'),
        backgroundColor: Colors.green[600],
        foregroundColor: Colors.white,
        automaticallyImplyLeading: false,
        actions: [
          Consumer<CartProvider>(
            builder: (context, cartProvider, child) {
              return cartProvider.isNotEmpty
                  ? IconButton(
                      icon: const Icon(Icons.delete_sweep),
                      onPressed: () => _showClearCartDialog(context, cartProvider),
                    )
                  : const SizedBox.shrink();
            },
          ),
        ],
      ),
      backgroundColor: Colors.grey[50],
      body: Consumer<CartProvider>(
        builder: (context, cartProvider, child) {
          if (cartProvider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (cartProvider.isEmpty) {
            return _buildEmptyCart();
          }

          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: cartProvider.cartItems.length,
                  itemBuilder: (context, index) {
                    return _buildCartItem(cartProvider.cartItems[index], cartProvider);
                  },
                ),
              ),
              _buildCartSummary(context, cartProvider),
            ],
          );
        },
      ),
    );
  }

  Widget _buildEmptyCart() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.shopping_cart_outlined,
            size: 80,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            'Your cart is empty',
            style: TextStyle(
              fontSize: 20,
              color: Colors.grey[600],
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Add some products to get started',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[500],
            ),
          ),
          const SizedBox(height: 24),
          Consumer<AppStateProvider>(
            builder: (context, appState, child) {
              return ElevatedButton(
                onPressed: () => appState.goToHome(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green[600],
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                ),
                child: const Text('Start Shopping'),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCartItem(CartItem cartItem, CartProvider cartProvider) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            // Product Image
            ProductImageWidget(
              imagePath: cartItem.product.image,
              size: 60,
            ),
            const SizedBox(width: 16),

            // Product Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    cartItem.product.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    cartItem.product.category,
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '\$${cartItem.product.price.toStringAsFixed(2)} each',
                    style: TextStyle(
                      color: Colors.green[600],
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),

            // Quantity Controls
            Column(
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: () => cartProvider.decreaseQuantity(cartItem.product.id),
                      icon: const Icon(Icons.remove_circle_outline),
                      iconSize: 28,
                      color: Colors.red,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey[300]!),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        '${cartItem.quantity}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () => cartProvider.increaseQuantity(cartItem.product.id),
                      icon: const Icon(Icons.add_circle_outline),
                      iconSize: 28,
                      color: Colors.green,
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  '\$${cartItem.totalPrice.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCartSummary(BuildContext context, CartProvider cartProvider) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Total Items:',
                style: TextStyle(fontSize: 16),
              ),
              Text(
                '${cartProvider.itemCount}',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Total Price:',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '\$${cartProvider.totalPrice.toStringAsFixed(2)}',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.green[600],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => _showCheckoutDialog(context, cartProvider),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green[600],
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'Proceed to Checkout',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showClearCartDialog(BuildContext context, CartProvider cartProvider) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Clear Cart'),
          content: const Text('Are you sure you want to remove all items from your cart?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                cartProvider.clearCart();
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Cart cleared successfully'),
                    backgroundColor: Colors.green,
                  ),
                );
              },
              child: const Text(
                'Clear',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showCheckoutDialog(BuildContext context, CartProvider cartProvider) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Checkout'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Total Items: ${cartProvider.itemCount}'),
              const SizedBox(height: 8),
              Text(
                'Total Amount: \$${cartProvider.totalPrice.toStringAsFixed(2)}',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              const Text('Thank you for your order! In a real app, this would process the payment.'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                cartProvider.clearCart();
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Order placed successfully! 🎉'),
                    backgroundColor: Colors.green,
                    duration: Duration(seconds: 3),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green[600],
                foregroundColor: Colors.white,
              ),
              child: const Text('Place Order'),
            ),
          ],
        );
      },
    );
  }
}
