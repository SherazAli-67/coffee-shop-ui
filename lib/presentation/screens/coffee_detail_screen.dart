import 'package:coffee_app/constants/string_const.dart';
import 'package:coffee_app/core/app_colors.dart';
import 'package:coffee_app/core/app_icons.dart';
import 'package:coffee_app/core/app_textstyles.dart';
import 'package:coffee_app/core/models/coffee_model.dart';
import 'package:coffee_app/presentation/widgets/primary_btn.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CoffeeDetailScreen extends StatelessWidget{
  const CoffeeDetailScreen({super.key, required this.coffee});

  final CoffeeModel coffee;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const .all(24.0),
              child: Column(
                spacing: 16,
                crossAxisAlignment: .start,
                children: [
                  Row(
                    mainAxisAlignment: .spaceBetween,
                    children: [
                      GestureDetector(onTap: ()=> Navigator.pop(context), child: Icon(Icons.arrow_back_ios_new),),
                      Text("Detail", style: AppTextStyles.btnTextStyle,),
                      SvgPicture.asset(AppIcons.icFavorite)
                    ],
                  ),
                  Padding(
                    padding: const .only(top: 8.0),
                    child: Hero(
                      tag: coffee.id,
                      child: ClipRRect(
                        borderRadius: .circular(16),
                        child: SizedBox(
                            width: .infinity,
                            child: Image.asset(coffee.coffee, fit: .cover,)),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(child: Column(
                        spacing: 16,
                        crossAxisAlignment: .start,
                        children: [
                          Column(
                            spacing: 4,
                            crossAxisAlignment: .start,
                            children: [
                              Text(coffee.title, style: AppTextStyles.btnTextStyle.copyWith(fontSize: 20),),
                              Text(coffee.subtitle, style: AppTextStyles.regularTextStyle.copyWith(fontSize: 12, color: AppColors.greyColor),),
                              Row(
                                children: [
                                  Icon(
                                    Icons.star_rate_rounded, color: AppColors.ratingYellowColor, size: 20
                                  ),
                                  RichText(text: TextSpan(
                                    text: '${coffee.rating} ',
                                    style: AppTextStyles.btnTextStyle.copyWith(fontFamily: StringConst.appFontFamily, color: AppColors.blackColor),
                                    children: [
                                      TextSpan(
                                        text: '(230)',
                                        style: AppTextStyles.regularTextStyle.copyWith(fontSize: 12, color: AppColors.greyColor, fontFamily: StringConst.appFontFamily)
                                      )
                                    ]
                                  ))
                                ],
                              )
                            ],
                          )
                        ],
                      )),
                      Expanded(child: Row(
                        spacing: 12,
                        children: [
                          _buildDetailIconWidget(icon: AppIcons.icRider),
                          _buildDetailIconWidget(icon: AppIcons.icCoffeeBean),
                          _buildDetailIconWidget(icon: AppIcons.icCoffeePackage),
                        ],
                      ))
                    ],
                  ),
                  Divider(color: AppColors.lightWhiteColor,),
                  Column(
                    crossAxisAlignment: .start,
                    spacing: 8,
                    children: [
                      Text("Description", style: AppTextStyles.btnTextStyle,),
                      RichText(text: TextSpan(
                        text: StringConst.coffeeDescription,
                        style: AppTextStyles.regularTextStyle.copyWith(color: AppColors.greyColor, fontFamily: StringConst.appFontFamily, height: 1.5),
                        children: [
                          TextSpan(
                              text: 'Read More',
                              style: AppTextStyles.regularTextStyle.copyWith(color: AppColors.primaryColor, fontWeight: .w600, fontFamily: StringConst.appFontFamily, height: 1.5)
                          )
                        ]
                      ))
                    ],
                  ),
                  Padding(padding: .only(top: 8), child: Column(
                    crossAxisAlignment: .start,
                    spacing: 16,
                    children: [
                      Text("Size", style: AppTextStyles.btnTextStyle,),
                      Row(
                        spacing: 16,
                        children: [
                          Expanded(child: _buildSizeItemWidget(size: 'S')),
                          Expanded(child: _buildSizeItemWidget(size: 'M')),
                          Expanded(child: _buildSizeItemWidget(size: 'L')),
                        ],
                      )
                    ],
                  ),),
                ],
              ),
            ),
          ),
          Padding(padding: .only(top: 8), child: Container(
            decoration: BoxDecoration(
                color: Colors.white
            ),
            padding: .symmetric(horizontal: 24, vertical: 20),
            child: Row(
              spacing: 34,
              children: [
                Column(
                  crossAxisAlignment: .start,
                  children: [
                    Text("Price", style: AppTextStyles.regularTextStyle,),
                    Text('\$ ${coffee.price}', style: AppTextStyles.btnTextStyle.copyWith(color: AppColors.primaryColor),)
                  ],
                ),
                Expanded(child: PrimaryBtn(btnText: "Buy Now"))
              ],
            ),
          ),)
        ],
      )),
    );
  }

  Widget _buildSizeItemWidget({required String size}) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: .circular(12),
          border: .all(color: AppColors.lightWhiteColor)
      ),
      padding: .symmetric(vertical: 10),
      child: Text(size, style: AppTextStyles.regularTextStyle, textAlign: .center,),
    );
  }

  Widget _buildDetailIconWidget({required String icon}) {
    return Container(
      decoration: BoxDecoration(
          color: AppColors.lightWhiteColor.withValues(alpha: 0.35),
          borderRadius: .circular(12)
      ),
      padding: .all(6),
      child: Image.asset(icon, height: 30, width: 30),
    );
  }
}