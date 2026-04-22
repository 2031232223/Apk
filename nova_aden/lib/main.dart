import 'package:flutter/material.dart';
import 'presentation/screens/dashboard_screen.dart';
import 'presentation/screens/sales_screen.dart';
import 'presentation/screens/products_screen.dart'; // Esta ya no se usará si queremos usar el nuevo inventory
import 'presentation/screens/purchases_screen.dart';
import 'presentation/screens/inventory_screen.dart'; // Importamos el nuevo

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
        '/inventory': (context) => const InventoryScreen(), // Nueva ruta
        // Si quieres mantener la antigua pantalla de productos como algo separado, puedes dejarla aquí también
        // '/products': (context) => const ProductsScreen(), 
      },
    );
  }
}
