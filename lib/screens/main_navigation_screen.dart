import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_state_provider.dart';
import '../providers/cart_provider.dart';
import 'home_screen.dart';
import 'categories_screen.dart';
import 'search_screen.dart';
import 'cart_screen.dart';

class MainNavigationScreen extends StatelessWidget {
  const MainNavigationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<AppStateProvider, CartProvider>(
      builder: (context, appState, cartProvider, child) {
        final screens = [
          const HomeScreen(),
          const CategoriesScreen(),
          const SearchScreen(),
          const CartScreen(),
        ];

        return Scaffold(
          body: IndexedStack(
            index: appState.currentTabIndex,
            children: screens,
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: appState.currentTabIndex,
            onTap: appState.setTabIndex,
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.white,
            selectedItemColor: Colors.green[600],
            unselectedItemColor: Colors.grey[600],
            selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600),
            items: [
              const BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              const BottomNavigationBarItem(
                icon: Icon(Icons.category),
                label: 'Categories',
              ),
              const BottomNavigationBarItem(
                icon: Icon(Icons.search),
                label: 'Search',
              ),
              BottomNavigationBarItem(
                icon: Stack(
                  children: [
                    const Icon(Icons.shopping_cart),
                    if (cartProvider.itemCount > 0)
                      Positioned(
                        right: 0,
                        top: 0,
                        child: Container(
                          padding: const EdgeInsets.all(1),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          constraints: const BoxConstraints(
                            minWidth: 12,
                            minHeight: 12,
                          ),
                          child: Text(
                            '${cartProvider.itemCount > 99 ? '99+' : cartProvider.itemCount}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 8,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                  ],
                ),
                label: 'Cart',
              ),
            ],
          ),
        );
      },
    );
  }
}
