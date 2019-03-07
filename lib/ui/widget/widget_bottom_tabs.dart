import 'package:flutter/material.dart';

import 'package:flutter_gank_io/ui/widget/widget_icon_font.dart';
import 'package:flutter_gank_io/common/utils/common_utils.dart';

class BottomTabsWidget extends StatefulWidget {

  final PageController pageController;
  final ValueChanged<int> onTap;

  BottomTabsWidget(this.pageController, this.onTap);

  @override
  _BottomTabsWidgetState createState() => _BottomTabsWidgetState();
}

class _BottomTabsWidgetState extends State<BottomTabsWidget> {

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    var _bottomItems = <BottomNavigationBarItem>[
      BottomNavigationBarItem(
        icon: Icon(IconFont(0xe67f)),
        title: Text(CommonUtils.getLocale(context).gankNew),
      ),
      BottomNavigationBarItem(
        icon: Icon(IconFont(0xe603)),
        title: Text(CommonUtils.getLocale(context).gankCategory),
      ),
      BottomNavigationBarItem(
        icon: Icon(IconFont(0xe637)),
        title: Text(CommonUtils.getLocale(context).girl),
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.favorite),
        title: Text(CommonUtils.getLocale(context).gankFavorite),
      ),
    ];
    return BottomNavigationBar(
      items: _bottomItems,
      type: BottomNavigationBarType.fixed,
      iconSize: 32,
      currentIndex: currentIndex,
      onTap: (int index){
        if (widget.onTap != null) {
          currentIndex = index;
          widget.pageController.jumpToPage(index);
          widget.onTap(index);
        }
      },
    );
  }
}
