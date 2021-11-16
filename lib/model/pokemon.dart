const String tablePokemons = 'pokemons';

class PokemonFields {
  static final List<String> values = [
    /// Add all fields
    id, number, name, time
  ];

  static const String id = '_id';
  static const String number = 'number';
  static const String name = 'name';
  static const String time = 'time';
}

class Pokemon {
  final int? id;
  final int number;
  final String name;
  final DateTime createdTime;

  const Pokemon({
    this.id,
    required this.number,
    required this.name,
    required this.createdTime,
  });

  Pokemon copy({
    int? id,
    int? number,
    String? name,
    DateTime? createdTime,
  }) =>
      Pokemon(
        id: id ?? this.id,
        number: number ?? this.number,
        name: name ?? this.name,
        createdTime: createdTime ?? this.createdTime,
      );

  static Pokemon fromJson(Map<String, Object?> json) => Pokemon(
        id: json[PokemonFields.id] as int?,
        number: json[PokemonFields.number] as int,
        name: json[PokemonFields.name] as String,
        createdTime: DateTime.parse(json[PokemonFields.time] as String),
      );

  Map<String, Object?> toJson() => {
        PokemonFields.id: id,
        PokemonFields.number: number,
        PokemonFields.name: name,
        PokemonFields.time: createdTime.toIso8601String(),
      };
}
