import 'package:flutter/material.dart';

class ProductImageWidget extends StatelessWidget {
  final String imagePath;
  final double size;

  const ProductImageWidget({
    super.key,
    required this.imagePath,
    this.size = 80, // Increased default size from 48 to 80
  });

  @override
  Widget build(BuildContext context) {
    // Check if it's an asset image path or emoji
    if (imagePath.startsWith('assets/')) {
      return Image.asset(
        imagePath,
        width: size,
        height: size,
        fit: BoxFit.contain, // Keep the image properly scaled
        // Fallback to emoji if image fails to load
        errorBuilder: (context, error, stackTrace) {
          return _buildEmojiPlaceholder();
        },
      );
    } else {
      // It's an emoji - display as text
      return _buildEmojiPlaceholder();
    }
  }

  Widget _buildEmojiPlaceholder() {
    // Use a placeholder emoji or the original emoji
    String emoji = imagePath.startsWith('assets/') ? '📦' : imagePath;
    return Text(
      emoji,
      style: TextStyle(fontSize: size * 0.8), // Scale emoji size with widget size
    );
  }
}
