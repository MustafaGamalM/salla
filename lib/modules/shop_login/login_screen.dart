import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/register/register.dart';

import 'package:shop_app/newtork/cacheHelper.dart';
import 'package:shop_app/shared/constants.dart';
import 'package:shop_app/shared/widget.dart';
import 'package:conditional_builder/conditional_builder.dart';

import '../../layout/shop_home_layout.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class LogInScreen extends StatelessWidget {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit, ShopLoginStates>(
          listener: (context, state) {
        if (state is ShopLoginSuccedState) {
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
        var logincubit = ShopLoginCubit.get(context);
        return Scaffold(
          body: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(30),
                child: Form(
                  key: formKey,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Login',
                          style: Theme.of(context)
                              .textTheme
                              .headline4
                              .copyWith(color: Colors.black),
                        ),
                        SizedBox(height: 15),
                        Text(
                          'Login now to browse our hot offers',
                          style: Theme.of(context)
                              .textTheme
                              .headline6
                              .copyWith(color: Colors.grey),
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
                              logincubit.userLogin(
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
                            suffixIcon: logincubit.isVisibile,
                            suffixpressed: () {
                              logincubit.changeIconVisibility();
                            },
                            isObscure: logincubit.ispassword,
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
                                logincubit.userLogin(
                                    email: emailController.text,
                                    password: passwordController.text);
                              }
                            }),
                        SizedBox(
                          height: 15,
                        ),
                        ConditionalBuilder(
                          condition: state is! ShopLoginLoadingState,
                          builder: (context) {
                            return defaultButton(
                                redius: 10,
                                onpressed: () {
                                  if (formKey.currentState.validate()) {
                                    logincubit.userLogin(
                                        email: emailController.text,
                                        password: passwordController.text);
                                  }
                                },
                                text: 'Login');
                          },
                          fallback: (context) {
                            return Center(child: CircularProgressIndicator());
                          },
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            Text('Don\'t have an account?'),
                            SizedBox(width: 10),
                            defaultTextButton(
                                color: Colors.blue,
                                onpressed: () {
                                  navigateTo(context, RegisterScreen());
                                },
                                text: 'Register')
                          ],
                        )
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
