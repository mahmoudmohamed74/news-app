// ignore_for_file: avoid_print, avoid_function_literals_in_foreach_calls

import 'package:first/layout/shop%20app/cubit/states.dart';
import 'package:first/models/shop_app/categories_model.dart';
import 'package:first/models/shop_app/change_favorites_model.dart';
import 'package:first/models/shop_app/favoraites_model.dart';
import 'package:first/models/shop_app/home_model.dart';
import 'package:first/models/shop_app/login_model.dart';
import 'package:first/moduels/shop_app/categories/categories_screen.dart';
import 'package:first/moduels/shop_app/favorites/favorites_screen.dart';
import 'package:first/moduels/shop_app/products/products_screen.dart';
import 'package:first/moduels/shop_app/settings/settings_screen.dart';
import 'package:first/shared/components/constants.dart';
import 'package:first/shared/network/end_points.dart';
import 'package:first/shared/network/remote/dio_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitialState());
  static ShopCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;
  List<Widget> bottomScreens = [
    ProductsScreen(),
    CategoriesScreen(),
    FavoritesScreen(),
    SettingsScreen(),
  ];
  void cahngeBottom(int index) {
    currentIndex = index;
    emit(ShopChangeBottomNavState());
  }

  HomeModel? homeModel;
  Map<int, bool> fave = {};
  void getHomeData() {
    emit(ShopLoadingHomeDataState());
    DioHelper.getData(
      url: HOME,
      token: token,
    ).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      // printFullText(homeModel!.data!.banners[0].image.toString());
      // print(homeModel!.data);
      homeModel!.data!.products.forEach((element) {
        fave.addAll({element.id!: element.inFavorites!});
        emit(ShopSuccessHomeDataState());
      });
      print(fave.toString());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorHomeDataState(error));
    });
  }

  CategoriesModel? categoriesModel;
  void getCategories() {
    DioHelper.getData(
      url: GET_CATEGORIES,
      token: token,
    ).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);
      emit(ShopSuccessCategoriesDataState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorCategoriesDataState(error.toString()));
    });
  }

  ChangeFavoritesModel? changeFavoritesModel;
  void changeFavorties(int? productId) {
    fave[productId!] = !fave[productId]!; // تغير
    emit(ShopChangeFavoritesState()); //يسمع ف لحظتها مينتظرش يدخل ال success

    DioHelper.postData(
      url: FAVORITES,
      data: {
        'product_id': productId,
      },
      token: token,
    ).then((value) {
      changeFavoritesModel = ChangeFavoritesModel.fromJson(value.data);
      if (!changeFavoritesModel!.status!) {
        fave[productId] = !fave[productId]!; //ترجعه
        // lw 7asl succsess f el servar , error f el data(message = false)
      } else {
        getFavorites();
      }
      print(value.data);
      emit(ShopSuccessChangeFavoritesState(changeFavoritesModel!));
    }).catchError((error) {
      fave[productId] = !fave[productId]!; // ترجعه

      print(error.toString());
      emit(ShopErrorChangeFavoritesState(error.toString()));
    });
  }

  FavoritesModel? favoritesModel;
  void getFavorites() {
    emit(ShopLoadingGetFavoritesDataState());
    DioHelper.getData(
      url: FAVORITES,
      token: token,
    ).then((value) {
      favoritesModel = FavoritesModel.fromJson(value.data);
      // printFullText(value.data.toString());
      emit(ShopSuccessGetFavoritesDataState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorGetFavoritesDataState(error.toString()));
    });
  }

  ShopLoginModel? userModel;
  void getUserData() {
    emit(ShopLoadingGetUserDataState());
    DioHelper.getData(
      url: PROFILE,
      token: token,
    ).then((value) {
      userModel = ShopLoginModel.fromJson(value.data);
      // printFullText(userModel!.data!.name.toString());
      emit(ShopSuccessGetUserDataState(userModel!));
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorGetUserDataState(error.toString()));
    });
  }

  void updateUserData({
    required String? name,
    required String? email,
    required String? phone,
  }) {
    emit(ShopLoadingUpdateUserDataState());
    DioHelper.putData(url: UPDATE_PROFILE, token: token, data: {
      "name": name,
      "email": email,
      "phone": phone,
    }).then((value) {
      userModel = ShopLoginModel.fromJson(value.data);
      // printFullText(userModel!.data!.name.toString());
      emit(ShopSuccessUpdateUserDataState(userModel!));
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorUpdateUserDataState(error.toString()));
    });
  }
}
