import 'package:first/models/shop_app/login_model.dart';

abstract class ShopLoginStates {}

class ShopLoginInitalState extends ShopLoginStates {}

class ShopLoginLoadingState extends ShopLoginStates {}

class ShopLoginSuccessState extends ShopLoginStates {
  final ShopLoginModel loginModel;

  ShopLoginSuccessState(this.loginModel);
}

class ShopLoginErorrState extends ShopLoginStates {
  final String error;

  ShopLoginErorrState(this.error);
}

class ShopChangePasswordVisibilityState extends ShopLoginStates {}
