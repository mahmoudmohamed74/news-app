// ignore_for_file: avoid_print

import 'package:first/models/shop_app/login_model.dart';
import 'package:first/moduels/shop_app/register/cubit/states.dart';
import 'package:first/shared/network/end_points.dart';
import 'package:first/shared/network/remote/dio_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopRegisterCuibt extends Cubit<ShopRegisterStates> {
  ShopRegisterCuibt() : super(ShopRegisterInitalState());
  static ShopRegisterCuibt get(context) => BlocProvider.of(context);
  ShopLoginModel? shopLoginModel;

  void userRegister({
    required String email,
    required String password,
    required String name,
    required String phone,
  }) {
    emit(ShopRegisterLoadingState());
    DioHelper.postData(
      url: REGISTER,
      data: {
        "email": email,
        "password": password,
        "name": name,
        "phone": phone,
      },
    ).then((value) {
      print(value.data);
      shopLoginModel = ShopLoginModel.fromJson(value.data!);

      emit(
        ShopRegisterSuccessState(shopLoginModel!),
      );
    }).catchError((error) {
      print("starrrrrrrrrrrrrrrrrrrrrrrrrrrrrr");
      print(error.toString());
      emit(
        ShopRegisterErorrState(error.toString()),
      );
    });
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;
  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix = isPassword ? Icons.visibility_outlined : Icons.visibility_off;

    emit(
      ShopRgisterChangePasswordVisibilityState(),
    );
  }
}
