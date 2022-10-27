import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/shop_login/cubit/states.dart';
import 'package:shop_app/newtork/remotly.dart';

import '../../../models/login_model.dart';
import '../../../newtork/end_pointes.dart';

class ShopLoginCubit extends Cubit<ShopLoginStates> {
  ShopLoginCubit() : super(InitialShopLoginState());
  static ShopLoginCubit get(context) => BlocProvider.of(context);
  ShopLoginModel loginModel;
  bool ispassword = true;
  IconData isVisibile = Icons.visibility_off_outlined;

  void changeIconVisibility() {
    ispassword = !ispassword;
    isVisibile =
        ispassword ? Icons.visibility_off_outlined : Icons.visibility_outlined;
    emit(ChangeIconVisibilityState());
  }

  void userLogin({@required String email, @required String password}) {
    emit(ShopLoginLoadingState());
    DioHelper.postData(url: LOGIN, data: {
      'email': email,
      'password': password,
    }).then((value) {
      loginModel = ShopLoginModel.fromjson(value.data);
      emit(ShopLoginSuccedState(loginModel));
    }).catchError((error) {
      emit(ShopLoginFailedState(error.toString()));
    });
  }
}
