import 'package:flutter/material.dart';

const kTitleDecoration =
    TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white);

const kPokemonTitleDecoration =
    TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white);

const kTypeBoxDecoration = BoxDecoration(
  borderRadius: BorderRadius.all(Radius.circular(10)),
  color: Colors.black26,
);

const kGridDelegate = SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 2, childAspectRatio: 1.4);

const kProgressWidget = Center(child: CircularProgressIndicator());

final Map<String, Color> pokemonColor = {
  'Grass': const Color(0xFF7AC74C),
  'Fire': const Color(0xFFEE8130),
  'Water': const Color(0xFF6390F0),
  'Electric': const Color(0xFFF7D02C),
  'Rock': const Color(0xFFB6A136),
  'Normal': const Color(0xFFA8A77A),
  'Ice': const Color(0xFF96D9D6),
  'Ground': const Color(0xFFE2BF65),
  'Psychic': const Color(0xFFF95587),
  'Fighting': const Color(0xFFC22E28),
  'Flying': const Color(0xFFA98FF3),
  'Bug': const Color(0xFFA6B91A),
  'Ghost': const Color(0xFF735797),
  'Dragon': const Color(0xFF6F35FC),
  'Dark': const Color(0xFF705746),
  'Steel': const Color(0xFFB7B7CE),
  'Fairy': const Color(0xFFD685AD),
  'Poison': const Color(0xFFA33EA1)
};

const kDetailContainer = BoxDecoration(
  color: Colors.white,
  borderRadius: BorderRadius.only(
    topLeft: Radius.circular(30),
    topRight: Radius.circular(30),
  ),
);

const kTextDescriptionStyle = TextStyle(color: Colors.blueGrey, fontSize: 18);

const kTextDescriptionInfoStyle =
    TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold);

const kBackgroundColor = Color(0xFF2f3354);

const kNavColor = Color(0xFF364164);

const kAttributes = TextStyle(fontSize: 19, color: Colors.white);
