import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pruebakidsandclouds/kidsandclouds/presentation/providers/event_provider.dart';
import 'package:pruebakidsandclouds/kidsandclouds/presentation/view/daily_journal_screen.dart';

void main() {
  testWidgets('Muestra el error cuando el estado es error', (WidgetTester tester) async {
    
    // Creamos un ProviderContainer con el estado de error
    final container = ProviderContainer(
      overrides: [
        eventProvider.overrideWith(() {
          final notifier = EventNotifier();
          return notifier;
        }),
      ],
    );

    // Montamos el widget con ProviderScope
    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: const MaterialApp(
          home: DailyJournalScreen(),
        ),
      ),
    );

    // Dejamos que termine de construir
    await tester.pumpAndSettle();

    // Verificamos que aparezca el icono de error
    expect(find.byIcon(Icons.error_outline), findsOneWidget);

    // Verificamos que aparezca el texto de error
    expect(find.text('Error al cargar eventos'), findsOneWidget);

    // Verificamos que aparezca el botón de reintentar
    expect(find.text('Reintentar'), findsOneWidget);
  });
}