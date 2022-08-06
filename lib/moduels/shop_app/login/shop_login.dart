// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, prefer_const_literals_to_create_immutables, must_be_immutable

import 'package:first/shared/components/components.dart';
import 'package:flutter/material.dart';

class ShopLoginScreen extends StatelessWidget {
  var emailController = TextEditingController();

  var passwordController = TextEditingController();
  bool isPasswordShow = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "LOGIN",
              style: Theme.of(context).textTheme.headline3,
            ),
            Text(
              "login now to browse our hot offers",
              style: Theme.of(context).textTheme.bodyText1?.copyWith(
                    color: Colors.grey,
                  ),
            ),
            SizedBox(
              height: 30,
            ),
            defaultFormField(
                controller: emailController,
                type: TextInputType.emailAddress,
                validate: (value) {
                  if (value!.isEmpty) {
                    return "$value must not be empty";
                  }
                  return null;
                },
                lable: "Email Address",
                prefix: Icons.email),
            SizedBox(
              height: 20,
            ),
            defaultFormField(
              controller: passwordController,
              type: TextInputType.emailAddress,
              validate: (value) {
                if (value!.isEmpty) {
                  return "$value is too short";
                }
                return null;
              },
              lable: "Password",
              prefix: Icons.lock,
              suffix: isPasswordShow ? Icons.visibility : Icons.visibility_off,
            ),
            SizedBox(
              height: 30,
            ),
            defaultButton(
              function: () {},
              text: "Login",
              isUpperCase: true,
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Text(
                  "Don't have an account? ",
                ),
                defaultTextButton(function: () {}, text: "Register")
              ],
            ),
          ],
        ),
      ),
    );
  }
}
