import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/register/cubit/cubit.dart';
import 'package:shop_app/modules/register/cubit/states.dart';

import '../../layout/shop_home_layout.dart';
import '../../newtork/cacheHelper.dart';
import '../../shared/constants.dart';
import '../../shared/widget.dart';

class RegisterScreen extends StatelessWidget {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopRegisterCubit(),
      child: BlocConsumer<ShopRegisterCubit, ShopRegisterStates>(
          listener: (context, state) {
        if (state is ShopRegisterSuccedState) {
          if (state.loginModel.status) {
            CasheHelper.saveData(
                    key: 'TOKEN', value: state.loginModel.data.token)
                .then((value) {
              if (value) {
                token = state.loginModel.data.token;
                navigateAndFinish(context, ShopHomeLayout());
              }
            });
          } else {
            showToast(
                message: state.loginModel.message, state: ToastStates.ERROR);
          }
        }
      }, builder: (context, state) {
        var Registercubit = ShopRegisterCubit.get(context);
        return Scaffold(
          appBar: AppBar(),
          body: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(30),
                child: Form(
                  key: formKey,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        defaultTextFormField(
                          prefix: Icons.person,
                          validate: (String value) {
                            if (value.isEmpty) {
                              return 'Name empty';
                            }
                            return null;
                          },
                          textEditingController: nameController,
                          onSaved: (value) {
                            nameController = value;
                          },
                          label: 'name',
                          keyboardType: TextInputType.name,
                          onSubmitted: (val) {
                            if (formKey.currentState.validate()) {
                              Registercubit.userResgister(
                                  name: nameController.text,
                                  phone: phoneController.text,
                                  email: emailController.text,
                                  password: passwordController.text);
                            }
                          },
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        SizedBox(height: 15),
                        defaultTextFormField(
                          prefix: Icons.email_outlined,
                          validate: (String value) {
                            if (value.isEmpty) {
                              return 'Email empty';
                            }
                            return null;
                          },
                          textEditingController: emailController,
                          onSaved: (value) {
                            emailController = value;
                          },
                          label: 'Email',
                          keyboardType: TextInputType.emailAddress,
                          onSubmitted: (val) {
                            if (formKey.currentState.validate()) {
                              Registercubit.userResgister(
                                  name: nameController.text,
                                  phone: phoneController.text,
                                  email: emailController.text,
                                  password: passwordController.text);
                            }
                          },
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        defaultTextFormField(
                            prefix: Icons.lock,
                            suffixIcon: Registercubit.isVisibile,
                            suffixpressed: () {
                              Registercubit.changeIconVisibility();
                            },
                            isObscure: Registercubit.ispassword,
                            validate: (String value) {
                              if (value.isEmpty || value.length < 6) {
                                return 'Password empty';
                              }
                              return null;
                            },
                            textEditingController: passwordController,
                            onSaved: (value) {
                              passwordController = value;
                            },
                            label: 'Password',
                            keyboardType: TextInputType.emailAddress,
                            onSubmitted: (val) {
                              if (formKey.currentState.validate()) {
                                Registercubit.userResgister(
                                    name: nameController.text,
                                    phone: phoneController.text,
                                    email: emailController.text,
                                    password: passwordController.text);
                              }
                            }),
                        SizedBox(
                          height: 15,
                        ),
                        defaultTextFormField(
                            prefix: Icons.phone,
                            validate: (String value) {
                              if (value.isEmpty || value.length < 6) {
                                return 'Phone empty';
                              }
                              return null;
                            },
                            textEditingController: phoneController,
                            onSaved: (value) {
                              phoneController = value;
                            },
                            label: 'phone',
                            keyboardType: TextInputType.phone,
                            onSubmitted: (val) {
                              if (formKey.currentState.validate()) {
                                Registercubit.userResgister(
                                    name: nameController.text,
                                    phone: phoneController.text,
                                    email: emailController.text,
                                    password: passwordController.text);
                              }
                            }),
                        SizedBox(
                          height: 15,
                        ),
                        ConditionalBuilder(
                          condition: state is! ShopRegisterLoadingState,
                          builder: (context) {
                            return defaultButton(
                                redius: 10,
                                onpressed: () {
                                  if (formKey.currentState.validate()) {
                                    Registercubit.userResgister(
                                        name: nameController.text,
                                        phone: phoneController.text,
                                        email: emailController.text,
                                        password: passwordController.text);
                                  }
                                },
                                text: 'Register');
                          },
                          fallback: (context) {
                            return Center(child: CircularProgressIndicator());
                          },
                        ),
                      ]),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
