import 'package:flutter/material.dart';

import 'package:flutter_gank_io/ui/page/new_page.dart';
import 'package:flutter_gank_io/ui/page/category_page.dart';
import 'package:flutter_gank_io/ui/widget/bottom_tabs_widget.dart';

class HomePage extends StatefulWidget {

  static const String ROUTER_NAME = 'home';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int _currentPageIndex = 0;
  String _currentDate;
  PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = new PageController(initialPage: 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
      bottomNavigationBar: BottomTabsWidget(_pageController, _pageChange),
    );
  }

  void _pageChange(int index) {
    if (index != 0) {

    }

    setState(() {
      if (_currentPageIndex != index) {
        _currentPageIndex = index;
      }
    });
  }

  Widget _buildAppBar() {
    return AppBar(
      elevation: 0,
      centerTitle: true,
      title: Offstage(
        offstage: _currentPageIndex != 0,
        child: Text(_currentDate ?? ''),
      ),
    );
  }

  Widget _buildBody() {
    return Stack(
      children: <Widget>[
        PageView(
          physics: NeverScrollableScrollPhysics(),
          controller: _pageController,
          children: <Widget>[
            NewPage(),
            CategoryPage(),
          ],
        ),
      ],
    );
  }

}
