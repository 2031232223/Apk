import 'package:flutter/material.dart';
import '../../domain/entities/product.dart';
import '../widgets/app_drawer.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Datos de ejemplo
    List<Product> products = [
      Product(id: 1, name: 'Arroz (1 lb)', code: 'ARR001', cost: 60, price: 180, stock: 50, unit: 'lb'),
      Product(id: 2, name: 'Jabón de Baño', code: 'JAB001', cost: 45, price: 130, stock: 3, unit: 'unidad'),
      Product(id: 3, name: 'Refresco Cola 1.5L', code: 'REF001', cost: 95, price: 280, stock: 30, unit: 'unidad'),
      Product(id: 4, name: 'Cerveza Nacional', code: 'CER001', cost: 85, price: 250, stock: 2, unit: 'unidad'),
      Product(id: 5, name: 'Pollo (1 lb)', code: 'POL001', cost: 150, price: 450, stock: 20, unit: 'lb'),
      Product(id: 6, name: 'Café Molido 250g', code: 'CAF001', cost: 200, price: 600, stock: 8, unit: 'unidad'),
    ];

    return Scaffold(
      appBar: AppBar(title: Text('Productos'), elevation: 0),
      drawer: const AppDrawer(),
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('7 productos activos', style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.grey[600])),
            const SizedBox(height: 12),
            Row(children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {}, // Lógica de nuevo producto
                  icon: const Icon(Icons.add),
                  label: const Text('Nuevo Producto'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                ),
              ),
            ]),
            const SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                hintText: 'Buscar por nombre o código...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                filled: true,
                fillColor: Colors.grey[50],
              ),
            ),
            const SizedBox(height: 16),
            // Filtros simples
            Row(children: [
              Expanded(child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  hint: const Text('Todas'),
                  icon: const Icon(Icons.arrow_drop_down),
                  items: const [DropdownMenuItem(value: 'all', child: Text('Todas'))],
                  onChanged: (value) {},
                ),
              )),
              const SizedBox(width: 8),
              Expanded(child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  hint: const Text('Todo el stock'),
                  icon: const Icon(Icons.arrow_drop_down),
                  items: const [DropdownMenuItem(value: 'all', child: Text('Todo el stock'))],
                  onChanged: (value) {},
                ),
              )),
            ]),
          ]),
        ),
        
        // Lista de Productos
        Expanded(
          child: ListView.builder(
            itemCount: products.length,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemBuilder: (context, index) {
              final product = products[index];
              final isLowStock = product.stock <= product.minStock;
              
              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                elevation: 2,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Row(children: [
                      Icon(Icons.star, color: Colors.orange[700], size: 16),
                      const SizedBox(width: 8),
                      Expanded(child: Text(product.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16))),
                    ]),
                    const SizedBox(height: 4),
                    Text(product.code, style: TextStyle(color: Colors.grey[600], fontSize: 12)),
                    const Divider(height: 20),
                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Text('\$${product.price.toStringAsFixed(2)} CUP', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.blue)),
                        Text('\$${product.cost.toStringAsFixed(2)} MLC', style: TextStyle(color: Colors.grey[600], fontSize: 12)),
                      ]),
                      Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                        Text('${product.stock} ${product.unit}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                        if (isLowStock) ...[
                          const SizedBox(height: 4),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(color: Colors.red[100], borderRadius: BorderRadius.circular(4)),
                            child: Row(mainAxisSize: MainAxisSize.min, children: [
                              Icon(Icons.warning_amber, color: Colors.red[700], size: 12),
                              const SizedBox(width: 4),
                              Text('Stock bajo', style: TextStyle(color: Colors.red[700], fontSize: 10, fontWeight: FontWeight.bold)),
                            ]),
                          ),
                        ],
                      ]),
                    ]),
                  ]),
                ),
              );
            },
          ),
        ),
      ]),
    );
  }
}
