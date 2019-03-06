import 'package:flutter/material.dart';
import 'package:event_bus/event_bus.dart';

import 'package:flutter_gank_io/common/manager/cache_manager.dart';

class AppManager {

  static EventBus eventBus = EventBus();

  static initApp(BuildContext context) async {
    try {
      await CacheManager.init();
    } catch(e) {
      return false;
    }
  }

}