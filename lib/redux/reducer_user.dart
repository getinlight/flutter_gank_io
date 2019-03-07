import 'package:flutter_gank_io/common/model/model_user.dart';
import 'package:redux/redux.dart';

final combineUserReducer = combineReducers<User>([
  TypedReducer<User, UpdateUserAction>(_updateLoaded)
]);


User _updateLoaded(User user, action) {
  user = action.userInfo;
  return user;
}

class UpdateUserAction {
  final User userInfo;
  UpdateUserAction(this.userInfo);
}
