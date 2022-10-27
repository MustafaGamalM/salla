import '../models/change_favorites_model.dart';

abstract class ShopHomeStates {}

class ShopHomeIntialState extends ShopHomeStates {}

class ShopHomeBottomNavState extends ShopHomeStates {}

class ShopHomeLoadingState extends ShopHomeStates {}

class ShopHomeSuccessState extends ShopHomeStates {}

class ShopHomeFailedState extends ShopHomeStates {}

class ShopCATEGORIESLoadingState extends ShopHomeStates {}

class ShopCATEGORIESSuccessState extends ShopHomeStates {}

class ShopCATEGORIESFailedState extends ShopHomeStates {}

class ShopChangeuccessState extends ShopHomeStates {}

class ShopCnageDataIconSucessState extends ShopHomeStates {
  final FavoritesModel model;

  ShopCnageDataIconSucessState(this.model);
}

class ShopCnageDataIconFailedState extends ShopHomeStates {}

class ShopGetFavFailedState extends ShopHomeStates {}

class ShopGetFavDataSuccedState extends ShopHomeStates {}

class ShopGetFavLoading extends ShopHomeStates {}

class ShopGetUserFailedState extends ShopHomeStates {}

class ShopGetUserDataSuccedState extends ShopHomeStates {}

class ShopGetUserLoading extends ShopHomeStates {}

class ShopUpdateUserFailedState extends ShopHomeStates {}

class ShopUpdateUserDataSuccedState extends ShopHomeStates {}

class ShopUpdateUserLoading extends ShopHomeStates {}
