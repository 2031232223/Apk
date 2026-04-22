import 'package:flutter/material.dart';
import '../widgets/app_drawer.dart';
import '../widgets/adaptive_text.dart';

class PurchasesScreen extends StatefulWidget {
  const PurchasesScreen({super.key});

  @override
  State<PurchasesScreen> createState() => _PurchasesScreenState();
}

class _PurchasesScreenState extends State<PurchasesScreen> {
  bool showNewPurchaseDialog = false;
  String selectedDate = '';
  bool isSupplierMode = false;

  void openNewPurchaseDialog() {
    setState(() {
      showNewPurchaseDialog = true;
      isSupplierMode = false;
      selectedDate = '';
    });
  }

  void closeNewPurchaseDialog() {
    setState(() {
      showNewPurchaseDialog = false;
    });
  }

  void toggleSupplierMode() {
    setState(() {
      isSupplierMode = !isSupplierMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Compras'), elevation: 0),
      drawer: const AppDrawer(),
      body: Stack(
        children: [
          Column(children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                AdaptiveText('Compras', style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                AdaptiveText('0 compras registradas', style: TextStyle(color: Colors.grey[600])),
                const SizedBox(height: 16),
                ElevatedButton.icon(
                  onPressed: openNewPurchaseDialog,
                  icon: const Icon(Icons.add),
                  label: const Text('Nueva Compra'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  readOnly: true,
                  decoration: InputDecoration(
                    hintText: 'dd/mm/aaaa',
                    prefixIcon: const Icon(Icons.calendar_today),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    filled: true,
                    fillColor: Colors.grey[50],
                  ),
                  onTap: () {
                    // Aquí abrirías un picker de fecha real
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Abrir selector de fecha')));
                  },
                ),
                const SizedBox(height: 16),
                DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    hint: const Text('Todos'),
                    icon: const Icon(Icons.arrow_drop_down),
                    items: const [DropdownMenuItem(value: 'all', child: Text('Todos'))],
                    onChanged: (value) {},
                  ),
                ),
              ]),
            ),
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.local_shipping, size: 64, color: Colors.grey[400]),
                    const SizedBox(height: 16),
                    AdaptiveText('Sin compras', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    AdaptiveText('Registra compras para actualizar tu inventario', style: TextStyle(color: Colors.grey[600])),
                  ],
                ),
              ),
            ),
          ]),
          
          // Modal de Nueva Compra
          if (showNewPurchaseDialog)
            Dialog(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.stretch, children: [
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                    const AdaptiveText('Nueva Compra', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    IconButton(icon: const Icon(Icons.close), onPressed: closeNewPurchaseDialog),
                  ]),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(child: TextButton(
                        onPressed: () => setState(() => isSupplierMode = false),
                        style: TextButton.styleFrom(foregroundColor: isSupplierMode ? Colors.grey : Colors.blue),
                        child: const Text('Rápida'),
                      )),
                      Expanded(child: TextButton(
                        onPressed: () => setState(() => isSupplierMode = true),
                        style: TextButton.styleFrom(foregroundColor: isSupplierMode ? Colors.blue : Colors.grey),
                        child: const Text('Con Proveedor'),
                      )),
                    ],
                  ),
                  const Divider(height: 32),
                  if (isSupplierMode) ...[
                    const AdaptiveText('Proveedor', style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        hint: const Text('Seleccionar proveedor'),
                        icon: const Icon(Icons.arrow_drop_down),
                        items: const [DropdownMenuItem(value: 'all', child: Text('Proveedor A'),), DropdownMenuItem(value: 'all', child: Text('Proveedor B'))],
                        onChanged: (value) {},
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                  const AdaptiveText('Agregar productos', style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'Buscar producto...',
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                    const AdaptiveText('Total:', style: TextStyle(fontWeight: FontWeight.bold)),
                    AdaptiveText('\$0.00 CUP', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blue)),
                  ]),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      // Lógica de confirmación
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Compra confirmada')));
                      closeNewPurchaseDialog();
                    },
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.blue, foregroundColor: Colors.white, padding: const EdgeInsets.symmetric(vertical: 16), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                    child: const AdaptiveText('Confirmar Compra'),
                  ),
                  TextButton(onPressed: closeNewPurchaseDialog, child: const Text('Cancelar')),
                ]),
              ),
            ),
        ],
      ),
    );
  }
}
