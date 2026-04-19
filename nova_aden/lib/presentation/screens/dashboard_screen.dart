import 'package:flutter/material.dart';
import '../widgets/app_drawer.dart';
import '../widgets/summary_card.dart';
import '../widgets/low_stock_list.dart';
import '../widgets/sales_chart.dart';
import '../../domain/entities/product.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});
  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final double salesToday = 0.0;
  final double profitToday = 0.0;
  final int totalProducts = 7;
  final int lowStockCount = 2;
  final double inventoryValue = 38330.0;
  
  final List<Product> lowStockProducts = [
    Product(id: 1, name: 'Jabón de Baño', code: 'JB001', cost: 50, price: 80, stock: 3, minStock: 5),
    Product(id: 2, name: 'Cerveza Nacional', code: 'CN001', cost: 120, price: 150, stock: 2, minStock: 10),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dashboard'), elevation: 0),
      drawer: const AppDrawer(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Dashboard', style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Text('Resumen de tu negocio', style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.grey[600])),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.shopping_cart),
                label: const Text('Nueva Venta'),
                style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 16), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
              ),
            ),
            const SizedBox(height: 24),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: 1.5,
              children: [
                SummaryCard(title: 'Ventas Hoy', value: '\$${salesToday.toStringAsFixed(2)} CUP', subtitle: '0 transacciones', icon: Icons.shopping_cart),
                SummaryCard(title: 'Ganancia Hoy', value: '\$${profitToday.toStringAsFixed(2)} CUP', icon: Icons.trending_up, iconColor: Colors.green),
                SummaryCard(title: 'Productos', value: totalProducts.toString(), subtitle: '$lowStockCount con stock bajo', icon: Icons.inventory_2, iconColor: Colors.blue),
                SummaryCard(title: 'Valor Inventario', value: '\$${inventoryValue.toStringAsFixed(2)} CUP', icon: Icons.attach_money, iconColor: Colors.orange),
              ],
            ),
            const SizedBox(height: 24),
            const SalesChart(),
            const SizedBox(height: 24),
            LowStockList(lowStockProducts: lowStockProducts),
          ],
        ),
      ),
    );
  }
}