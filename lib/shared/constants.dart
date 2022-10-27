import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_app/shared/widget.dart';

import '../modules/shop_login/login_screen.dart';
import '../newtork/cacheHelper.dart';

String token = '';

void signOut(context) async {
  CasheHelper.removeData(key: 'TOKEN').then((value) {
    if (value) {
      navigateAndFinish(context, LogInScreen());
    }
  });
}
