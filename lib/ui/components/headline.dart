import 'package:flutter/material.dart';

class HeadLine extends StatelessWidget {
  final String text;

  HeadLine({@required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text.toUpperCase(),
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.headline1,
    );
  }
}
