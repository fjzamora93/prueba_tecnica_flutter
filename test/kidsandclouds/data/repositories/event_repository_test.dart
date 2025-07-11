import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pruebakidsandclouds/kidsandclouds/data/repositories/event_repository_impl.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  // JSON mock que coincida con tu modelo Event real
  const mockJson = '''
  [
    {
      "id": "1",
      "category": "alimentacion",
      "title": "Almuerzo",
      "description": "Almuerzo completo",
      "date": "2024-01-15",
      "userId": "a"
    },
    {
      "id": "2", 
      "category": "siestas",
      "title": "Siesta de la tarde",
      "description": "Descansó bien",
      "date": "2024-01-15",
      "userId": "a"
    }
  ]
  ''';

  // Interceptamos la carga del archivo JSON para devolver nuestro mock
  setUp(() {
    ServicesBinding.instance.defaultBinaryMessenger.setMockMessageHandler('flutter/assets', (message) async {
      final String key = utf8.decode(message!.buffer.asUint8List());
      if (key == 'assets/data/events.json') {
        return ByteData.view(Uint8List.fromList(utf8.encode(mockJson)).buffer);
      }
      return null;
    });
  });

  // Testamos que se cargan los eventos filtrados
  test('getFilteredEvents devuelve solo los eventos de la categoría solicitada', () async {
    final repo = EventRepositoryImpl();

    // Filtramos (por ejemplo por alimentación)
    final events = await repo.getFilteredEvents('alimentacion');

    // Esperamos que devuelva 1 evento
    expect(events.length, 1);
    expect(events.first.title, 'Almuerzo');
    expect(events.first.category.value, 'alimentacion');
  });


  // testamos que se devuelven todos los eventos
  test('getEvents devuelve todos los eventos', () async {
    final repo = EventRepositoryImpl();
    final events = await repo.getEvents();
    expect(events.length, 2);
  });
}