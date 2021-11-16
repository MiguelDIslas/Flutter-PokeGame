import 'package:flutter/material.dart';
import '../constants.dart';

class RowDetail extends StatelessWidget {
  final String data;
  final String info;
  const RowDetail({Key? key, required this.data, required this.info})
      : super(key: key);

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
            child: Text(data, style: kTextDescriptionStyle),
          ),
          Flexible(
            child: SizedBox(
              child: Text(info, style: kTextDescriptionInfoStyle),
            ),
          ),
        ],
      ),
    );
  }
}
