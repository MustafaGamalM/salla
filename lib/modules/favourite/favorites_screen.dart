import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/cubit/cubit.dart';
import 'package:shop_app/cubit/states.dart';

import '../../shared/widget.dart';

class FavoritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopHomeCubit, ShopHomeStates>(
        builder: (context, state) {
          return ConditionalBuilder(
            condition: state is! ShopGetFavLoading,
            builder: (context) => ListView.separated(
                itemBuilder: (context, index) => buildListProduct(
                    ShopHomeCubit.get(context)
                        .favModeldata
                        .data
                        .data[index]
                        .product,
                    context),
                separatorBuilder: (context, index) => Divider(),
                itemCount:
                    ShopHomeCubit.get(context).favModeldata.data.data.length),
            fallback: (context) => Center(
              child: CircularProgressIndicator(),
            ),
          );
        },
        listener: (context, state) {});
  }
}
