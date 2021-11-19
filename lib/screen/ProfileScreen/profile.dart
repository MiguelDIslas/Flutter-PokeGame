import 'package:flutter/material.dart';
import 'dart:math';
import '../../constants.dart';
import '../../global.dart';
import '../../db/pokemons_database.dart';

class Profile extends StatefulWidget {
  static const String id = '/pokedex';
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _controller.repeat();
    refreshPokemons();
    setState(() => super.initState());
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future refreshPokemons() async {
    setState(() {});
    pokemons = await PokemonsDatabase.instance.readAllPokemons();
    groupPokemons = await PokemonsDatabase.instance.groupPokemons();
    setState(() {});
    ownPokemons = pokemons.map((e) => e.number).toList();
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
                child: Text('Profile', style: kTitleDecoration)),
            Positioned(
              top: 160,
              bottom: 0,
              width: size.width,
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          const SizedBox(height: 20),
                          Text('Trainer information',
                              style: kTitleDecoration.copyWith(fontSize: 22)),
                          const SizedBox(height: 20),
                          Image.asset('assets/img/trainer_icon.png',
                              width: 100, fit: BoxFit.fitWidth),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text('First pokémon: ', style: kAttributes),
                              pokemons.isNotEmpty
                                  ? Flexible(
                                      child: SizedBox(
                                          child: Text(pokemons[0].name,
                                              style: kAttributes.copyWith(
                                                  fontWeight:
                                                      FontWeight.bold))))
                                  : Flexible(
                                      child: SizedBox(
                                        child: Text(
                                          "You still haven't caught a pokémon",
                                          style: kAttributes.copyWith(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    )
                            ],
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'Last pokémon: ',
                                style: kAttributes,
                                textAlign: TextAlign.left,
                              ),
                              pokemons.isNotEmpty
                                  ? Flexible(
                                      child: SizedBox(
                                        child: Text(
                                            pokemons[pokemons.length - 1].name,
                                            style: kAttributes.copyWith(
                                                fontWeight: FontWeight.bold)),
                                      ),
                                    )
                                  : Flexible(
                                      child: SizedBox(
                                        child: Text(
                                            "You still haven't caught a pokémon",
                                            style: kAttributes.copyWith(
                                                fontWeight: FontWeight.bold)),
                                      ),
                                    )
                            ],
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "You've caught: ",
                                style: kAttributes,
                                textAlign: TextAlign.left,
                              ),
                              pokemons.isNotEmpty
                                  ? Text('${groupPokemons.length} pokémons',
                                      style: kAttributes.copyWith(
                                          fontWeight: FontWeight.bold))
                                  : Flexible(
                                      child: SizedBox(
                                        child: Text(
                                            "You still haven't caught a pokémon",
                                            style: kAttributes.copyWith(
                                                fontWeight: FontWeight.bold)),
                                      ),
                                    )
                            ],
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'Total attempts: ',
                                style: kAttributes,
                                textAlign: TextAlign.left,
                              ),
                              pokemons.isNotEmpty
                                  ? Text(pokemons.length.toString(),
                                      style: kAttributes.copyWith(
                                          fontWeight: FontWeight.bold))
                                  : Flexible(
                                      child: SizedBox(
                                        child: Text(
                                            "You still haven't caught a pokémon",
                                            style: kAttributes.copyWith(
                                                fontWeight: FontWeight.bold)),
                                      ),
                                    ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
