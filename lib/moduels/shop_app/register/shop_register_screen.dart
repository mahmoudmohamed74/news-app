// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, must_be_immutable, avoid_print

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:first/layout/shop%20app/cubit/cubit.dart';
import 'package:first/layout/shop%20app/shop_layout.dart';
import 'package:first/moduels/shop_app/register/cubit/cubit.dart';
import 'package:first/moduels/shop_app/register/cubit/states.dart';
import 'package:first/shared/components/components.dart';
import 'package:first/shared/components/constants.dart';
import 'package:first/shared/network/local/cache_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopRegisterScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>(); // create valdaition
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var cubit = ShopCubit.get(context);
    return BlocProvider(
      create: (context) => ShopRegisterCuibt(),
      child: BlocConsumer<ShopRegisterCuibt, ShopRegisterStates>(
        listener: (context, state) {
          if (state is ShopRegisterSuccessState) {
            if (state.loginModel.status!) {
              showToast(
                // text: "Login done successfully",
                text: state.loginModel.message.toString(),
                state: ToastStates.SUCCESS,
              );
              print(state.loginModel.message);
              print(state.loginModel.data!.token);

              CacheHelper.saveData(
                key: "token",
                value: state.loginModel.data!.token!,
              ).then(
                (value) {
                  token = state.loginModel.data!.token;
                  ShopCubit.get(
                      context) // to update user’s data at every update
                    ..getHomeData()
                    ..getCategories()
                    ..getFavorites()
                    ..getUserData();
                  cubit.currentIndex = 0;

                  navigateAndFinish(
                    context,
                    ShopLayout(),
                  );
                },
              );
            } else {
              print(state.loginModel.message!);

              showToast(
                // text: "Incorrect email format",
                text: state.loginModel.message.toString(),
                state: ToastStates.ERROR,
              );
            }
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                child: SingleChildScrollView(
                  //ايرور لوحه المفاتيح
                  child: Form //validation
                      (
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Register",
                          style: Theme.of(context).textTheme.headline3,
                        ),
                        Text(
                          "Register  now  to  browse  our  hot  offers",
                          style:
                              Theme.of(context).textTheme.bodyText1?.copyWith(
                                    color: Colors.grey,
                                  ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        defaultFormField(
                          controller: nameController,
                          type: TextInputType.name,
                          validate: (value) {
                            if (value!.isEmpty) {
                              return "name  address  must  not  be  empty";
                            }
                            return null;
                          },
                          lable: "User  Name",
                          prefix: Icons.person,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        defaultFormField(
                          controller: emailController,
                          type: TextInputType.emailAddress,
                          validate: (value) {
                            if (value!.isEmpty) {
                              return "email  address  must  not  be  empty";
                            }
                            return null;
                          },
                          lable: "Email  Address",
                          prefix: Icons.email,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        defaultFormField(
                          controller: phoneController,
                          type: TextInputType.phone,
                          validate: (value) {
                            if (value!.isEmpty) {
                              return "Phone  number  must  not  be  empty";
                            }
                            return null;
                          },
                          lable: "Phone  Number",
                          prefix: Icons.phone_android_outlined,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        defaultFormField(
                          controller: passwordController,
                          type: TextInputType.visiblePassword,
                          validate: (value) {
                            if (value!.isEmpty) {
                              return "password  is  too  short";
                            }
                            return null;
                          },
                          lable: "Password",
                          prefix: Icons.lock,
                          suffix: ShopRegisterCuibt.get(context).suffix,
                          isPassword: ShopRegisterCuibt.get(context).isPassword,
                          suffixPressed: () {
                            ShopRegisterCuibt.get(context)
                                .changePasswordVisibility();
                          },
                          onFieldSubmitted: (value) {},
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        ConditionalBuilder(
                          condition: state is! ShopRegisterLoadingState,
                          builder: (context) => defaultButton(
                            function: () {
                              if (formKey.currentState!.validate()) {
                                ShopRegisterCuibt.get(context).userRegister(
                                  name: nameController.text,
                                  phone: phoneController.text,
                                  email: emailController.text,
                                  password: passwordController.text,
                                );
                              }
                            },
                            text: "Register",
                            isUpperCase: true,
                          ),
                          fallback: (context) => Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
