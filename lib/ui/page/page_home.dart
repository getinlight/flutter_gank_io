import 'package:flutter/material.dart';

import 'package:flutter_gank_io/ui/page/page_new.dart';
import 'package:flutter_gank_io/ui/page/page_category.dart';
import 'package:flutter_gank_io/ui/widget/widget_bottom_tabs.dart';
import 'package:flutter_gank_io/common/manager/manager_app.dart';
import 'package:flutter_gank_io/common/event/event_refresh_new_page.dart';
import 'package:flutter_gank_io/ui/widget/widget_icon_font.dart';
import 'package:flutter_gank_io/ui/page/page_welfare.dart';
import 'package:flutter_gank_io/ui/widget/widget_history_date.dart';
import 'package:flutter_gank_io/api/api_gank.dart';
import 'package:flutter_gank_io/common/event/event_show_history_date.dart';
import 'package:flutter_gank_io/ui/page/page_favorite.dart';
import 'package:flutter_gank_io/common/utils/navigator_utils.dart';
import 'package:flutter_gank_io/common/event/event_change_welfare_column.dart';
import 'package:flutter_gank_io/common/manager/manager_favorite.dart';
import 'package:flutter_gank_io/ui/widget/widget_gank_drawer.dart';

class HomePage extends StatefulWidget {

  static const String ROUTER_NAME = 'home';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int _currentPageIndex = 0;
  String _currentDate;
  PageController _pageController;
  List _historyData;

  @override
  void initState() {
    super.initState();
    _pageController = new PageController(initialPage: 0);
    _registerEventListener();
    _getHistoryData();
  }

  void _registerEventListener() {
    AppManager.eventBus.on<RefreshNewPageEvent>().listen((event){
      if (mounted) {
        setState(() {
          _currentDate = event.date;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: GankDrawer(),
      appBar: _buildAppBar(),
      body: _buildBody(),
      bottomNavigationBar: BottomTabsWidget(_pageController, _pageChange),
    );
  }

  void _pageChange(int index) {
    if (index != 0) {
      AppManager.eventBus.fire(ShowHistoryDateEvent.hide());
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
      actions: <Widget>[_buildActions()],
    );
  }

  ///右侧按钮
  IconButton _buildActions() {
    return IconButton(
      icon: Icon(_getActionsIcon(), size: 22, color: Colors.white),
      onPressed: () async {
        if (_currentPageIndex == 0) {
          AppManager.notifyShowHistoryDateEvent();
        } else if (_currentPageIndex == 1) {
          NavigatorUtils.goSearch(context);
        } else if (_currentPageIndex == 2) {
          AppManager.eventBus.fire(ChangeWelfareColumnEvent());
        } else {
//          FavoriteManager.
        }
      },
    );
  }

  ///获取标题栏右侧图标.
  IconData _getActionsIcon() {
    if (_currentPageIndex == 0) {
      return IconFont(0xe8a6);
    } else if (_currentPageIndex == 1) {
      return IconFont(0xe783);
    } else if (_currentPageIndex == 2) {
      return IconFont(0xe63a);
    } else {
      return IconFont(0xe619);
    }
  }

  ///获取干货历史发布日期
  void _getHistoryData() async {
    var historyData = await GankApi.getHistoryDateData();
    setState(() {
      _historyData = historyData;
      _currentDate = '今日最新干货';
    });
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
            WelfarePage(),
            FavoritePage()
          ],
        ),
        HistoryDateWidget(_historyData),
      ],
    );
  }

}
