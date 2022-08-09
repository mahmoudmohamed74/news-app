// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:first/layout/shop%20app/cubit/cubit.dart';
import 'package:first/layout/shop%20app/cubit/states.dart';
import 'package:first/moduels/news_app/search/search_screen.dart';
import 'package:first/shared/components/components.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = ShopCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: Text("salla"),
              actions: [
                IconButton(
                  onPressed: () {
                    navigateTo(
                      context,
                      SearchScreen(),
                    );
                  },
                  icon: Icon(
                    Icons.search,
                  ),
                )
              ],
            ),
            body: cubit.bottomScreens[cubit.currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              onTap: (index) {
                cubit.cahngeBottom(index);
              },
              currentIndex: cubit.currentIndex,
              items: [
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.home,
                    ),
                    label: "Home"),
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.apps,
                    ),
                    label: "Categories"),
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.favorite,
                    ),
                    label: "Favorite"),
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.settings_suggest_rounded,
                    ),
                    label: "Settings"),
              ],
            ),
          );
        });
  }
}
