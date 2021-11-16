import 'package:flutter/material.dart';
import '../constants.dart';

class RowEvolution extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final evolution;
  final String evolutionTitle;
  final String evolutionData;

  const RowEvolution({
    Key? key,
    this.evolution,
    required this.evolutionTitle,
    required this.evolutionData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            width: size.width * 0.3,
            child: Text(evolutionTitle, style: kTextDescriptionStyle),
          ),
          SizedBox(
            height: 20,
            width: size.width * 0.55,
            child: evolution != null
                ? ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: evolution.length,
                    itemBuilder: (context, index) {
                      var evol = evolution;
                      return Text(
                        evol[index]['name'] +
                            (evolution.length - 1 == index ? ' ' : ', '),
                        style: kTextDescriptionInfoStyle,
                      );
                    })
                : Text(evolutionData, style: kTextDescriptionInfoStyle),
          ),
        ],
      ),
    );
  }
}
