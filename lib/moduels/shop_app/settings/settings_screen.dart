// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, prefer_const_literals_to_create_immutables, must_be_immutable

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:first/layout/shop%20app/cubit/cubit.dart';
import 'package:first/layout/shop%20app/cubit/states.dart';
import 'package:first/shared/components/components.dart';
import 'package:first/shared/components/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var nameConroller = TextEditingController();
  var emailConroller = TextEditingController();
  var phoneConroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var model = ShopCubit.get(context).userModel;
        nameConroller.text = model!.data!.name!;
        emailConroller.text = model.data!.email!;
        phoneConroller.text = model.data!.phone!;
        return ConditionalBuilder(
          condition: ShopCubit.get(context).userModel != null,
          builder: (context) => Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    if (state is ShopLoadingUpdateUserDataState)
                      LinearProgressIndicator(),
                    SizedBox(
                      height: 20,
                    ),
                    defaultFormField(
                      controller: nameConroller,
                      type: TextInputType.name,
                      validate: (value) {
                        if (value!.isEmpty) {
                          return "name  must  not  be  empty";
                        }
                        return null;
                      },
                      lable: "Name",
                      prefix: Icons.person,
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    defaultFormField(
                      controller: emailConroller,
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
                      height: 30,
                    ),
                    defaultFormField(
                      controller: phoneConroller,
                      type: TextInputType.phone,
                      validate: (value) {
                        if (value!.isEmpty) {
                          return "phone  must  not  be  empty";
                        }
                        return null;
                      },
                      lable: "Phone",
                      prefix: Icons.phone_android_outlined,
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    defaultButton(
                      function: () {
                        if (formKey.currentState!.validate()) {
                          ShopCubit.get(context).updateUserData(
                            name: nameConroller.text,
                            email: emailConroller.text,
                            phone: phoneConroller.text,
                          );
                        }
                      },
                      text: "Update",
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    defaultButton(
                      function: () {
                        signOut(context);
                      },
                      text: "Logout",
                    )
                  ],
                ),
              ),
            ),
          ),
          fallback: (context) => Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
