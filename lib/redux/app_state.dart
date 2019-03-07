import 'package:flutter/material.dart';
import 'package:flutter_gank_io/common/model/model_user.dart';

import 'package:flutter_gank_io/redux/reducer_user.dart';
import 'package:flutter_gank_io/redux/reducer_theme_data.dart';
import 'package:flutter_gank_io/redux/reducer_locale.dart';

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