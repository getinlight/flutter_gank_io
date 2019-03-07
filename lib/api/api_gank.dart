import 'package:flutter_gank_io/common/net/http_response.dart';
import 'package:flutter_gank_io/common/net/http_manager.dart';

class GankApi {
  /// gank api urls.
  static const String API_GANK_HOST = 'http://gank.io';
  static const String API_SPECIAL_DAY = "$API_GANK_HOST/api/day/";
  static const String API_DATA = "$API_GANK_HOST/api/data/";
  static const String API_SEARCH = "$API_GANK_HOST/api/search/query";
  static const String API_TODAY = "$API_GANK_HOST/api/today";
  static const String API_HISTORY = "$API_GANK_HOST/api/day/history";
  static const String API_HISTORY_CONTENT =
      "$API_GANK_HOST/api/history/content";
  static const String API_SUBMIT = "$API_GANK_HOST/api/add2gank";

  static getTodayData() async {
    HttpResponse response = await HttpManager.fetch(API_TODAY);
    return response.data;
  }

  ///获取指定日期的数据 [date:指定日期]
  static getSpecialDayData(String date) async {
    HttpResponse response =
    await HttpManager.fetch(API_SPECIAL_DAY + date.replaceAll("-", "/"));
    return response.data;
  }

}