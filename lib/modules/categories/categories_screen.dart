import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/cubit/cubit.dart';
import 'package:shop_app/cubit/states.dart';

import '../../models/categories_model.dart';

class CategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopHomeCubit, ShopHomeStates>(
        builder: (context, sate) => ListView.separated(
            itemBuilder: (context, index) => ItemCategory(
                ShopHomeCubit.get(context).modelCat.data.data[index]),
            separatorBuilder: (context, index) => Divider(),
            itemCount: ShopHomeCubit.get(context).modelCat.data.data.length),
        listener: (context, sate) {});
  }

  Widget ItemCategory(CatDataModel model) => Row(
        children: [
          Image(
            image: NetworkImage(model.image),
            height: 100,
          ),
          SizedBox(
            width: 10,
          ),
          Text(model.name),
          Spacer(),
          IconButton(onPressed: () {}, icon: Icon(Icons.arrow_forward_ios))
        ],
      );
}
