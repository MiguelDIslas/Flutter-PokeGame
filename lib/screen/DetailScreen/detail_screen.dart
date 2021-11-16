import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../constants.dart';
import '../../components/row_details.dart';
import '../../components/row_evolution.dart';
import '../../db/pokemons_database.dart';
import '../../global.dart';

class PokemonDetailScreen extends StatefulWidget {
  final dynamic pokemonDetail;
  final int heroTag;
  final bool isNew;
  const PokemonDetailScreen(
      {Key? key,
      this.pokemonDetail,
      required this.heroTag,
      required this.isNew})
      : super(key: key);

  @override
  _PokemonDetailScreenState createState() => _PokemonDetailScreenState();
}

class _PokemonDetailScreenState extends State<PokemonDetailScreen> {
  @override
  void initState() {
    super.initState();
    refreshPokemons();
  }

  Future refreshPokemons() async {
    setState(() {});
    pokemons = await PokemonsDatabase.instance.readAllPokemons();
    groupPokemons = await PokemonsDatabase.instance.groupPokemons();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: pokemonColor[widget.pokemonDetail['type'][0]],
      body: SafeArea(
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Positioned(
              top: 10,
              left: 1,
              child: IconButton(
                onPressed: () {
                  refreshPokemons();
                  ownPokemons = pokemons.map((e) => e.number).toList();
                  Navigator.pop(context);
                  setState(() {});
                },
                icon:
                    const Icon(Icons.arrow_back, color: Colors.white, size: 30),
              ),
            ),
            Positioned(
              top: 60,
              left: 20,
              child:
                  Text(widget.pokemonDetail['name'], style: kTitleDecoration),
            ),
            Positioned(
              top: 60,
              right: 20,
              child: Text('#' + widget.pokemonDetail['num'],
                  style: kTitleDecoration.copyWith(color: Colors.white)),
            ),
            Positioned(
              top: 110,
              left: 20,
              child: Container(
                decoration: kTypeBoxDecoration,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                  child: Text(
                    widget.pokemonDetail['type'].join(', '),
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
            Positioned(
              top: size.height * 0.15,
              right: -30,
              child: Image.asset(
                'assets/img/pokeball.png',
                height: 200,
                fit: BoxFit.fitHeight,
              ),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                width: size.width,
                height: size.height * 0.6,
                decoration: kDetailContainer,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: widget.isNew
                              ? Text(
                                  'Congratulations you catch a ${widget.pokemonDetail['name']}',
                                  style: kTextDescriptionInfoStyle)
                              : const Text('')),
                      RowDetail(
                          data: 'Name', info: widget.pokemonDetail['name']),
                      RowDetail(
                          data: 'Height', info: widget.pokemonDetail['height']),
                      RowDetail(
                          data: 'Weight', info: widget.pokemonDetail['weight']),
                      RowDetail(
                          data: 'Avg Spawn',
                          info: widget.pokemonDetail['avg_spawns'].toString()),
                      RowDetail(
                          data: 'Spawn Time',
                          info: widget.pokemonDetail['spawn_time']),
                      RowDetail(
                          data: 'Weakness',
                          info: widget.pokemonDetail['weaknesses'].join(', ')),
                      RowDetail(
                          data: 'Candy', info: widget.pokemonDetail['candy']),
                      RowEvolution(
                        evolution: widget.pokemonDetail['prev_evolution'],
                        evolutionTitle: 'Pre Form',
                        evolutionData: 'Just Hatched',
                      ),
                      RowEvolution(
                        evolution: widget.pokemonDetail['next_evolution'],
                        evolutionTitle: 'Evolution',
                        evolutionData: 'Maxed Out',
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              top: (size.height * 0.12),
              left: (size.width / 2) - 100,
              child: Hero(
                tag: widget.heroTag,
                child: CachedNetworkImage(
                  imageUrl: widget.pokemonDetail['img'],
                  useOldImageOnUrlChange: true,
                  height: 200,
                  fit: BoxFit.fitHeight,
                  errorWidget: (context, url, error) => const Icon(
                      Icons.network_check_outlined,
                      color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
