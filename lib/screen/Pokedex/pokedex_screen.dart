import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:math';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:http/http.dart' as http;

import '../DetailScreen/detail_screen.dart';
import '../../constants.dart';
import '../../global.dart';

class Pokedex extends StatefulWidget {
  static const String id = '/pokedex';
  const Pokedex({Key? key}) : super(key: key);

  @override
  _PokedexState createState() => _PokedexState();
}

class _PokedexState extends State<Pokedex> with SingleTickerProviderStateMixin {
  //pokeApi = "https://raw.githubusercontent.com/Biuni/PokemonGO-Pokedex/master/pokedex.json"

  late AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _controller.repeat();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color(0xFF282828),
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              top: -50,
              right: -50,
              child: AnimatedBuilder(
                animation: _controller.view,
                builder: (context, child) {
                  return Transform.rotate(
                    angle: _controller.value * 2 * pi,
                    child: child,
                  );
                },
                child: Image.asset('assets/img/pokeball.png',
                    width: 200, fit: BoxFit.fitWidth),
              ),
            ),
            const Positioned(
                top: 80,
                left: 30,
                child: Text('Pokédex', style: kTitleDecoration)),
            Positioned(
              top: 160,
              bottom: 0,
              width: size.width,
              child: Column(
                children: <Widget>[
                  pokedex != []
                      ? Expanded(
                          child: GridView.builder(
                              gridDelegate: kGridDelegate,
                              itemCount: pokedex.length,
                              itemBuilder: (context, index) {
                                var type = pokedex[index]['type'][0];
                                var id = pokedex[index]['id'];
                                return InkWell(
                                  onTap: () {
                                    if (ownPokemons.contains(id)) {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) => PokemonDetailScreen(
                                              pokemonDetail: pokedex[index],
                                              heroTag: index,
                                              isNew: false),
                                        ),
                                      );
                                    }
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8.0, horizontal: 12),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: pokemonColor[type.toString()],
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(20)),
                                      ),
                                      child: Stack(
                                        children: <Widget>[
                                          Positioned(
                                            bottom: -10,
                                            right: -10,
                                            child: Image.asset(
                                                'assets/img/pokeball.png',
                                                height: 100,
                                                fit: BoxFit.fitHeight),
                                          ),
                                          Positioned(
                                            bottom: ownPokemons.contains(id)
                                                ? 5
                                                : 15,
                                            right: ownPokemons.contains(id)
                                                ? 5
                                                : 15,
                                            child: Hero(
                                              tag: index,
                                              child: ownPokemons.contains(id)
                                                  ? CachedNetworkImage(
                                                      imageUrl: pokedex[index]
                                                          ['img'],
                                                      height: 100,
                                                      fit: BoxFit.fitHeight,
                                                    )
                                                  : Image.asset(
                                                      'assets/img/signo.png',
                                                      height: 70,
                                                      fit: BoxFit.fitHeight,
                                                    ),
                                            ),
                                          ),
                                          Positioned(
                                            top: 20,
                                            left: 10,
                                            child: ownPokemons.contains(id)
                                                ? Text(pokedex[index]['name'],
                                                    style:
                                                        kPokemonTitleDecoration)
                                                : const Text('???????',
                                                    style:
                                                        kPokemonTitleDecoration),
                                          ),
                                          Positioned(
                                            top: 45,
                                            left: 10,
                                            child: Container(
                                              decoration: kTypeBoxDecoration,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 4,
                                                        horizontal: 8),
                                                child: Text(
                                                  ownPokemons.contains(id)
                                                      ? type.toString()
                                                      : '?????',
                                                  style: const TextStyle(
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }),
                        )
                      : kProgressWidget,
                ],
              ),
            ),
          ],
        ),
      ),
    );
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
}
