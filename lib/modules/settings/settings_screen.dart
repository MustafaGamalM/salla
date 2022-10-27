import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/cubit/cubit.dart';
import 'package:shop_app/cubit/states.dart';
import 'package:shop_app/shared/widget.dart';

import '../../shared/constants.dart';

class SettingsScreen extends StatelessWidget {
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopHomeCubit, ShopHomeStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = ShopHomeCubit.get(context).userModel;

          if (cubit != null) {
            nameController.text = cubit.data.name;
            emailController.text = cubit.data.email;
            phoneController.text = cubit.data.phone;
            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    if (state is ShopUpdateUserLoading)
                      LinearProgressIndicator(),
                    SizedBox(
                      height: 20,
                    ),
                    defaultTextFormField(
                        prefix: Icons.person,
                        validate: (value) {
                          if (value.isEmpty) {
                            return 'your name is empty';
                          }
                          return null;
                        },
                        textEditingController: nameController,
                        label: 'name',
                        keyboardType: TextInputType.name),
                    SizedBox(
                      height: 20,
                    ),
                    defaultTextFormField(
                        prefix: Icons.email,
                        validate: (value) {
                          if (value.isEmpty) {
                            return 'your email is empty';
                          }
                          return null;
                        },
                        textEditingController: emailController,
                        label: 'email',
                        keyboardType: TextInputType.emailAddress),
                    SizedBox(
                      height: 20,
                    ),
                    defaultTextFormField(
                        prefix: Icons.phone,
                        validate: (String value) {
                          if (value.isEmpty) {
                            return 'your phone is empty';
                          }
                          return null;
                        },
                        textEditingController: phoneController,
                        label: 'phone',
                        keyboardType: TextInputType.phone),
                    SizedBox(
                      height: 20,
                    ),
                    defaultButton(
                        onpressed: () {
                          ShopHomeCubit.get(context).updateUserData(
                              name: nameController.text,
                              email: emailController.text,
                              phone: phoneController.text);
                        },
                        text: 'Update'),
                    SizedBox(
                      height: 20,
                    ),
                    defaultButton(
                        onpressed: () {
                          signOut(context);
                        },
                        text: 'Logout'),
                  ],
                ),
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}
