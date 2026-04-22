import 'package:flutter/material.dart';
import '../widgets/app_drawer.dart';
import '../widgets/summary_card.dart';
import '../widgets/sales_chart.dart'; // Asegúrate de que este archivo exista
import '../widgets/low_stock_list.dart'; // Asegúrate de que este archivo exista

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Dashboard'), elevation: 0),
      drawer: const AppDrawer(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            Text('Resumen de tu negocio', style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: Colors.grey[700])),
            const SizedBox(height: 16),
            
            // Botón Nueva Venta
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pushNamed(context, '/sales');
              },
              icon: const Icon(Icons.add_shopping_cart),
              label: const Text('Nueva Venta'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            const SizedBox(height: 24),
            
            // Tarjetas de Resumen
            Row(
              children: [
                Expanded(
                  child: SummaryCard(
                    title: 'Ventas Hoy',
                    value: '\$0.00 CUP',
                    subtitle: '0 transacciones',
                    icon: Icons.shopping_cart,
                    iconColor: Colors.blue,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: SummaryCard(
                    title: 'Ganancia Hoy',
                    value: '\$0.00 CUP',
                    subtitle: '',
                    icon: Icons.trending_up,
                    iconColor: Colors.green,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: SummaryCard(
                    title: 'Productos',
                    value: '7',
                    subtitle: '2 con stock bajo',
                    icon: Icons.inventory_2,
                    iconColor: Colors.orange,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: SummaryCard(
                    title: 'Valor Inventario',
                    value: '\$38330.00 CUP',
                    subtitle: '',
                    icon: Icons.attach_money,
                    iconColor: Colors.amber,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            
            // Gráfico de Ventas
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Ventas últimos 7 días', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 16),
                    // Aquí iría tu widget SalesChart si lo tienes
                    Container(
                      height: 150,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey[300]!),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: Text('Gráfico de Ventas (Simulado)', style: TextStyle(color: Colors.grey[600])),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            
            // Lista de Stock Bajo
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Stock Bajo', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                        TextButton(onPressed: () {}, child: const Text('Ver todos')),
                      ],
                    ),
                    const SizedBox(height: 12),
                    // Ejemplo de lista de productos con stock bajo
                    ListTile(
                      leading: const Icon(Icons.warning_amber, color: Colors.red),
                      title: const Text('Jabón de Baño'),
                      subtitle: const Text('Min: 5'),
                      trailing: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(color: Colors.red[100], borderRadius: BorderRadius.circular(12)),
                        child: const Text('3 unidad', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 12)),
                      ),
                    ),
                    ListTile(
                      leading: const Icon(Icons.warning_amber, color: Colors.red),
                      title: const Text('Cerveza Nacional'),
                      subtitle: const Text('Min: 10'),
                      trailing: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(color: Colors.red[100], borderRadius: BorderRadius.circular(12)),
                        child: const Text('2 unidad', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 12)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
