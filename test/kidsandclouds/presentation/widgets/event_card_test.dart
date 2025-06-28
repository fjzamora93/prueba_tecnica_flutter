import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pruebakidsandclouds/kidsandclouds/data/models/event.dart';
import 'package:pruebakidsandclouds/kidsandclouds/data/models/eventCategory.dart';
import 'package:pruebakidsandclouds/kidsandclouds/presentation/widgets/event_card.dart';

void main() {
  testWidgets('EventCard muestra correctamente la información del evento', (WidgetTester tester) async {

    // 1. Comenzamos creando un evento de prueba (mockEvent) que utilizaremos para renderizar el widget EventCard.
    final mockEvent = Event(
      id: '1',
      category: EventCategory.alimentacion,
      title: 'Desayuno completo',
      description: 'El niño tomó un desayuno nutritivo con frutas y cereales.',
      date: 'Lunes 27, 08:15',
      userId: 'user1',
    );

    // 2. Act - Renderizar el widget con testter.pumpWidget
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: EventCard(event: mockEvent),
        ),
      ),
    );

    /**
     * 3. Utilizamos expect(find.text(...), findsOneWidget) para recorrer el widget completo y buscar el String en la pantalla.
     */
    expect(find.text('Alimentación'), findsOneWidget); // Nombre de la categoría
    expect(find.text('Lunes 27, 08:15'), findsOneWidget); // Fecha
    expect(find.text('Desayuno completo'), findsOneWidget); // Título
    expect(find.text('El niño tomó un desayuno nutritivo con frutas y cereales.'), findsOneWidget); // Descripción
    expect(find.text('🍽️'), findsOneWidget); // Icono de la categoría
  });
}
