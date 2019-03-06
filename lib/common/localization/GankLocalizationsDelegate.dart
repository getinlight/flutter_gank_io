import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/foundation.dart';

import 'package:flutter_gank_io/common/localization/GankLocalizations.dart';

class GankLocalizationsDelegate extends LocalizationsDelegate<GankLocalizations> {

  GankLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en', 'zh'].contains(locale.languageCode);
  }

  @override
  Future<GankLocalizations> load(Locale locale) {
    return SynchronousFuture<GankLocalizations>(GankLocalizations(locale));
  }

  @override
  bool shouldReload(LocalizationsDelegate<GankLocalizations> old) {
    return false;
  }

  ///全局静态的代理
  static GankLocalizationsDelegate delegate = GankLocalizationsDelegate();

}