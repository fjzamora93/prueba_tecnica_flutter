
import 'package:pruebakidsandclouds/kidsandclouds/data/models/child.dart';
import 'package:pruebakidsandclouds/kidsandclouds/data/repositories/child_repository.dart';

import 'dart:math';

class ChildUsecase {
  final ChildRepository _childRepository;
  final Random _random = Random();

  ChildUsecase(this._childRepository);

  // GET ALL CHILDREN
  /**
   * Aplicamos en el caso de filtro un uso que nos quite todos los casos donde la Id tenga un valor nulo.
   * DE esta forma nos ahorraremos el probelma de después navegar a un detalle de un niño que no existe.
   */
   Future<List<Child>> getChildren({int results = 10}) async {
    final childrenList = await _childRepository.getChildren(results: results);

    // Filtra los que tengan id.value null o vacío
    final filteredChildren = childrenList.where((child) {
      final idValue = child.id['value'];
      return idValue != null && idValue.toString().trim().isNotEmpty;
    }).toList();

    // Retorna una lista de Child con edad aleatoria
    return filteredChildren.map((child) {
      final newAge = _random.nextInt(6); // 0..5
      return Child(
        gender: child.gender,
        email: child.email,
        phone: child.phone,
        cell: child.cell,
        nat: child.nat,
        name: Map<String, dynamic>.from(child.name),
        location: Map<String, dynamic>.from(child.location),
        login: Map<String, dynamic>.from(child.login),
        id: Map<String, dynamic>.from(child.id),
        picture: child.picture,
        dob: {
          ...child.dob,
          'age': newAge,
        },
      );
    }).toList();
  }

  // GET CHILD BY ID
  Future<Child> getChildById(String id) async {
    final child = await _childRepository.getChildById(id);

    final idValue = child.id['value'];
    if (idValue == null || idValue.toString().trim().isEmpty) {
      throw Exception('El ID del niño es inválido (nulo o vacío).');
    }

    final newAge = _random.nextInt(6); // 0..5
    return Child(
      gender: child.gender,
      email: child.email,
      phone: child.phone,
      cell: child.cell,
      nat: child.nat,
      name: Map<String, dynamic>.from(child.name),
      location: Map<String, dynamic>.from(child.location),
      login: Map<String, dynamic>.from(child.login),
      id: Map<String, dynamic>.from(child.id),
      picture: child.picture,
      dob: {
        ...child.dob,
        'age': newAge,
      },
    );
  }
}
