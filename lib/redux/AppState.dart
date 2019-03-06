import 'package:flutter/material.dart';
import 'package:flutter_gank_io/common/model/User.dart';

import 'package:flutter_gank_io/redux/UserReducer.dart';
import 'package:flutter_gank_io/redux/ThemeDataReducer.dart';
import 'package:flutter_gank_io/redux/LocaleReducer.dart';

class AppState {

  User userInfo;
  ThemeData themeData;
  Locale locale;

  AppState({this.userInfo, this.themeData, this.locale});

}


AppState appReducer(AppState state, action) {
  return AppState(
    userInfo: combineUserReducer(state.userInfo, action),
    themeData: combineThemeDataReducer(state.themeData, action),
    locale: combineLocaleReducer(state.locale, action),
  );
}