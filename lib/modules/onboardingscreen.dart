import 'package:flutter/material.dart';
import 'package:shop_app/newtork/cacheHelper.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../shared/widget.dart';
import 'shop_login/login_screen.dart';

class OnboardingModel {
  final String title;
  final String body;
  final String image;

  OnboardingModel(
      {@required this.title, @required this.body, @required this.image});
}

class onboaringScreen extends StatefulWidget {
  @override
  State<onboaringScreen> createState() => onboaringScreenState();
}

class onboaringScreenState extends State<onboaringScreen> {
  PageController pagecontroller = PageController();
  bool isLast = false;
  List<OnboardingModel> onboardingList = [
    OnboardingModel(
        title: 'Safe & easy payment',
        body: 'Easy check out safe payment trusted by out customers  ',
        image: 'assets/images/sc1.png'),
    OnboardingModel(
        title: 'Choose product',
        body: 'we have many products Your product in our E-commerce ',
        image: 'assets/images/sc2.png'),
    OnboardingModel(
        title: 'Fast Delivery',
        body:
            'reailbe and fast delivery.we deliver your product the fastest we possible',
        image: 'assets/images/sc3.png'),
  ];
  void submit() {
    CasheHelper.saveData(key: 'OnBoarding', value: true).then((value) {
      if (value) {
        navigateAndFinish(context, LogInScreen());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [defaultTextButton(onpressed: submit, text: 'Skip')],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(children: [
          Expanded(
            child: PageView.builder(
              physics: BouncingScrollPhysics(),
              onPageChanged: (val) {
                if (val == onboardingList.length - 1) {
                  setState(() {
                    isLast = true;
                  });
                } else {
                  setState(() {
                    isLast = false;
                  });
                }
              },
              controller: pagecontroller,
              itemCount: onboardingList.length,
              itemBuilder: (context, index) =>
                  buildOnboardingItem(onboardingList[index]),
            ),
          ),
          Row(
            children: [
              SmoothPageIndicator(
                  controller: pagecontroller, count: onboardingList.length),
              Spacer(),
              FloatingActionButton(
                onPressed: () {
                  (isLast)
                      ? submit()
                      : pagecontroller.nextPage(
                          duration: Duration(milliseconds: 700),
                          curve: Curves.easeIn);
                },
                child: Icon(Icons.arrow_forward_ios),
              )
            ],
          )
        ]),
      ),
    );
  }
}

Widget buildOnboardingItem(OnboardingModel item) {
  return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Expanded(
        child: Image(
      image: AssetImage(item.image),
    )),
    Text(
      item.title,
      style: TextStyle(fontSize: 30),
    ),
    SizedBox(height: 15),
    Text(
      item.body,
      style: TextStyle(fontSize: 17),
    )
  ]);
}
