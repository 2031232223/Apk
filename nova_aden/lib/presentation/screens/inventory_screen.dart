import 'package:flutter/material.dart';
import '../widgets/app_drawer.dart';
import '../widgets/adaptive_text.dart';

class InventoryScreen extends StatefulWidget {
  const InventoryScreen({super.key});

  @override
  State<InventoryScreen> createState() => _InventoryScreenState();
}

class _InventoryScreenState extends State<InventoryScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool showAdjustDialog = false;

  final List<Map<String, dynamic>> products = [
    {'code': 'ARR001', 'name': 'Arroz (1 lb)', 'stock': 50, 'unit': 'lb', 'cost': 120.00, 'sale': 600.00, 'status': 'OK'},
    {'code': 'JAB001', 'name': 'Jabón de Baño', 'stock': 3, 'unit': 'unidad', 'cost': 80.00, 'sale': 240.00, 'status': 'Bajo'},
    {'code': 'DET001', 'name': 'Detergente 500g', 'stock': 15, 'unit': 'unidad', 'cost': 200.00, 'sale': 3000.00, 'status': 'OK'},
    {'code': 'REF001', 'name': 'Refresco Cola 1.5L', 'stock': 30, 'unit': 'unidad', 'cost': 180.00, 'sale': 540.00, 'status': 'OK'},
    {'code': 'CER001', 'name': 'Cerveza Nacional', 'stock': 2, 'unit': 'unidad', 'cost': 150.00, 'sale': 300.00, 'status': 'Bajo'},
    {'code': 'POL001', 'name': 'Pollo (1 lb)', 'stock': 20, 'unit': 'lb', 'cost': 300.00, 'sale': 6000.00, 'status': 'OK'},
    {'code': 'CAF001', 'name': 'Café Molido 250g', 'stock': 8, 'unit': 'unidad', 'cost': 400.00, 'sale': 3200.00, 'status': 'OK'},
  ];

  void openAdjustDialog() {
    setState(() {
      showAdjustDialog = true;
    });
  }

  void closeAdjustDialog() {
    setState(() {
      showAdjustDialog = false;
    });
  }

  double getCostValue() {
    return products.fold(0.0, (sum, item) => sum + (item['cost'] * item['stock']));
  }

  double getSaleValue() {
    return products.fold(0.0, (sum, item) => sum + (item['sale'] * item['stock']));
  }

  // CORRECCIÓN DEFINITIVA: fold<int>(inicial, suma)
  int getTotalUnits() {
    return products.fold<int>(0, (sum, item) => sum + item['stock'].toInt());
  }

  int getLowStockCount() {
    return products.where((item) => item['status'] == 'Bajo').length;
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Inventario'), elevation: 0),
      drawer: const AppDrawer(),
      body: Stack(
        children: [
          Column(children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                AdaptiveText('Inventario', style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                AdaptiveText('Control y ajustes de inventario', style: TextStyle(color: Colors.grey[600])),
                const SizedBox(height: 16),
                Row(children: [
                  OutlinedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.download),
                    label: const Text('CSV'),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: openAdjustDialog,
                      icon: const Icon(Icons.add),
                      label: const Text('Ajuste'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                    ),
                  ),
                ]),
                const SizedBox(height: 24),
                
                // Tarjetas de Resumen
                Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(16),
                    title: const AdaptiveText('Valor al Costo'),
                    subtitle: const AdaptiveText('\$24140.00 CUP', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                    trailing: IconButton(icon: const Icon(Icons.copy), onPressed: () {}),
                  ),
                ),
                const SizedBox(height: 12),
                Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(16),
                    title: const AdaptiveText('Valor de Venta'),
                    subtitle: const AdaptiveText('\$36590.00 CUP', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                    trailing: IconButton(icon: const Icon(Icons.copy), onPressed: () {}),
                  ),
                ),
                const SizedBox(height: 12),
                Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(16),
                    title: const AdaptiveText('Total Unidades'),
                    subtitle: AdaptiveText('${getTotalUnits()}', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                    trailing: IconButton(icon: const Icon(Icons.copy), onPressed: () {}),
                  ),
                ),
                const SizedBox(height: 12),
                Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(16),
                    title: const AdaptiveText('Stock Bajo'),
                    subtitle: AdaptiveText('${getLowStockCount()} productos', style: TextStyle(color: Colors.red[700], fontWeight: FontWeight.bold)),
                    trailing: IconButton(icon: const Icon(Icons.trending_down), onPressed: () {}),
                  ),
                ),
                const SizedBox(height: 24),
                
                // Pestañas
                TabBar(
                  controller: _tabController,
                  tabs: const [
                    Tab(text: 'Stock Actual'),
                    Tab(text: 'Movimientos'),
                  ],
                ),
                
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      // Pestaña Stock Actual
                      ListView.builder(
                        itemCount: products.length,
                        itemBuilder: (context, index) {
                          final product = products[index];
                          return Card(
                            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            child: ListTile(
                              contentPadding: const EdgeInsets.all(12),
                              leading: Text(product['code'], style: const TextStyle(fontWeight: FontWeight.bold)),
                              title: AdaptiveText(product['name']),
                              subtitle: AdaptiveText('${product['stock']} ${product['unit']}'),
                              trailing: Row(mainAxisSize: MainAxisSize.min, children: [
                                Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                                  AdaptiveText('\$${product['cost'].toStringAsFixed(2)} CUP', style: const TextStyle(color: Colors.grey)),
                                  AdaptiveText('\$${product['sale'].toStringAsFixed(2)} CUP', style: const TextStyle(fontWeight: FontWeight.bold)),
                                ]),
                                const SizedBox(width: 12),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: product['status'] == 'OK' ? Colors.green[100] : Colors.red[100],
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: AdaptiveText(product['status'], style: TextStyle(color: product['status'] == 'OK' ? Colors.green[700] : Colors.red[700], fontWeight: FontWeight.bold, fontSize: 12)),
                                ),
                              ]),
                            ),
                          );
                        },
                      ),
                      
                      // Pestaña Movimientos
                      Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.history, size: 64, color: Colors.grey[400]),
                            const SizedBox(height: 16),
                            AdaptiveText('Sin movimientos registrados', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                            const SizedBox(height: 8),
                            AdaptiveText('Registra movimientos para ver el historial', style: TextStyle(color: Colors.grey[600])),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ]),
            ),
          ]),
          
          // Modal de Ajuste de Inventario
          if (showAdjustDialog)
            Dialog(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.stretch, children: [
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                    const AdaptiveText('Ajuste de Inventario', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    IconButton(icon: const Icon(Icons.close), onPressed: closeAdjustDialog),
                  ]),
                  const SizedBox(height: 16),
                  const AdaptiveText('Tipo de ajuste', style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      hint: const Text('Ajuste Positivo (+)'),
                      icon: const Icon(Icons.arrow_drop_down),
                      items: const [
                        DropdownMenuItem(value: 'positive', child: Text('Ajuste Positivo (+)')),
                        DropdownMenuItem(value: 'negative', child: Text('Ajuste Negativo (-)')),
                      ],
                      onChanged: (value) {},
                    ),
                  ),
                  const SizedBox(height: 16),
                  const AdaptiveText('Motivo', style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      hint: const Text('Conteo físico'),
                      icon: const Icon(Icons.arrow_drop_down),
                      items: const [
                        DropdownMenuItem(value: 'count', child: Text('Conteo físico')),
                        DropdownMenuItem(value: 'damage', child: Text('Daños')),
                        DropdownMenuItem(value: 'loss', child: Text('Pérdidas')),
                      ],
                      onChanged: (value) {},
                    ),
                  ),
                  const SizedBox(height: 16),
                  const AdaptiveText('Productos', style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'Buscar producto...',
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const AdaptiveText('Notas', style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  TextField(
                    maxLines: 3,
                    decoration: InputDecoration(
                      hintText: 'Escriba una nota...',
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: closeAdjustDialog,
                          style: OutlinedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 16), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                          child: const AdaptiveText('Cancelar'),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Ajuste confirmado')));
                            closeAdjustDialog();
                          },
                          style: ElevatedButton.styleFrom(backgroundColor: Colors.blue, foregroundColor: Colors.white, padding: const EdgeInsets.symmetric(vertical: 16), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                          child: const AdaptiveText('Confirmar Ajuste'),
                        ),
                      ),
                    ],
                  ),
                ]),
              ),
            ),
        ],
      ),
    );
  }
}
