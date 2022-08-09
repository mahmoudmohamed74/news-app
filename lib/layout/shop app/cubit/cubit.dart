// ignore_for_file: avoid_print

import 'package:first/layout/shop%20app/cubit/states.dart';
import 'package:first/models/shop_app/home_model.dart';
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
  void getHomeData() {
    emit(ShopLoadingHomeDataState());
    DioHelper.getData(
      url: HOME,
      token: token,
    ).then((value) {
      emit(ShopSuccessHomeDataState());
      homeModel = HomeModel.fromJson(value.data);
      printFullText(homeModel!.data!.banners[0].image.toString());
      print(homeModel!.data);
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorHomeDataState(error));
    });
  }
}
