import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_application_prueba/views/home_page.dart';

void main() {
  testWidgets('Verifica que la barra de búsqueda esté presente', (WidgetTester tester) async {
    // Construye la aplicación y espera que esté lista.
    await tester.pumpWidget(
      MaterialApp(
        home: HomePage(),
      ),
    );

    // Verifica que la barra de búsqueda esté en pantalla.
    expect(find.byType(TextField), findsOneWidget);

    // Verifica que el texto inicial sea "Buscar cartas...".
    expect(find.text('Buscar cartas...'), findsOneWidget);
  });
}
