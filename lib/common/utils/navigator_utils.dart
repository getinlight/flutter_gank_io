import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gank_io/ui/page/page_about.dart';
import 'package:flutter_gank_io/ui/page/page_home.dart';
import 'package:flutter_gank_io/ui/page/page_login.dart';
import 'package:flutter_gank_io/ui/page/page_search.dart';
import 'package:flutter_gank_io/ui/page/page_settings.dart';

///
///导航栏
///Created by lijinshan
///Date: 2019-01-05
///
class NavigatorUtils {
  ///替换
  static pushReplacementNamed(BuildContext context, String routeName) {
    Navigator.pushReplacementNamed(context, routeName);
  }

  ///切换无参数页面
  static pushNamed(BuildContext context, String routeName) {
    Navigator.pushNamed(context, routeName);
  }

  ///主页
  static goHome(BuildContext context) {
    Navigator.pushNamed(context, HomePage.ROUTER_NAME);
  }

  ///搜索页
  static goSearch(BuildContext context) {
    Navigator.pushNamed(context, SearchPage.ROUTER_NAME);
  }

  ///设置页
  static goSetting(BuildContext context) {
    Navigator.pushNamed(context, SettingPage.ROUTER_NAME);
  }

  ///登录页
  static goLogin(BuildContext context) {
    Navigator.pushNamed(context, LoginPage.ROUTER_NAME);
  }

  ///关于页
  static goAbout(BuildContext context) {
    Navigator.pushNamed(context, AboutPage.ROUTER_NAME);
  }
}
