import 'package:flutter/material.dart';
import '../services/product_service.dart';
import 'product_list_screen.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final categories = ProductService.getCategories();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Categories'),
        backgroundColor: Colors.green[600],
        foregroundColor: Colors.white,
        automaticallyImplyLeading: false,
      ),
      backgroundColor: Colors.grey[50],
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 0.90,
          ),
          itemCount: categories.length,
          itemBuilder: (context, index) {
            return _buildCategoryCard(context, categories[index]);
          },
        ),
      ),
    );
  }

  Widget _buildCategoryCard(BuildContext context, String category) {
    IconData icon;
    Color color;
    Color backgroundColor;

    switch (category) {
      case 'Fruits & Vegetables':
        icon = Icons.eco;
        color = Colors.green[600]!;
        backgroundColor = Colors.green[50]!;
        break;
      case 'Dairy':
        icon = Icons.local_drink;
        color = Colors.blue[600]!;
        backgroundColor = Colors.blue[50]!;
        break;
      case 'Bakery':
        icon = Icons.bakery_dining;
        color = Colors.orange[600]!;
        backgroundColor = Colors.orange[50]!;
        break;
      case 'Snacks':
        icon = Icons.cookie;
        color = Colors.purple[600]!;
        backgroundColor = Colors.purple[50]!;
        break;
      case 'Beverages':
        icon = Icons.local_cafe;
        color = Colors.brown[600]!;
        backgroundColor = Colors.brown[50]!;
        break;
      default:
        icon = Icons.shopping_basket;
        color = Colors.grey[600]!;
        backgroundColor = Colors.grey[50]!;
    }

    final productCount = ProductService.getProductsByCategory(category).length;

    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProductListScreen(
                category: category,
              ),
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
                backgroundColor,
                Colors.white,
              ],
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Icon(
                  icon,
                  size: 40,
                  color: color,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                category,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[800],
                ),
              ),
              const SizedBox(height: 4),
              Text(
                '$productCount items',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
