import 'package:flutter/material.dart';
import 'presentation/screens/dashboard_screen.dart';
import 'presentation/screens/sales_screen.dart';
import 'presentation/screens/purchases_screen.dart';
import 'presentation/screens/inventory_screen.dart';

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
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
        ),
      ),
      home: const DashboardScreen(),
      routes: {
        '/sales': (context) => const SalesScreen(),
        '/purchases': (context) => const PurchasesScreen(),
        '/inventory': (context) => const InventoryScreen(),
      },
    );
  }
}
