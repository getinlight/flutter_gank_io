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

  ///获取分类数据 [category:分类, page: 页数, count:每页的个数]
  static getCategoryData(String category, int page, {count = 20}) async {
    String url = API_DATA + category + "/$count/$page";
    HttpResponse response = await HttpManager.fetch(url);
    return response.data;
  }

  ///获取所有的历史干货日期.
  static getHistoryDateData() async {
    HttpResponse response = await HttpManager.fetch(API_HISTORY);
    return response.data['results'];
  }

  ///搜索[简易搜索，后面拆分页]
  static searchData(String search) async {
    HttpResponse response = await HttpManager.fetch(
        API_SEARCH + "/$search/category/all/count/50/page/1");
    return response.data['results'];
  }

  ///获取所有的历史干货.
  static getHistoryContentData(int page, {count = 20}) async {
    HttpResponse response =
    await HttpManager.fetch(API_HISTORY_CONTENT + '/$count/$page');
    return response.data['results'];
  }

}