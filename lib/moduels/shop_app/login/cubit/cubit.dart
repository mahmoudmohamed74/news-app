// ignore_for_file: avoid_print

import 'package:first/moduels/shop_app/login/cubit/states.dart';
import 'package:first/shared/network/end_points.dart';
import 'package:first/shared/network/remote/dio_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopLoginCuibt extends Cubit<ShopLoginStates> {
  ShopLoginCuibt() : super(ShopLoginInitalState());
  static ShopLoginCuibt get(context) => BlocProvider.of(context);

  void userLogin({
    required String email,
    required String password,
  }) {
    emit(ShopLoginLoadingState());
    DioHelper.postData(
      url: LOGIN,
      data: {
        "email": email,
        "password": password,
      },
    ).then((value) {
      print(value.data);
      emit(
        ShopLoginSuccessState(),
      );
    }).catchError((error) {
      emit(
        ShopLoginErorrState(error.toString()),
      );
    });
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;
  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix = isPassword ? Icons.visibility_outlined : Icons.visibility_off;

    emit(
      ShopChangePasswordVisibilityState(),
    );
  }
}