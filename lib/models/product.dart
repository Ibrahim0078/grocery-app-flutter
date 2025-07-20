class Product {
  final String id;
  final String name;
  final String category;
  final double price;
  final String image;
  final String description;
  final bool isFeatured;

  Product({
    required this.id,
    required this.name,
    required this.category,
    required this.price,
    required this.image,
    required this.description,
    this.isFeatured = false,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'category': category,
      'price': price,
      'image': image,
      'description': description,
      'isFeatured': isFeatured,
    };
  }

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      category: json['category'],
      price: json['price'].toDouble(),
      image: json['image'],
      description: json['description'],
      isFeatured: json['isFeatured'] ?? false,
    );
  }
}
