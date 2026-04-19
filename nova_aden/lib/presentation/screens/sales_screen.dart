import 'package:flutter/material.dart';
import '../../domain/entities/product.dart';
import '../widgets/app_drawer.dart';
import '../widgets/adaptive_text.dart';

class SalesScreen extends StatefulWidget {
  const SalesScreen({super.key});

  @override
  State<SalesScreen> createState() => _SalesScreenState();
}

class _SalesScreenState extends State<SalesScreen> {
  final TextEditingController searchController = TextEditingController();
  
  List<Product> products = [
    Product(id: 1, name: 'Arroz (1 lb)', code: 'ARR001', cost: 60, price: 180, stock: 50),
    Product(id: 2, name: 'Jabón de Baño', code: 'JAB001', cost: 45, price: 130, stock: 3),
    Product(id: 3, name: 'Refresco Cola 1.5L', code: 'REF001', cost: 95, price: 280, stock: 30),
    Product(id: 4, name: 'Cerveza Nacional', code: 'CER001', cost: 85, price: 250, stock: 2),
    Product(id: 5, name: 'Pollo (1 lb)', code: 'POL001', cost: 150, price: 450, stock: 20),
    Product(id: 6, name: 'Café Molido 250g', code: 'CAF001', cost: 200, price: 600, stock: 8),
  ];

  List<Map<String, dynamic>> cart = [];
  String currentInput = '';

  void addToCart(Product product, int quantity) {
    setState(() {
      var existingItemIndex = cart.indexWhere((item) => item['product'].id == product.id);
      if (existingItemIndex != -1) {
        cart[existingItemIndex]['quantity'] += quantity;
      } else {
        cart.add({'product': product, 'quantity': quantity});
      }
    });
  }

  double getSubtotal() {
    return cart.fold(0.0, (sum, item) => sum + (item['product'].price * item['quantity']));
  }

  @override
  Widget build(BuildContext context) {
    final filteredProducts = products.where((p) => 
      p.name.toLowerCase().contains(searchController.text.toLowerCase()) ||
      p.code.toLowerCase().contains(searchController.text.toLowerCase())
    ).toList();

    return Scaffold(
      appBar: AppBar(title: Text('Nueva Venta'), elevation: 0),
      drawer: const AppDrawer(),
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextField(
            controller: searchController,
            decoration: InputDecoration(
              hintText: 'Buscar producto...',
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              filled: true,
              fillColor: Colors.grey[50],
            ),
          ),
        ),
        
        Expanded(
          child: ListView.builder(
            itemCount: filteredProducts.length,
            itemBuilder: (context, index) {
              final product = filteredProducts[index];
              final isLowStock = product.stock <= product.minStock;
              
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                elevation: 2,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  title: AdaptiveText(product.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  subtitle: AdaptiveText(product.code, style: TextStyle(color: Colors.grey[600], fontSize: 12)),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Precio ajustable
                      AdaptiveText('\$${product.price.toStringAsFixed(2)} CUP', 
                        style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.blue)),
                      const SizedBox(width: 8),
                      if (isLowStock)
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(color: Colors.red[100], borderRadius: BorderRadius.circular(12)),
                          child: AdaptiveText('${product.stock} unid', style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 12)),
                        )
                      else
                        AdaptiveText('${product.stock} unid', style: TextStyle(color: Colors.grey[700], fontWeight: FontWeight.bold)),
                    ],
                  ),
                  onTap: () => addToCart(product, 1),
                ),
              );
            },
          ),
        ),

        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10)],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const AdaptiveText('Carrito:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      AdaptiveText('${cart.length} items', style: const TextStyle(color: Colors.blue)),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const AdaptiveText('Total:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      // El total aquí también se ajustará si es muy grande
                      AdaptiveText('\$${getSubtotal().toStringAsFixed(2)} CUP', 
                        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.green)),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () {
                        setState(() {
                          cart.clear();
                          currentInput = '';
                        });
                      },
                      icon: const Icon(Icons.delete_outline),
                      label: const AdaptiveText('Limpiar'),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    flex: 2,
                    child: ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.payment),
                      label: const AdaptiveText('Cobrar'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
