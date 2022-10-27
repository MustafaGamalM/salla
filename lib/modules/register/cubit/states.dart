import '../../../models/login_model.dart';

abstract class ShopRegisterStates {}

class InitialShopRegisterState extends ShopRegisterStates {}

class ChangeRegisterIconVisibilityState extends ShopRegisterStates {}

class ShopRegisterLoadingState extends ShopRegisterStates {}

class ShopRegisterSuccedState extends ShopRegisterStates {
  final ShopLoginModel loginModel;

  ShopRegisterSuccedState(this.loginModel);
}

class ShopRegisterFailedState extends ShopRegisterStates {
  final String error;

  ShopRegisterFailedState(this.error);
}
