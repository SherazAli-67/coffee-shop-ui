import 'package:coffee_app/core/app_colors.dart';
import 'package:coffee_app/core/app_icons.dart';
import 'package:coffee_app/core/app_textstyles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 2,
          child: _buildHeaderWidget(),
        ),
        Expanded(
            flex: 3,
            child: Container(color: Colors.white)),
      ],
    );
  }

  Widget _buildHeaderWidget() {
    return Stack(
      alignment: .bottomCenter,
      children: [
        Container(
          padding: .all(24),
          decoration: BoxDecoration(
            color: AppColors.blackColor
          ),
          margin: .only(bottom: 50),
          child: SafeArea(
            child: Column(
              spacing: 24,
              crossAxisAlignment: .start,
              children: [
                Column(
                    crossAxisAlignment: .start,
                    spacing: 8,
                    children: [
                      Text("Location", style: AppTextStyles.regularTextStyle.copyWith(color: AppColors.greyColor, fontSize: 12),),
                      Text("Karachi, Sindh, Pakistan", style: AppTextStyles.regularTextStyle.copyWith(fontWeight: .w600, color: Colors.white),)
                    ]),
                Row(
                  spacing: 16,
                  children: [
                    Expanded(child: Container(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: [
                                AppColors.gradientBlackColor1,
                                AppColors.gradientBlackColor2,
                              ],
                              stops: [
                                0.0,
                                1.0
                              ],
                              begin: .topLeft,
                              end: .topRight
                          ),
                        borderRadius: .circular(12)
                      ),
                      child: TextField(
                        decoration: InputDecoration(
                          enabledBorder: .none,
                          focusedBorder: .none,
                          fillColor: AppColors.hoverBlackColor,
                          hintText: "Search coffee",
                          hintStyle: AppTextStyles.regularTextStyle.copyWith(color: AppColors.greyColor),
                          prefixIcon: Padding(
                            padding: const .only(left: 10.0),
                            child: SvgPicture.asset(AppIcons.icSearch, height: 24,),
                          ),
                          prefixIconConstraints: BoxConstraints(minHeight: 0, minWidth: 0),
                          contentPadding: .symmetric(vertical: 17.5)
                        ),
                      ),
                    )),
                    Container(
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor,
                        borderRadius: .circular(12),
                      ),
                      padding: .all(16),
                      child: SvgPicture.asset(AppIcons.icFilter),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
        ClipRRect(
          borderRadius: .circular(16),
          child: Image.asset(AppIcons.promoBanner),
        ),
      ],
    );
  }
}
