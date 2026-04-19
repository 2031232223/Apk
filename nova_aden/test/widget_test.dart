import 'package:flutter_test/flutter_test.dart';
import 'package:nova_aden/main.dart';

void main() {
  testWidgets('Contratación básica de nova-ADEN', (WidgetTester tester) async {
    // Construir nuestra app y activar un frame.
    // CORRECCIÓN: Asegurar sintaxis correcta de NovaAdenApp
    await tester.pumpWidget(const NovaAdenApp());

    // Verificar que el Dashboard se carga (buscando el texto "Dashboard")
    expect(find.text('Dashboard'), findsOneWidget);
    
    // Verificar que el botón "Nueva Venta" existe
    expect(find.text('Nueva Venta'), findsOneWidget);
  });
}
