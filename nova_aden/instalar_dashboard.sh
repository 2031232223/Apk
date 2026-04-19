#!/bin/bash
echo "🚀 Iniciando instalación del Dashboard nova-ADEN..."

# 1. Crear directorios
mkdir -p lib/domain/entities
mkdir -p lib/presentation/widgets
mkdir -p lib/presentation/screens

# 2. Crear Entidad Product
cat > lib/domain/entities/product.dart << 'DART_EOF'
class Product {
  final int? id;
  final String name;
  final String code;
  final double cost;
  final double price;
  final int stock;
  final int minStock;
  final String unit;

  Product({
    this.id,
    required this.name,
    required this.code,
    required this.cost,
    required this.price,
    this.stock = 0,
    this.minStock = 5,
    this.unit = 'und',
  });

  bool get isLowStock => stock <= minStock;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'code': code,
      'cost': cost,
      'price': price,
      'stock': stock,
      'min_stock': minStock,
      'unit': unit,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'] as int?,
      name: map['name'] as String,
      code: map['code'] as String,
      cost: (map['cost'] as num).toDouble(),
      price: (map['price'] as num).toDouble(),
      stock: map['stock'] as int? ?? 0,
      minStock: map['min_stock'] as int? ?? 5,
      unit: map['unit'] as String? ?? 'und',
    );
  }
}
DART_EOF

# 3. Crear AppDrawer
cat > lib/presentation/widgets/app_drawer.dart << 'DART_EOF'
import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: Theme.of(context).primaryColor),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Text('nova-ADEN', style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
                const Text('Administrador de Negocios', style: TextStyle(color: Colors.white70, fontSize: 14)),
              ],
            ),
          ),
          ListTile(leading: const Icon(Icons.dashboard), title: const Text('Dashboard'), onTap: () => Navigator.pop(context)),
          ListTile(leading: const Icon(Icons.point_of_sale), title: const Text('Ventas'), onTap: () => Navigator.pop(context)),
          ListTile(leading: const Icon(Icons.inventory_2), title: const Text('Inventario'), onTap: () => Navigator.pop(context)),
          ListTile(leading: const Icon(Icons.receipt_long), title: const Text('Compras'), onTap: () => Navigator.pop(context)),
          ListTile(leading: const Icon(Icons.warning_amber), title: const Text('Mermas'), onTap: () => Navigator.pop(context)),
          ListTile(leading: const Icon(Icons.assessment), title: const Text('Reportes'), onTap: () => Navigator.pop(context)),
          const Divider(),
          ListTile(leading: const Icon(Icons.settings), title: const Text('Configuración'), onTap: () => Navigator.pop(context)),
        ],
      ),
    );
  }
}
DART_EOF

# 4. Crear SummaryCard
cat > lib/presentation/widgets/summary_card.dart << 'DART_EOF'
import 'package:flutter/material.dart';

class SummaryCard extends StatelessWidget {
  final String title;
  final String value;
  final String? subtitle;
  final IconData icon;
  final Color? iconColor;

  const SummaryCard({
    super.key,
    required this.title,
    required this.value,
    this.subtitle,
    required this.icon,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.grey[600])),
                  const SizedBox(height: 8),
                  Text(value, style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold, color: Theme.of(context).primaryColor)),
                  if (subtitle != null) ...[
                    const SizedBox(height: 4),
                    Text(subtitle!, style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey[500])),
                  ],
                ],
              ),
            ),
            Icon(icon, size: 40, color: iconColor ?? Theme.of(context).primaryColor),
          ],
        ),
      ),
    );
  }
}
DART_EOF

# 5. Crear LowStockList
cat > lib/presentation/widgets/low_stock_list.dart << 'DART_EOF'
import 'package:flutter/material.dart';
import '../../domain/entities/product.dart';

class LowStockList extends StatelessWidget {
  final List<Product> lowStockProducts;
  const LowStockList({super.key, required this.lowStockProducts});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(children: [
              Icon(Icons.warning_amber, color: Colors.orange[700]),
              const SizedBox(width: 8),
              Text('Stock Bajo', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
            ]),
            const SizedBox(height: 16),
            if (lowStockProducts.isEmpty)
              const Center(child: Text('No hay productos con stock bajo'))
            else
              ...lowStockProducts.map((p) => Padding(
                padding: const EdgeInsets.only(bottom: 12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(p.name, style: const TextStyle(fontWeight: FontWeight.w500)),
                        Text('Min: ${p.minStock}', style: TextStyle(fontSize: 12, color: Colors.grey[600])),
                      ],
                    )),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(color: Colors.red[100], borderRadius: BorderRadius.circular(20)),
                      child: Text('${p.stock} unidad${p.stock > 1 ? "es" : ""}', style: TextStyle(color: Colors.red[800], fontWeight: FontWeight.bold, fontSize: 12)),
                    ),
                  ],
                ),
              )),
            if (lowStockProducts.length > 2) ...[
              const Divider(),
              Center(child: TextButton(onPressed: () {}, child: Text('Ver todos (${lowStockProducts.length})'))),
            ],
          ],
        ),
      ),
    );
  }
}
DART_EOF

# 6. Crear SalesChart
cat > lib/presentation/widgets/sales_chart.dart << 'DART_EOF'
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class SalesChart extends StatelessWidget {
  const SalesChart({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(children: [
              Icon(Icons.bar_chart, color: Theme.of(context).primaryColor),
              const SizedBox(width: 8),
              Text('Ventas últimos 7 días', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
            ]),
            const SizedBox(height: 24),
            SizedBox(
              height: 200,
              child: BarChart(
                BarChartData(
                  alignment: BarChartAlignment.spaceAround,
                  maxY: 4,
                  barTouchData: BarTouchData(enabled: false),
                  titlesData: FlTitlesData(
                    show: true,
                    bottomTitles: AxisTitles(sideTitles: SideTitles(showTitles: true, getTitlesWidget: (value, meta) {
                      const days = ['dom', 'lun', 'mar', 'mié', 'jue', 'vie', 'sáb'];
                      return Padding(padding: const EdgeInsets.only(top: 8.0), child: Text(days[value.toInt()], style: const TextStyle(fontSize: 10, color: Colors.grey)));
                    })),
                    leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: true, reservedSize: 30)),
                    topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  ),
                  gridData: const FlGridData(show: false),
                  borderData: FlBorderData(show: false),
                  barGroups: List.generate(7, (index) => BarChartGroupData(x: index, barRods: [BarChartRodData(toY: 0, color: Theme.of(context).primaryColor)])),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
DART_EOF

# 7. Crear DashboardScreen
cat > lib/presentation/screens/dashboard_screen.dart << 'DART_EOF'
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
DART_EOF

# 8. Crear Main.dart
cat > lib/main.dart << 'DART_EOF'
import 'package:flutter/material.dart';
import 'presentation/screens/dashboard_screen.dart';

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
        cardTheme: CardTheme(elevation: 2, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
        elevatedButtonTheme: ElevatedButtonThemeData(style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)))),
      ),
      home: const DashboardScreen(),
    );
  }
}
DART_EOF

echo "✅ ¡Archivos creados exitosamente!"
