import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/register/cubit/states.dart';

import '../../../models/login_model.dart';
import '../../../newtork/end_pointes.dart';
import '../../../newtork/remotly.dart';

class ShopRegisterCubit extends Cubit<ShopRegisterStates> {
  ShopRegisterCubit() : super(InitialShopRegisterState());
  static ShopRegisterCubit get(context) => BlocProvider.of(context);
  ShopLoginModel loginModel;
  bool ispassword = true;
  IconData isVisibile = Icons.visibility_off_outlined;

  void changeIconVisibility() {
    ispassword = !ispassword;
    isVisibile =
        ispassword ? Icons.visibility_off_outlined : Icons.visibility_outlined;
    emit(ChangeRegisterIconVisibilityState());
  }

  void userResgister({
    @required String name,
    @required String email,
    @required String password,
    @required String phone,
  }) {
    emit(ShopRegisterLoadingState());
    DioHelper.postData(url: REGISTER, data: {
      'name': name,
      'email': email,
      'password': password,
      'phone': phone,
    }).then((value) {
      loginModel = ShopLoginModel.fromjson(value.data);
      emit(ShopRegisterSuccedState(loginModel));
    }).catchError((error) {
      emit(ShopRegisterFailedState(error.toString()));
    });
  }
}
