// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors

import 'package:first/layout/news%20app/cubit/cubit.dart';
import 'package:first/layout/news%20app/cubit/states.dart';
import 'package:first/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScienceScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        //7atena ely list 7nshofha in var
        var list = NewsCubit.get(context).science;

        return articleBuilder(
          list,
          context // bta3 text color
          ,
        );
      },
    );
  }
}
