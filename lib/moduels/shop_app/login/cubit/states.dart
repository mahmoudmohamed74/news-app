abstract class ShopLoginStates {}

class ShopLoginInitalState extends ShopLoginStates {}

class ShopLoginLoadingState extends ShopLoginStates {}

class ShopLoginSuccessState extends ShopLoginStates {}

class ShopLoginErorrState extends ShopLoginStates {
  final String error;

  ShopLoginErorrState(this.error);
}

class ShopChangePasswordVisibilityState extends ShopLoginStates {}
