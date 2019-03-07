import 'package:flutter_gank_io/common/manager/manager_app.dart';
import 'package:flutter_gank_io/common/event/event_http_error.dart';

class HttpCode {
  ///网络错误
  static const NETWORK_ERROR = -1;

  ///网络超时
  static const NETWORK_TIMEOUT = -2;

  ///网络返回数据格式化异常
  static const NETWORK_JSON_EXCEPTION = -3;

  static const SUCCESS = 200;
  
  static errorHandleFunction(code, message, noTip) {
    if (noTip) {
      return message;
    }
    AppManager.eventBus.fire(new HttpErrorEvent(code, message));
    return message;
  }

}