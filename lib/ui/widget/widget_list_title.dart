import 'package:flutter/material.dart';
import 'package:flutter_gank_io/common/constant/AppColors.dart';

class GankItemTitle extends StatefulWidget {
  final String category;

  GankItemTitle(this.category);

  @override
  _GankItemTitleState createState() => _GankItemTitleState();
}

class _GankItemTitleState extends State<GankItemTitle> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.COLOR_TITLE_BG,
        border: Border(
          bottom: BorderSide(width: 0.0, color: Theme.of(context).dividerColor),
        ),
      ),
      child: Row(
        children: <Widget>[
          Container(
            margin: EdgeInsets.symmetric(vertical: 22),
            width: 4,
            height: 20,
            color: Theme.of(context).primaryColor,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 12.0),
            child: Text(
              widget.category,
              style: Theme.of(context).textTheme.title,
            ),
          )
        ],
      ),
    );
  }
}
