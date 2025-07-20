import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/product.dart';
import '../providers/product_provider.dart';
import '../providers/cart_provider.dart';
import '../widgets/product_image_widget.dart';
import 'product_list_screen.dart';
import 'product_detail_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Grocery Store'),
        backgroundColor: Colors.green[600],
        foregroundColor: Colors.white,
        automaticallyImplyLeading: false,
      ),
      backgroundColor: Colors.grey[50],
      body: Consumer<ProductProvider>(
        builder: (context, productProvider, child) {
          if (productProvider.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Welcome Banner
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.green[400]!, Colors.green[600]!],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Welcome to Grocery Store! 🛒',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Fresh products delivered to your door',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                ),

                // Categories Section
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Shop by Category',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        height: 120,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: productProvider.categories.length,
                          itemBuilder: (context, index) {
                            return _buildCategoryCard(
                              context,
                              productProvider.categories[index],
                              productProvider,
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),

                // Featured Products Section
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Featured Products',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 12),
                      GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                          childAspectRatio: 0.55,
                        ),
                        itemCount: productProvider.featuredProducts.length,
                        itemBuilder: (context, index) {
                          return _buildProductCard(
                            context,
                            productProvider.featuredProducts[index],
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildCategoryCard(
    BuildContext context,
    String category,
    ProductProvider productProvider,
  ) {
    IconData icon;
    Color color;

    switch (category) {
      case 'Fruits & Vegetables':
        icon = Icons.eco;
        color = Colors.green[600]!;
        break;
      case 'Dairy':
        icon = Icons.local_drink;
        color = Colors.blue[600]!;
        break;
      case 'Bakery':
        icon = Icons.bakery_dining;
        color = Colors.orange[600]!;
        break;
      case 'Snacks':
        icon = Icons.cookie;
        color = Colors.purple[600]!;
        break;
      case 'Beverages':
        icon = Icons.local_cafe;
        color = Colors.brown[600]!;
        break;
      default:
        icon = Icons.shopping_basket;
        color = Colors.grey[600]!;
    }

    return Container(
      width: 100,
      margin: const EdgeInsets.only(right: 12),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProductListScreen(category: category),
              ),
            );
          },
          borderRadius: BorderRadius.circular(12),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  color.withOpacity(0.1),
                  Colors.white,
                ],
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: color.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Icon(
                      icon,
                      size: 28,
                      color: color,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    category,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                    maxLines: 2,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProductCard(BuildContext context, Product product) {
    return Consumer<CartProvider>(
      builder: (context, cartProvider, child) {
        return Card(
          elevation: 2,
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductDetailScreen(product: product),
                ),
              );
            },
            borderRadius: BorderRadius.circular(4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 3,
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(4)),
                    ),
                    child: Center(
                      child: ProductImageWidget(
                        imagePath: product.image,
                        size: 500,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              product.name,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              '\$${product.price.toStringAsFixed(2)}',
                              style: TextStyle(
                                color: Colors.green[600],
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              cartProvider.addToCart(product);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('${product.name} added to cart'),
                                  duration: const Duration(seconds: 2),
                                  backgroundColor: Colors.green[600],
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green[600],
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6),
                              ),
                            ),
                            child: const Text(
                              'Add to Cart',
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
