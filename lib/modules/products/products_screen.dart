import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/cubit/cubit.dart';
import 'package:shop_app/cubit/states.dart';
import 'package:shop_app/models/categories_model.dart';

import '../../models/home_model.dart';
import '../../shared/widget.dart';

class ProductsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopHomeCubit, ShopHomeStates>(
        listener: (context, state) {
      if (state is ShopCnageDataIconSucessState) {
        if (state.model.status == false) {
          showToast(message: state.model.message, state: ToastStates.ERROR);
        }
      }
    }, builder: (context, state) {
      return ConditionalBuilder(
        condition: ShopHomeCubit.get(context).modelD != null &&
            ShopHomeCubit.get(context).modelCat != null,
        builder: (context) => productsBuilder(ShopHomeCubit.get(context).modelD,
            ShopHomeCubit.get(context).modelCat, context),
        fallback: (context) => Center(
          child: CircularProgressIndicator(),
        ),
      );
    });
  }

  Widget productsBuilder(HomeModel model, CategoriesModel catModel, context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        children: [
          CarouselSlider(
              items: model.data.banners.map((e) {
                return Image(
                  image: NetworkImage(e.image),
                  fit: BoxFit.cover,
                  width: double.infinity,
                );
              }).toList(),
              options: CarouselOptions(
                autoPlay: true,
                height: 250,
                initialPage: 0,
                reverse: false,
                autoPlayInterval: Duration(seconds: 3),
                autoPlayCurve: Curves.fastOutSlowIn,
                autoPlayAnimationDuration: Duration(seconds: 1),
                scrollDirection: Axis.horizontal,
                enlargeCenterPage: true,
              )),
          SizedBox(
            height: 10,
          ),
          Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Categories",
                    style: TextStyle(fontSize: 17),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                      height: 100,
                      child: ListView.separated(
                          physics: BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) =>
                              builtCategories(catModel.data.data[index]),
                          separatorBuilder: (context, index) => SizedBox(
                                width: 5,
                              ),
                          itemCount: catModel.data.data.length)),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    "Products",
                    style: TextStyle(fontSize: 17),
                  ),
                ],
              )),
          SizedBox(
            height: 10,
          ),
          Container(
            color: Colors.grey[300],
            child: GridView.count(
              shrinkWrap: true,
              mainAxisSpacing: 1,
              crossAxisSpacing: 1,
              childAspectRatio: .5,
              physics: BouncingScrollPhysics(),
              crossAxisCount: 2,
              children: List.generate(
                  model.data.products.length,
                  (index) =>
                      buildGridProduct(model.data.products[index], context)),
            ),
          )
        ],
      ),
    );
  }

  Widget builtCategories(CatDataModel model) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Image(
          image: NetworkImage(model.image),
          width: 90,
          height: 90,
        ),
        Container(
          width: 100,
          color: Colors.black54,
          child: Text(model.name,
              maxLines: 1,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
              )),
        ),
      ],
    );
  }

  Widget buildGridProduct(Products model, context) {
    return Container(
      color: Colors.white,
      child: Column(
        //  mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Stack(alignment: Alignment.bottomLeft, children: [
              Image(
                image: NetworkImage(model.image),
                height: 250,
                width: double.infinity,
              ),
              if (model.discount != 0)
                Container(
                  padding: EdgeInsets.all(5),
                  color: Colors.red,
                  child: Text(
                    'Discount',
                    style: TextStyle(color: Colors.white),
                  ),
                )
            ]),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                model.name,
                style: TextStyle(
                  overflow: TextOverflow.ellipsis,
                ),
                maxLines: 2,
              ),
              SizedBox(
                width: 5,
              ),
              Row(children: [
                Text(model.price.round().toString()),
                SizedBox(
                  width: 10,
                ),
                if (model.discount != 0)
                  Text(model.oldPrice.round().toString(),
                      style: TextStyle(
                          fontSize: 13,
                          decoration: TextDecoration.lineThrough,
                          color: Colors.grey)),
                Spacer(),
                IconButton(
                    onPressed: () {
                      ShopHomeCubit.get(context).changeFavorites(model.id);
                      print(model.id);
                    },
                    icon: CircleAvatar(
                      foregroundColor: Colors.white,
                      backgroundColor:
                          ShopHomeCubit.get(context).Favorites[model.id]
                              ? Colors.orange
                              : Colors.grey,
                      child: Icon(Icons.favorite_border_outlined),
                    )),
              ])
            ]),
          )
        ],
      ),
    );
  }
}
