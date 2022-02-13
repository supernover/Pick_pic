import 'package:flutter/material.dart';

/// custom circle button
class MyCircleButton extends StatelessWidget {
  const MyCircleButton(
      {Key? key, required this.text, required this.press, required this.width})
      : super(key: key);
  final String text;
  final Function press;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: width,
        height: width,
        child: TextButton(
          onPressed: () => press(),
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Theme.of(context).accentColor),
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(width / 2))))),
          child: Text(text,
              style: Theme.of(context).textTheme.headline5!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor,
                  )),
        ));
  }
}
