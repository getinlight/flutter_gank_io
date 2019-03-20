import 'package:flutter/material.dart';

class ExpandButton extends StatelessWidget {

  final String text;
  final Color color;
  final Color textColor;
  final VoidCallback onPress;
  final double fontSize;
  final int maxLines;

  final MainAxisAlignment mainAxisAlignment;

  ExpandButton({
    Key key,
    this.text,
    this.color,
    this.textColor,
    this.onPress,
    this.fontSize = 20.0,
    this.mainAxisAlignment = MainAxisAlignment.center,
    this.maxLines = 1}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      padding: EdgeInsets.only(left: 20.0, top: 10.0, right: 20.0, bottom: 10.0),
      textColor: textColor,
      color: color,
      child: Flex(
        mainAxisAlignment: mainAxisAlignment,
        direction: Axis.horizontal,
        children: <Widget>[
          Text(
            text,
            style: TextStyle(fontSize: fontSize),
            maxLines: maxLines,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
      onPressed: () {
        this.onPress?.call();
      },
    );
  }
}
