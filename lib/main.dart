import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/cart_provider.dart';
import 'providers/product_provider.dart';
import 'providers/app_state_provider.dart';
import 'screens/main_navigation_screen.dart';

void main() {
  runApp(const GroceryStoreApp());
}

class GroceryStoreApp extends StatelessWidget {
  const GroceryStoreApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppStateProvider()),
        ChangeNotifierProvider(create: (_) => ProductProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
      ],
      child: MaterialApp(
        title: 'Grocery Store',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.green,
            brightness: Brightness.light,
          ),
          useMaterial3: true,
          appBarTheme: AppBarTheme(
            centerTitle: true,
            elevation: 2,
            backgroundColor: Colors.green[600],
            foregroundColor: Colors.white,
          ),
          cardTheme: CardTheme(
            elevation: 2,
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green[600],
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          bottomNavigationBarTheme: BottomNavigationBarThemeData(
            backgroundColor: Colors.white,
            selectedItemColor: Colors.green[600],
            unselectedItemColor: Colors.grey[600],
            selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600),
            type: BottomNavigationBarType.fixed,
          ),
        ),
        home: const AppInitializer(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

class AppInitializer extends StatefulWidget {
  const AppInitializer({super.key});

  @override
  State<AppInitializer> createState() => _AppInitializerState();
}

class _AppInitializerState extends State<AppInitializer> {
  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    final appStateProvider = context.read<AppStateProvider>();
    final productProvider = context.read<ProductProvider>();
    final cartProvider = context.read<CartProvider>();

    // Initialize all providers
    await Future.wait([
      appStateProvider.initializeApp(),
      productProvider.loadProducts(),
      cartProvider.loadCart(),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppStateProvider>(
      builder: (context, appState, child) {
        if (!appState.isInitialized) {
          return Scaffold(
            backgroundColor: Colors.green[50],
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.shopping_cart,
                    size: 80,
                    color: Colors.green[600],
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Grocery Store',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.green[600],
                    ),
                  ),
                  const SizedBox(height: 20),
                  CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.green[600]!),
                  ),
                  const SizedBox(height: 10),
                  const Text('Loading fresh products...')
                ],
              ),
            ),
          );
        }

        return const MainNavigationScreen();
      },
    );
  }
}
