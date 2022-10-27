import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_home_layout.dart';
import 'package:shop_app/modules/theme.dart';
import 'package:shop_app/newtork/cacheHelper.dart';
import 'package:shop_app/newtork/remotly.dart';
import 'package:shop_app/shared/constants.dart';
import 'cubit/blocobserver.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';
import 'modules/onboardingscreen.dart';
import 'modules/shop_login/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CasheHelper.inite();
  DioHelper.init();
  bool onBoarding = CasheHelper.getData(key: 'OnBoarding') ?? false;
  token = CasheHelper.getData(key: 'TOKEN');
  Widget screen;
  (onBoarding)
      ? (token != null)
          ? screen = ShopHomeLayout()
          : screen = LogInScreen()
      : screen = onboaringScreen();

  BlocOverrides.runZoned(
    () => runApp(MyApp(screen)),
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  final Widget screen;

  MyApp(this.screen);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (context) => ShopHomeCubit()
                ..getHomeData()
                ..getCategoryData()),
        ],
        child: BlocConsumer<ShopHomeCubit, ShopHomeStates>(
            listener: (context, state) {},
            builder: (context, state) => MaterialApp(
                  debugShowCheckedModeBanner: false,
                  title: 'Flutter Demo',
                  theme: lightTheme,
                  home: screen,
                )));
  }
}
