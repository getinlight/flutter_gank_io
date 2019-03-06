import 'package:flutter/material.dart';

import 'package:flutter_gank_io/common/constant/locale/BaseString.dart';
import 'package:flutter_gank_io/common/constant/locale/EnString.dart';
import 'package:flutter_gank_io/common/constant/locale/ZhString.dart';

class GankLocalizations {
  final Locale locale;

  GankLocalizations(this.locale);

  static Map<String, BaseString> _localizedValues = {
    'en': EnString(),
    'zh': ZhString(),
  };

  BaseString get currentLocalized {
    return _localizedValues[locale.languageCode];
  }

  static GankLocalizations of(BuildContext context) {
    return Localizations.of(context, GankLocalizations);
  }


}
