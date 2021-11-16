import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../DetailScreen/detail_screen.dart';
import '../Pokedex/pokedex_screen.dart';
import '../ProfileScreen/profile.dart';
import '../../db/pokemons_database.dart';
import '../../model/pokemon.dart';
import '../../global.dart';

class DashboardScreen extends StatefulWidget {
  static String id = "/dashboard";

  const DashboardScreen({Key? key}) : super(key: key);

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  bool isLoading = false;
  int _currentIndex = 0;
  Random random = Random();
  late int numberPokemon = 0;

  static final tabs = [
    const Profile(),
    const Pokedex(),
  ];

  @override
  void initState() {
    if (mounted) fetchPokemonData();
    refreshPokemons();
    super.initState();
  }

  @override
  void dispose() {
    PokemonsDatabase.instance.close();
    super.dispose();
  }

  Future refreshPokemons() async {
    setState(() => isLoading = true);
    pokemons = await PokemonsDatabase.instance.readAllPokemons();
    groupPokemons = await PokemonsDatabase.instance.groupPokemons();
    setState(() => isLoading = false);
    ownPokemons = pokemons.map((e) => e.number).toList();
  }

  void fetchPokemonData() {
    var url = Uri.https("raw.githubusercontent.com",
        "/Biuni/PokemonGO-Pokedex/master/pokedex.json");

    http.get(url).then(
      (value) {
        if (value.statusCode == 200) {
          var decodedJsonData = jsonDecode(value.body);
          pokedex = decodedJsonData['pokemon'];
          setState(() {});
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.redAccent,
        child: const Icon(Icons.catching_pokemon_outlined),
        onPressed: () {
          int randomNumber = random.nextInt(151) + 1;
          setState(() => numberPokemon = randomNumber);
          addPokemon();
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => PokemonDetailScreen(
                  pokemonDetail: pokedex[numberPokemon - 1],
                  heroTag: randomNumber,
                  isNew: true),
            ),
          );
          refreshPokemons();
        },
      ),
      body: tabs[_currentIndex],
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        clipBehavior: Clip.antiAlias,
        notchMargin: 5,
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (val) {
            setState(() => _currentIndex = val);
          },
          items: [
            BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'assets/img/trainer.svg',
                  width: 30,
                  height: 30,
                  color: _currentIndex == 0 ? Colors.redAccent : Colors.black,
                  fit: BoxFit.fitHeight,
                ),
                label: ''),
            BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'assets/img/pokedex.svg',
                  width: 30,
                  height: 30,
                  color: _currentIndex == 1 ? Colors.redAccent : Colors.black,
                  fit: BoxFit.fitHeight,
                ),
                label: ''),
          ],
        ),
      ),
    );
  }

  Future addPokemon() async {
    final pokemon = Pokemon(
      number: numberPokemon,
      name: pokedex[numberPokemon - 1]['name'],
      createdTime: DateTime.now(),
    );

    await PokemonsDatabase.instance.insertPokemon(pokemon);
  }
}
