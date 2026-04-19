import 'package:flutter/material.dart';
import 'presentation/screens/dashboard_screen.dart';
import 'presentation/screens/sales_screen.dart';
import 'presentation/screens/products_screen.dart';

void main() {
  runApp(const NovaAdenApp());
}

class NovaAdenApp extends StatelessWidget {
  const NovaAdenApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'nova-ADEN',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
        cardTheme: CardThemeData(elevation: 2, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
        ),
      ),
      home: const DashboardScreen(),
      routes: {
        '/sales': (context) => const SalesScreen(),
        '/products': (context) => const ProductsScreen(),
      },
    );
  }
}
