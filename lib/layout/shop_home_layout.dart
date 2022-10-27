import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/cubit/cubit.dart';
import 'package:shop_app/cubit/states.dart';
import 'package:shop_app/shared/widget.dart';

import '../modules/search/search_screen.dart';

class ShopHomeLayout extends StatefulWidget {
  @override
  State<ShopHomeLayout> createState() => _ShopHomeLayoutState();
}

class _ShopHomeLayoutState extends State<ShopHomeLayout> {
  @override
  void initState() {
    super.initState();

    ShopHomeCubit.get(context).getUserData();
    ShopHomeCubit.get(context).getFavData();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopHomeCubit, ShopHomeStates>(
        builder: (context, state) {
          var cubit = ShopHomeCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: Text('Salla'),
              actions: [
                IconButton(
                    onPressed: () {
                      navigateTo(context, SearchScreen());
                    },
                    icon: Icon(Icons.search))
              ],
            ),
            body: cubit.screens[cubit.currentIndex],
            bottomNavigationBar: BottomNavigationBar(
                onTap: (index) {
                  cubit.changeBottom(index);
                },
                currentIndex: cubit.currentIndex,
                items: [
                  BottomNavigationBarItem(
                      icon: Icon(Icons.home), label: 'Home'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.apps), label: 'Categories'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.favorite), label: 'Favorites'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.settings), label: 'Settings'),
                ]),
          );
        },
        listener: (context, state) {});
  }
}
