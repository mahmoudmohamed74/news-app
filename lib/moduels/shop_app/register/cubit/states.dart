import 'package:first/models/shop_app/login_model.dart';

abstract class ShopRegisterStates {}

class ShopRegisterInitalState extends ShopRegisterStates {}

class ShopRegisterLoadingState extends ShopRegisterStates {}

class ShopRegisterSuccessState extends ShopRegisterStates {
  final ShopLoginModel loginModel;

  ShopRegisterSuccessState(this.loginModel);
}

class ShopRegisterErorrState extends ShopRegisterStates {
  final String error;

  ShopRegisterErorrState(this.error);
}

class ShopRgisterChangePasswordVisibilityState extends ShopRegisterStates {}
