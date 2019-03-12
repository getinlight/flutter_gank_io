import 'dart:async';
import 'dart:convert';

import 'package:flutter_gank_io/common/model/model_user.dart';
import 'package:flutter_gank_io/common/utils/SPUtils.dart';
import 'package:flutter_gank_io/config/app_config.dart';
import 'package:redux/redux.dart';

class UserManager {

  static Future<User> getUserFromLocalStorage() async {
    var userInfoJson = await SPUtils.get(AppConfig.USER_INFO);
    if (userInfoJson != null) {
      var userMap = json.decode(userInfoJson);
      User user = User.fromJson(userMap);
      return user;
    }
    return null;
  }

  static saveUserToLocalStorage(User user) async {
    await SPUtils.save(AppConfig.USER_INFO, user.toJson());
  }

  ///更新用户信息
  static updateUserDao(params, Store store) async {}

  ///点赞
  static starFlutterGank(Store store) async {}

}