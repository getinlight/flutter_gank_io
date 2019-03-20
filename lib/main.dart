import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_gank_io/redux/app_state.dart';
import 'package:flutter_gank_io/common/constant/AppColors.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gank_io/common/localization/GankLocalizationsDelegate.dart';
import 'package:flutter_gank_io/ui/page/page_splash.dart';
import 'package:flutter_gank_io/common/localization/GankLocalizationsWrapper.dart';
import 'package:flutter_gank_io/ui/page/page_home.dart';
import 'package:flutter_gank_io/ui/page/page_login.dart';
import 'package:flutter_gank_io/ui/page/page_search.dart';
import 'package:flutter_gank_io/ui/page/page_about.dart';

void main() => runApp(MyApp());


class MyApp extends StatefulWidget {

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  final store = new Store<AppState>(
    appReducer,
    initialState: new AppState(
      userInfo: null,
      themeData: new ThemeData(
        primaryColor: AppColors.PRIMARY_DEFAULT_COLOR,
        platform: TargetPlatform.android,
      ),
      locale: Locale('zh', 'CH'),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return StoreProvider(
      store: store,
      child: StoreBuilder<AppState>(
        builder: (context, store) {
          return MaterialApp(
            theme: store.state.themeData,
            localizationsDelegates: [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GankLocalizationsDelegate.delegate
            ],
            locale: store.state.locale,
            supportedLocales: [store.state.locale],
            routes: {
              SplashPage.ROUTER_NAME: (context)=>
                  GankLocalizationWrapper(child: SplashPage()),
              HomePage.ROUTER_NAME: (context)=> HomePage(),
              LoginPage.ROUTER_NAME: (context)=>LoginPage(),
              SearchPage.ROUTER_NAME: (context)=>SearchPage(),
              AboutPage.ROUTER_NAME: (context)=>AboutPage(),
            },
          );
        },
      ),
    );
  }
}







