import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shared/widget.dart';

import 'cubit/cubit.dart';
import 'cubit/states.dart';

class SearchScreen extends StatelessWidget {
  TextEditingController searchController = TextEditingController();
  var searchkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(),
              body: Form(
                key: searchkey,
                child: Padding(
                  padding:const EdgeInsets.all(20),
                  child: Column(children: [
                    defaultTextFormField(
                        onSubmitted: (String text) {
                          SearchCubit.get(context).searchItem(text);
                        },
                        validate: (String value) {
                          if (value.isEmpty) {
                            return 'your search emmpty';
                          }
                          return null;
                        },
                        prefix: Icons.search,
                        textEditingController: searchController,
                        label: 'Search',
                        keyboardType: TextInputType.name),
                    SizedBox(
                      height: 10,
                    ),
                    if (state is LoadingSearch) LinearProgressIndicator(),
                    SizedBox(
                      height: 10,
                    ),
                    if (state is SuccessSearch)
                      Expanded(
                          child: ListView.separated(
                            physics: BouncingScrollPhysics(),
                              itemBuilder: (context, index) => buildListProduct(
                                  SearchCubit.get(context)
                                      .searchedModel
                                      .data
                                      .data[index],
                                  context,
                                  isOldPrice: false),
                              separatorBuilder: (context, index) => Divider(),
                              itemCount: SearchCubit.get(context)
                                  .searchedModel
                                  .data
                                  .data
                                  .length)),
                  ]),
                ),
              ),
            );
          }),
    );
  }
}
