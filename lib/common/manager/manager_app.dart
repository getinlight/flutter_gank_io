import 'package:flutter/material.dart';
import 'package:event_bus/event_bus.dart';

import 'package:flutter_gank_io/common/manager/manager_cache.dart';
import 'package:flutter_gank_io/common/event/event_show_history_date.dart';
import 'package:flutter_gank_io/common/manager/manager_favorite.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_gank_io/redux/app_state.dart';
import 'package:redux/redux.dart';
import 'package:flutter_gank_io/common/manager/manager_user.dart';
import 'package:flutter_gank_io/common/model/model_user.dart';
import 'package:flutter_gank_io/redux/reducer_user.dart';

class AppManager {

  static EventBus eventBus = EventBus();

  static initApp(BuildContext context) async {
    try {

      Store<AppState> store = StoreProvider.of(context);
      User localUser = await UserManager.getUserFromLocalStorage();
      if (localUser != null) {
        store.dispatch(UpdateUserAction(localUser));
      }

      await CacheManager.init();
      await FavoriteManager.init();
      return true;
    } catch(e) {
      return false;
    }
  }

  static notifyShowHistoryDateEvent() {
    AppManager.eventBus.fire(ShowHistoryDateEvent());
  }

}