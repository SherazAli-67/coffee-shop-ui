import 'package:coffee_app/constants/string_const.dart';
import 'package:coffee_app/core/app_colors.dart';
import 'package:coffee_app/core/app_icons.dart';
import 'package:coffee_app/core/app_textstyles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TrackingOrderScreen extends StatelessWidget{
  const TrackingOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(AppIcons.trackingMapImg),
              fit: BoxFit.cover,
            ),
          ),
          child: Align(
            alignment: .bottomCenter,
            child: Container(
              padding: .only(bottom: 46, left: 24, right: 24, top: 16),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: .only(topLeft: .circular(20), topRight: .circular(20))
              ),
              child: Column(
                mainAxisAlignment: .end,
                mainAxisSize: .min,
                spacing: 15,
                children: [
                  Container(
                    height: 5,
                    width: 45,
                    decoration: BoxDecoration(
                        color: AppColors.lightWhiteColor,
                        borderRadius: .circular(99)
                    ),
                  ),
                  Column(
                    mainAxisSize: .min,
                    children: [
                      Text('10 minutes left', style: AppTextStyles.btnTextStyle,),
                      RichText(text: TextSpan(
                          text: 'Delivery to ',
                          style: AppTextStyles.regularTextStyle.copyWith(fontSize: 12, color: AppColors.greyColor, fontFamily: StringConst.appFontFamily),
                          children: [
                            TextSpan(
                              text: 'Sheraz Ali',
                              style: AppTextStyles.regularTextStyle.copyWith(fontSize: 12, color: AppColors.blackColor, fontWeight: .w600, fontFamily: StringConst.appFontFamily),
                            )
                          ]
                      ))
                    ],
                  ),
                  Padding(padding: .only(top: 10), child: Row(
                      spacing: 10,
                      children: List.generate(4, (index) => _buildProgressBar(isLast: index == 3))
                  ),),
                  Material(
                    color: Colors.transparent,
                    child: ListTile(
                      shape: RoundedRectangleBorder(borderRadius: .circular(12),side: BorderSide(color: AppColors.greyColor.withValues(alpha: 0.1))),
                      contentPadding: .symmetric(horizontal: 16),

                      leading: Container(
                        decoration: BoxDecoration(
                            borderRadius: .circular(12),
                            border: .all(color: AppColors.greyColor.withValues(alpha: 0.1))
                        ),
                        padding: .all(6),
                        child: Image.asset(AppIcons.icRider, height: 44,),
                      ),
                      title: Text("Delivered your order", style: AppTextStyles.regularTextStyle.copyWith(fontWeight: .w600),),
                      subtitle: Text("We will deliver your goods to you in the shortes possible time.", style: AppTextStyles.regularTextStyle.copyWith(fontSize: 12, color: AppColors.greyColor),),
                    ),
                  ),
                  Material(
                    color: Colors.transparent,
                    child: ListTile(
                      // shape: RoundedRectangleBorder(borderRadius: .circular(12),side: BorderSide(color: AppColors.greyColor.withValues(alpha: 0.1))),
                      contentPadding: .symmetric(horizontal: 16),

                      leading: ClipRRect(
                        borderRadius: .circular(12),
                        child: Image.network(AppIcons.userProfile, height: 56, width: 56, fit: .cover,),
                      ),
                      title: Text("Brooklyn Simmons", style: AppTextStyles.regularTextStyle.copyWith(fontWeight: .w600),),
                      subtitle: Text("Personal Courier", style: AppTextStyles.regularTextStyle.copyWith(fontSize: 12, color: AppColors.greyColor),),
                      trailing: SvgPicture.asset(AppIcons.icPhoneCall),
                    ),
                  )
                ],
              ),
            ),
          )
      ),
    );
  }

  Widget _buildProgressBar({required bool isLast}) {
    return Expanded(child: Container(
      decoration: BoxDecoration(
        color: isLast ? AppColors.lightWhiteColor : AppColors.progressGreenColor,
        borderRadius: .circular(99)
      ),
      height: 4,
    ));
  }
}