enum EventCategory {
  alimentacion('alimentacion', 'Alimentación', '🍽️'),
  siestas('siestas', 'Siestas', '😴'),
  actividades('actividades', 'Actividades', '🎨'),
  deposiciones('deposiciones', 'Deposiciones', '🚽'),
  observaciones('observaciones', 'Observaciones', '👁️'),
  salud('salud', 'Salud', '🏥');

  const EventCategory(this.value, this.displayName, this.icon);

  final String value;
  final String displayName;
  final String icon;

  static EventCategory fromString(String value) {
    return EventCategory.values.firstWhere(
      (category) => category.value == value,
      orElse: () => EventCategory.observaciones,
    );
  }

  static List<EventCategory> get allCategories => EventCategory.values;

  String get colorHex {
    switch (this) {
      case EventCategory.alimentacion:
        return '#4CAF50'; // Verde
      case EventCategory.siestas:
        return '#9C27B0'; // Morado
      case EventCategory.actividades:
        return '#FF9800'; // Naranja
      case EventCategory.deposiciones:
        return '#795548'; // Marrón
      case EventCategory.observaciones:
        return '#2196F3'; // Azul
      case EventCategory.salud:
        return '#F44336'; // Rojo
    }
  }
}