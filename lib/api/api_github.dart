import 'dart:convert';
import 'dart:async';

import 'package:flutter_gank_io/common/model/model_user.dart';
import 'package:flutter_gank_io/config/app_config.dart';
import 'package:flutter_gank_io/common/net/http_manager.dart';
import 'package:flutter_gank_io/common/manager/manager_user.dart';

class GithubApi {
  static const List<String> GANK_OAUTH2_SCOPE = [
    'user',
    'repo',
    'gist',
    'notifications'
  ];

  static String browserOAuth2Url =
      'https://github.com/login/oauth/authorize?client_id=${AppConfig.CLIENT_ID}&scope=${GANK_OAUTH2_SCOPE.join(',')}&state=${DateTime.now().millisecondsSinceEpoch}';

  static Future<User> login({
    String username,
    String password,
    String code
  }) async {
    String token;
    if (code != null) {
      token = await GithubApi.getTokenFromBrowserCode(code);
    } else {
      token = await GithubApi.getTokenFromPassword(username, password);
    }
    return await getUserInfo(token);
  }

  static Future<User> getUserInfo(String accessToken) async {
    try {
      var response = await HttpManager.fetch(
          "https://api.github.com/user?access_token=$accessToken"
      );
      var userInfo = response.data;
      userInfo['token'] = accessToken;
      User user = User.fromJson(userInfo);
      await UserManager.saveUserToLocalStorage(user);
      return user;
    } catch(e) {
      return null;
    }
  }

  static Future<String> getTokenFromPassword(String userName, String password) async {
    String authorizationUrl = 'https://api.github.com/authorizations';
    String basic = "Basic ${base64Encode(utf8.encode("$userName:$password"))}";
    var response = await HttpManager.fetch(authorizationUrl,
      params: {
        "client_id": AppConfig.CLIENT_ID,
        "client_secret": AppConfig.CLIENT_SECRET,
        "note": AppConfig.NOTE,
        "noteUrl": AppConfig.NOTE_URL,
        "scopes": GANK_OAUTH2_SCOPE
      },
      header: {
        "Authorization": basic, "cache-control": "no-cache"
      },
      method: 'post');
    String token = response.data['token'];
    return token;
  }

  static Future<String> getTokenFromBrowserCode(String code) async {
    var response = await HttpManager.fetch(
      'https://github.com/login/oauth/access_token',
      params: {
        'client_id': AppConfig.CLIENT_ID,
        'client_secret': AppConfig.CLIENT_SECRET,
        'code': code
      }
    );
    return _getToken(response.data);
  }

  static String _getToken(String tokenStr) {
    List<String> tokenSplit = tokenStr.split('&');
    for (String str in tokenSplit) {
      if (str.startsWith('access_token')) {
        return str.split('=')[1];
      }
    }
    return null;
  }

}