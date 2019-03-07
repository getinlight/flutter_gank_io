import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';

import 'package:objectdb/objectdb.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_gank_io/common/constant/strings.dart';
import 'package:flutter_gank_io/common/model/model_gank_item.dart';
import 'package:flutter_gank_io/common/utils/common_utils.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_gank_io/common/localization/GankLocalizations.dart';
import 'package:flutter_gank_io/common/manager/manager_app.dart';
import 'package:flutter_gank_io/common/event/event_refresh_db.dart';

class FavoriteManager {

  static ObjectDB db;

  static init() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, "${AppStrings.STRING_DB_FAVORITE}");
    db = ObjectDB(path);
    await db.open();
  }

  static insert(GankItem gankItem) async {
    await db.insert(gankItem.toJsonMap());
  }

  static find(Map<dynamic, dynamic> query) async {
    return await db.find(query);
  }

  static remove(GankItem gankItem) async {
    await db.remove({'itemId': gankItem.itemId});
  }

  static _clearFavorites() async {
    await db.remove({});
  }

  static clearFavorites(context) async {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(CommonUtils.getLocale(context).tips),
        content: Text(CommonUtils.getLocale(context).confirmClearFavorites),
        actions: <Widget>[
          FlatButton(
            child: Text(CommonUtils.getLocale(context).cancel),
            onPressed: (){
              Navigator.pop(context);
            },
          ),
          FlatButton(
            child: Text(CommonUtils.getLocale(context).confirm),
            onPressed: () async {
              await FavoriteManager._clearFavorites();
              Fluttertoast.showToast(
                msg: GankLocalizations.of(context)
                    .currentLocalized
                    .clearFavoritesSuccess,
                backgroundColor: Colors.black,
                gravity: ToastGravity.CENTER,
                textColor: Colors.white
              );
              AppManager.eventBus.fire(RefreshDBEvent());
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  static closeDB() async => await db.close();

}