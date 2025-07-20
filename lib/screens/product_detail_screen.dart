import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/product.dart';
import '../providers/cart_provider.dart';
import '../widgets/product_image_widget.dart';

class ProductDetailScreen extends StatefulWidget {
  final Product product;

  const ProductDetailScreen({
    super.key,
    required this.product,
  });

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  int quantity = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.product.name),
        backgroundColor: Colors.green[600],
        foregroundColor: Colors.white,
      ),
      backgroundColor: Colors.grey[50],
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Product Image Section
                  Container(
                    width: double.infinity,
                    height: 300,
                    color: Colors.white,
                    child: Center(
                      child: ProductImageWidget(
                        imagePath: widget.product.image,
                        size: 500,
                      ),
                    ),
                  ),

                  // Product Information Section
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Product Name
                        Text(
                          widget.product.name,
                          style: const TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 8),

                        // Category Badge
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: Colors.green[100],
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: Colors.green[300]!),
                          ),
                          child: Text(
                            widget.product.category,
                            style: TextStyle(
                              color: Colors.green[700],
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Price
                        Text(
                          '\$${widget.product.price.toStringAsFixed(2)}',
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Colors.green[600],
                          ),
                        ),
                        const SizedBox(height: 20),

                        // Description
                        const Text(
                          'Description',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          widget.product.description,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[700],
                            height: 1.5,
                          ),
                        ),
                        const SizedBox(height: 24),

                        // Quantity Selector
                        const Text(
                          'Quantity',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey[300]!),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                children: [
                                  IconButton(
                                    onPressed: quantity > 1
                                        ? () {
                                            setState(() {
                                              quantity--;
                                            });
                                          }
                                        : null,
                                    icon: const Icon(Icons.remove),
                                    color: Colors.red,
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 20),
                                    child: Text(
                                      '$quantity',
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      setState(() {
                                        quantity++;
                                      });
                                    },
                                    icon: const Icon(Icons.add),
                                    color: Colors.green,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 16),
                            Text(
                              'Total: \$${(widget.product.price * quantity).toStringAsFixed(2)}',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.green[600],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),

                        // Featured Badge
                        if (widget.product.isFeatured)
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: Colors.orange[100],
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: Colors.orange[300]!),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.star, color: Colors.orange[700], size: 16),
                                const SizedBox(width: 4),
                                Text(
                                  'Featured Product',
                                  style: TextStyle(
                                    color: Colors.orange[700],
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Add to Cart Button (Fixed at bottom)
          Container(
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
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  final cartProvider = context.read<CartProvider>();
                  // Add multiple quantities to cart
                  for (int i = 0; i < quantity; i++) {
                    cartProvider.addToCart(widget.product);
                  }

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        quantity == 1
                            ? '${widget.product.name} added to cart'
                            : '$quantity x ${widget.product.name} added to cart',
                      ),
                      backgroundColor: Colors.green[600],
                      duration: const Duration(seconds: 2),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green[600],
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  quantity == 1
                      ? 'Add to Cart - \$${widget.product.price.toStringAsFixed(2)}'
                      : 'Add $quantity items to Cart - \$${(widget.product.price * quantity).toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
