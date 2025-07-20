import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/product.dart';
import '../providers/product_provider.dart';
import '../providers/cart_provider.dart';
import '../widgets/product_image_widget.dart';
import 'product_detail_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    context.read<ProductProvider>().searchProducts(_searchController.text);
  }

  void _clearSearch() {
    _searchController.clear();
    context.read<ProductProvider>().clearSearch();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Products'),
        backgroundColor: Colors.green[600],
        foregroundColor: Colors.white,
        automaticallyImplyLeading: false,
      ),
      backgroundColor: Colors.grey[50],
      body: Consumer<ProductProvider>(
        builder: (context, productProvider, child) {
          return Column(
            children: [
              // Search Bar
              Container(
                padding: const EdgeInsets.all(16),
                color: Colors.white,
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Search for products...',
                    prefixIcon: const Icon(Icons.search, color: Colors.grey),
                    suffixIcon: productProvider.isSearching
                        ? IconButton(
                            icon: const Icon(Icons.clear, color: Colors.grey),
                            onPressed: _clearSearch,
                          )
                        : null,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.grey[300]!),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.green[600]!),
                    ),
                    filled: true,
                    fillColor: Colors.grey[50],
                  ),
                ),
              ),

              // Search Results or Popular Products
              Expanded(
                child: productProvider.isSearching
                    ? _buildSearchResults(productProvider)
                    : _buildPopularProducts(productProvider),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildSearchResults(ProductProvider productProvider) {
    if (!productProvider.hasSearchResults) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.search_off,
              size: 80,
              color: Colors.grey[400],
            ),
            const SizedBox(height: 16),
            Text(
              'No products found',
              style: TextStyle(
                fontSize: 20,
                color: Colors.grey[600],
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Try searching with different keywords',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[500],
              ),
            ),
          ],
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            '${productProvider.searchResults.length} products found',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[700],
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: productProvider.searchResults.length,
            itemBuilder: (context, index) {
              return _buildSearchResultItem(productProvider.searchResults[index]);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildSearchResultItem(Product product) {
    return Consumer<CartProvider>(
      builder: (context, cartProvider, child) {
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          child: ListTile(
            leading: ProductImageWidget(
              imagePath: product.image,
              size: 80,
            ),
            title: Text(
              product.name,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.category,
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '\$${product.price.toStringAsFixed(2)}',
                  style: TextStyle(
                    color: Colors.green[600],
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.add_shopping_cart),
                  color: Colors.green[600],
                  onPressed: () {
                    cartProvider.addToCart(product);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('${product.name} added to cart'),
                        backgroundColor: Colors.green[600],
                        duration: const Duration(seconds: 2),
                      ),
                    );
                  },
                ),
                const Icon(Icons.chevron_right, color: Colors.grey),
              ],
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductDetailScreen(product: product),
                ),
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildPopularProducts(ProductProvider productProvider) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Search Suggestions
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Search by Category',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: productProvider.categories.map((category) {
                    return GestureDetector(
                      onTap: () {
                        _searchController.text = category;
                        productProvider.searchProducts(category);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: Colors.green[50],
                          border: Border.all(color: Colors.green[200]!),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          category,
                          style: TextStyle(
                            color: Colors.green[700],
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),

          // Featured Products
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Featured Products',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 12),
                ...productProvider.featuredProducts.map((product) => _buildSearchResultItem(product)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
