import '../models/product.dart';

class ProductService {
  static final List<Product> _products = [
    // Fruits & Vegetables
    Product(
      id: '1',
      name: 'Fresh Bananas',
      category: 'Fruits & Vegetables',
      price: 2.99,
      image: 'assets/images/banan.jpg', // Fixed: matches actual file name
      description: 'Fresh and ripe bananas, perfect for snacking',
      isFeatured: true,
    ),
    Product(
      id: '2',
      name: 'Red Apples',
      category: 'Fruits & Vegetables',
      price: 4.99,
      image: 'assets/images/apple.jpg', // This one is correct
      description: 'Crispy and sweet red apples',
      isFeatured: true,
    ),
    Product(
      id: '3',
      name: 'Fresh Carrots',
      category: 'Fruits & Vegetables',
      price: 1.99,
      image: 'assets/images/carrot.jpg', // Fixed: matches actual file
      description: 'Organic carrots, great for cooking',
    ),
    Product(
      id: '4',
      name: 'Broccoli',
      category: 'Fruits & Vegetables',
      price: 3.49,
      image: 'assets/images/brocolli.jpg', // Fixed: matches actual file spelling
      description: 'Fresh green broccoli',
    ),
    Product(
      id: '5',
      name: 'Tomatoes',
      category: 'Fruits & Vegetables',
      price: 3.99,
      image: 'assets/images/tomatos.jpg', // Fixed: matches actual file name
      description: 'Ripe and juicy tomatoes',
    ),
    Product(
      id: '6',
      name: 'Oranges',
      category: 'Fruits & Vegetables',
      price: 5.49,
      image: 'assets/images/oranges.jpg', // Fixed: matches actual file
      description: 'Sweet and juicy oranges',
    ),
    Product(
      id: '7',
      name: 'Spinach',
      category: 'Fruits & Vegetables',
      price: 2.79,
      image: 'assets/images/spinach.jpg', // Fixed: matches actual file
      description: 'Fresh organic spinach leaves',
    ),

    // Dairy Products
    Product(
      id: '8',
      name: 'Fresh Milk',
      category: 'Dairy',
      price: 3.49,
      image: 'assets/images/milk.jpg',
      description: 'Fresh whole milk, 1 gallon',
      isFeatured: true,
    ),
    Product(
      id: '10',
      name: 'Cheddar Cheese',
      category: 'Dairy',
      price: 4.49,
      image: 'assets/images/chaddercheese.jpg',
      description: 'Sharp cheddar cheese block',
    ),
    Product(
      id: '11',
      name: 'Butter',
      category: 'Dairy',
      price: 4.99,
      image: 'assets/images/butter.jpg',
      description: 'Unsalted butter, 1 lb',
    ),

    // Bakery
    Product(
      id: '13',
      name: 'Whole Wheat Bread',
      category: 'Bakery',
      price: 2.99,
      image: 'assets/images/wholewheatbread.jpg',
      description: 'Fresh baked whole wheat bread',
      isFeatured: true,
    ),
    Product(
      id: '14',
      name: 'Croissants',
      category: 'Bakery',
      price: 6.99,
      image: 'assets/images/croissants.jpg',
      description: 'Buttery croissants, pack of 6',
    ),
    Product(
      id: '15',
      name: 'Bagels',
      category: 'Bakery',
      price: 4.49,
      image: 'assets/images/bagels.jpg',
      description: 'Everything bagels, pack of 6',
    ),
    Product(
      id: '16',
      name: 'Sourdough Bread',
      category: 'Bakery',
      price: 4.29,
      image: 'assets/images/sourdoughbread.jpg',
      description: 'Artisan sourdough bread loaf',
    ),

    // Snacks
    Product(
      id: '17',
      name: 'Potato Chips',
      category: 'Snacks',
      price: 3.99,
      image: 'assets/images/potatochips.jpg',
      description: 'Crispy potato chips, family size',
      isFeatured: true,
    ),
    Product(
      id: '18',
      name: 'Mixed Nuts',
      category: 'Snacks',
      price: 7.49,
      image: 'assets/images/mixednuts.jpg',
      description: 'Premium mixed nuts, 16oz',
    ),
    Product(
      id: '19',
      name: 'Chocolate Cookies',
      category: 'Snacks',
      price: 4.79,
      image: 'assets/images/chocolatecookies.jpg',
      description: 'Double chocolate chip cookies',
    ),

    // Beverages
    Product(
      id: '23',
      name: 'Orange Juice',
      category: 'Beverages',
      price: 4.99,
      image: 'assets/images/orangejuice.jpg',
      description: 'Fresh squeezed orange juice, 64oz',
      isFeatured: true,
    ),
    Product(
      id: '24',
      name: 'Coffee Beans',
      category: 'Beverages',
      price: 12.99,
      image: 'assets/images/coffeebeans.jpg',
      description: 'Premium arabica coffee beans, 1lb',
    ),
    Product(
      id: '25',
      name: 'Green Tea',
      category: 'Beverages',
      price: 6.79,
      image: 'assets/images/greentea.jpg',
      description: 'Organic green tea bags, pack of 20',
    ),
  ];

  static List<Product> getAllProducts() {
    return List.from(_products);
  }

  static List<Product> getFeaturedProducts() {
    return _products.where((product) => product.isFeatured).toList();
  }

  static List<Product> getProductsByCategory(String category) {
    return _products.where((product) => product.category == category).toList();
  }

  static List<String> getCategories() {
    return _products.map((product) => product.category).toSet().toList();
  }

  static Product? getProductById(String id) {
    try {
      return _products.firstWhere((product) => product.id == id);
    } catch (e) {
      return null;
    }
  }
}
