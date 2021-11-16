import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../model/pokemon.dart';

class PokemonsDatabase {
  static final PokemonsDatabase instance = PokemonsDatabase._init();

  static Database? _database;

  PokemonsDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('pokemons.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    const String idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const String textType = 'TEXT NOT NULL';
    const String integerType = 'INTEGER NOT NULL';

    await db.execute('''
      CREATE TABLE $tablePokemons ( 
        ${PokemonFields.id} $idType, 
        ${PokemonFields.number} $integerType,
        ${PokemonFields.name} $textType,
        ${PokemonFields.time} $textType
      )
    ''');
  }

  Future<Pokemon> insertPokemon(Pokemon pokemon) async {
    final db = await instance.database;

    final id = await db.insert(tablePokemons, pokemon.toJson());
    return pokemon.copy(id: id);
  }

  Future<List<Pokemon>> readAllPokemons() async {
    final db = await instance.database;

    final orderBy = '${PokemonFields.time} ASC';

    final result = await db.query(tablePokemons, orderBy: orderBy);

    return result.map((json) => Pokemon.fromJson(json)).toList();
  }

  Future<List<Pokemon>> groupPokemons() async {
    final db = await instance.database;

    final result = await db.query(tablePokemons, groupBy: PokemonFields.number);

    return result.map((json) => Pokemon.fromJson(json)).toList();
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
