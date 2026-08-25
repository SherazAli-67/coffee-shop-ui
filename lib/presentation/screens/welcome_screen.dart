import 'package:coffee_app/core/app_colors.dart';
import 'package:coffee_app/core/app_icons.dart';
import 'package:coffee_app/core/app_textstyles.dart';
import 'package:coffee_app/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../widgets/primary_btn.dart';

class WelcomeScreen extends StatelessWidget{
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.blackColor,
        body: Column(
      children: [
        Expanded(child: Image.asset(AppIcons.welcomeImg, fit: .cover,)),
        SafeArea(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [
                    AppColors.blackColor.withValues(alpha: 0.0),
                    AppColors.blackColor
                  ],
                  stops: [
                    0.0,
                    1.0
                  ],
                begin: .topCenter,
                end: .bottomCenter
              ),
              color: AppColors.blackColor
            ),
            padding: .symmetric(horizontal: 24),
            child: Column(
              mainAxisAlignment: .end,
              spacing: 32,
              children: [
                Column(
                  spacing: 8,
                  children: [
                    Text("Fall in Love with Coffee in Blissful Delight!", style: AppTextStyles.headingTextStyle.copyWith(color: Colors.white), textAlign: .center,),
                    Text("Welcome to our cozy coffee corner, where every cup is a delightful for you.", style: AppTextStyles.regularTextStyle.copyWith(color: AppColors.greyColor),textAlign: .center,)
                  ],
                ),
                SizedBox(
                  width: .infinity,
                  child: PrimaryBtn(btnText: 'Get Started', onTap: ()=> context.push(NamedRoutes.home.routeName),),
                )
              ],
            ),
          ),
        )
      ],
    ));
  }
}