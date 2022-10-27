import '../../../models/login_model.dart';

abstract class ShopLoginStates {}

class InitialShopLoginState extends ShopLoginStates {}

class ChangeIconVisibilityState extends ShopLoginStates {}

class ShopLoginLoadingState extends ShopLoginStates {}

class ShopLoginSuccedState extends ShopLoginStates {
  final ShopLoginModel loginModel;

  ShopLoginSuccedState(this.loginModel);
}

class ShopLoginFailedState extends ShopLoginStates {
  final String error;

  ShopLoginFailedState(this.error);
}
