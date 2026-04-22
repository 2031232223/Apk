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
          // Botón Dashboard
          ListTile(
            leading: const Icon(Icons.dashboard),
            title: const Text('Dashboard'),
            onTap: () {
              Navigator.pop(context); // Cerrar menú
              // No hacemos nada porque ya estamos en la home
            },
          ),
          // Botón VENTAS (Conectado a la ruta '/sales')
          ListTile(
            leading: const Icon(Icons.point_of_sale),
            title: const Text('Punto de Venta'),
            onTap: () {
              Navigator.pop(context); // Cerrar menú primero
              Navigator.pushNamed(context, '/sales'); // Navegar a Ventas
            },
          ),
          // Botón INVENTARIO (Conectado a la ruta '/products')
          ListTile(
            leading: const Icon(Icons.inventory_2),
            title: const Text('Inventario'),
            onTap: () {
              Navigator.pop(context); // Cerrar menú primero
              Navigator.pushNamed(context, '/products'); // Navegar a Inventario
            },
          ),
          ListTile(
            leading: const Icon(Icons.receipt_long),
            title: const Text('Compras'),
            onTap: () => Navigator.pop(context),
          ),
          ListTile(
            leading: const Icon(Icons.warning_amber),
            title: const Text('Mermas'),
            onTap: () => Navigator.pop(context),
          ),
          ListTile(
            leading: const Icon(Icons.assessment),
            title: const Text('Reportes'),
            onTap: () => Navigator.pop(context),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Configuración'),
            onTap: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }
}
