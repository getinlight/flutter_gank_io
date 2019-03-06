import 'package:flutter/material.dart';

import 'package:flutter_gank_io/common/constant/locale/BaseString.dart';
import 'package:flutter_gank_io/common/constant/AppColors.dart';
import 'package:flutter_gank_io/common/localization/GankLocalizations.dart';

class CommonUtils {

  static BaseString getLocale(BuildContext context) {
    return GankLocalizations.of(context).currentLocalized;
  }

  static List<Color> getThemeListColor() {
    return [
      AppColors.PRIMARY_DEFAULT_COLOR, //默认色
      AppColors.PRIMARY_HTH_COLOR, //海棠红
      AppColors.PRIMARY_YWL_COLOR, //鸢尾蓝
      AppColors.PRIMARY_KQL_COLOR, //孔雀绿
      AppColors.PRIMARY_NMH_COLOR, //柠檬黄
      AppColors.PRIMARY_TLZ_COLOR, //藤萝紫
      AppColors.PRIMARY_MYH_COLOR, //暮云灰
      AppColors.PRIMARY_XKQ_COLOR, //虾壳青
      AppColors.PRIMARY_MDF_COLOR, //牡丹粉
      AppColors.PRIMARY_XPZ_COLOR, //筍皮棕
    ];
  }


}