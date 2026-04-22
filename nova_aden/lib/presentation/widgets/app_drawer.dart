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
          ListTile(leading: const Icon(Icons.point_of_sale), title: const Text('Punto de Venta'), onTap: () { Navigator.pop(context); Navigator.pushNamed(context, '/sales'); }),
          // Botón INVENTARIO - CONECTADO AL NUEVO MÓDULO
          ListTile(
            leading: const Icon(Icons.inventory_2),
            title: const Text('Inventario'),
            onTap: () { 
              Navigator.pop(context); // Cierra el menú
              Navigator.pushNamed(context, '/inventory'); // Abre el nuevo módulo de inventario
            },
          ),
          ListTile(
            leading: const Icon(Icons.receipt_long),
            title: const Text('Compras'),
            onTap: () { 
              Navigator.pop(context); 
              Navigator.pushNamed(context, '/purchases'); 
            },
          ),
          ListTile(leading: const Icon(Icons.warning_amber), title: const Text('Mermas'), onTap: () => Navigator.pop(context)),
          ListTile(leading: const Icon(Icons.assessment), title: const Text('Reportes'), onTap: () => Navigator.pop(context)),
          const Divider(),
          ListTile(leading: const Icon(Icons.settings), title: const Text('Configuración'), onTap: () => Navigator.pop(context)),
        ],
      ),
    );
  }
}
