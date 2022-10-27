import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/cubit/states.dart';
import 'package:shop_app/modules/categories/categories_screen.dart';
import 'package:shop_app/modules/favourite/favorites_screen.dart';
import 'package:shop_app/modules/products/products_screen.dart';
import 'package:shop_app/modules/settings/settings_screen.dart';
import 'package:shop_app/newtork/remotly.dart';
import 'package:shop_app/shared/constants.dart';

import '../models/categories_model.dart';
import '../models/change_favorites_model.dart';
import '../models/home_model.dart';
import '../../newtork/end_pointes.dart';
import '../models/item_favorites_model.dart';
import '../models/login_model.dart';

class ShopHomeCubit extends Cubit<ShopHomeStates> {
  ShopHomeCubit() : super(ShopHomeIntialState());
  static ShopHomeCubit get(context) => BlocProvider.of(context);
  HomeModel modelD;
  int currentIndex = 0;
  List<Widget> screens = [
    ProductsScreen(),
    CategoriesScreen(),
    FavoritesScreen(),
    SettingsScreen()
  ];
  void changeBottom(int index) {
    currentIndex = index;
    emit(ShopHomeBottomNavState());
  }

  Map<int, bool> Favorites = {};
  void getHomeData() {
    emit(ShopHomeLoadingState());
    DioHelper.getData(url: HOME, token: token).then((value) {
      modelD = HomeModel.fromJson(value.data);
      modelD.data.products.forEach((e) {
        Favorites.addAll({e.id: e.inFavorites});
      });
      emit(ShopHomeSuccessState());
    }).catchError((e) {
      emit(ShopHomeFailedState());
    });
  }

  FavoritesModel favModel;
  changeFavorites(int id) {
    Favorites[id] = !Favorites[id];
    emit(ShopChangeuccessState());
    DioHelper.postData(url: FAVORITES, data: {'product_id': id}, token: token)
        .then((value) {
      favModel = FavoritesModel.fromJson(value.data);
      if (!favModel.status) {
        Favorites[id] = !Favorites[id];
      } else {
        getFavData();
      }
      emit(ShopCnageDataIconSucessState(favModel));
    }).catchError((e) {
      Favorites[id] = !Favorites[id];
      emit(ShopCnageDataIconFailedState());
    });
  }

  CategoriesModel modelCat;
  void getCategoryData() {
    DioHelper.getData(url: CATEGORIES, token: token).then((value) {
      modelCat = CategoriesModel.fromJson(value.data);
      emit(ShopCATEGORIESSuccessState());
    }).catchError((e) {
      emit(ShopCATEGORIESFailedState());
    });
  }

  FavoritesModeldata favModeldata;
  void getFavData() {
    emit(ShopGetFavLoading());
    DioHelper.getData(url: FAVORITES, token: token).then((value) {
      favModeldata = FavoritesModeldata.fromJson(value.data);
      emit(ShopGetFavDataSuccedState());
    }).catchError((e) {
      emit(ShopGetFavFailedState());
    });
  }

  ShopLoginModel userModel;
  void getUserData() {
    emit(ShopGetUserLoading());
    DioHelper.getData(url: PROFILE, token: token).then((value) {
      print('========');
      print('doneeeeeeeeeeeeeeeee');
      print('========');
      userModel = ShopLoginModel.fromjson(value.data);
      emit(ShopGetUserDataSuccedState());
    }).catchError((e) {
      print('========');
      print('errorrrrrrr');
      print('========');
      emit(ShopGetUserFailedState());
    });
  }

  ShopLoginModel updateuser;
  void updateUserData({
    @required name,
    @required email,
    @required phone,
  }) {
    emit(ShopUpdateUserLoading());
    DioHelper.putData(
        url: UPDATE_PROFILE,
        token: token,
        data: {'email': email, 'phone': phone, 'name': name}).then((value) {
      userModel = ShopLoginModel.fromjson(value.data);

      emit(ShopUpdateUserDataSuccedState());
    }).catchError((e) {
      emit(ShopUpdateUserFailedState());
    });
  }
}
