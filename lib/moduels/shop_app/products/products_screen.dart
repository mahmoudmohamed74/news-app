// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:first/layout/shop%20app/cubit/cubit.dart';
import 'package:first/layout/shop%20app/cubit/states.dart';
import 'package:first/models/shop_app/home_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: ShopCubit.get(context).homeModel != null,
          builder: (context) =>
              productsBuilder(ShopCubit.get(context).homeModel!),
          fallback: (context) => Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }

  Widget productsBuilder(HomeModel model) => Column(
        children: [
          CarouselSlider(
            items: model.data!.banners
                .map((e) => Image(
                      image: NetworkImage(
                        "${e.image}",
                      ),
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ))
                .toList(),
            options: CarouselOptions(
              height: 250,
              initialPage: 0,
              viewportFraction: 1,
              enableInfiniteScroll: true,
              reverse: false,
              autoPlay: true,
              autoPlayInterval: Duration(seconds: 3), //مده العرض
              autoPlayAnimationDuration: Duration(seconds: 1), //سرعه التحريك
              autoPlayCurve: Curves.fastOutSlowIn,
              scrollDirection: Axis.horizontal,
            ),
          )
        ],
      );
}
