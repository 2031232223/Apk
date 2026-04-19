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