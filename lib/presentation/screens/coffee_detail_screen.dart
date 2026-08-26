import 'package:coffee_app/constants/string_const.dart';
import 'package:coffee_app/core/app_colors.dart';
import 'package:coffee_app/core/app_icons.dart';
import 'package:coffee_app/core/app_textstyles.dart';
import 'package:coffee_app/core/models/coffee_model.dart';
import 'package:coffee_app/presentation/widgets/primary_btn.dart';
import 'package:coffee_app/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class CoffeeDetailScreen extends StatefulWidget{
  const CoffeeDetailScreen({super.key, required this.coffee});

  final CoffeeModel coffee;

  @override
  State<CoffeeDetailScreen> createState() => _CoffeeDetailScreenState();
}

class _CoffeeDetailScreenState extends State<CoffeeDetailScreen> {
  
  String _selectedSize = '';
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
                      tag: widget.coffee.id,
                      child: ClipRRect(
                        borderRadius: .circular(16),
                        child: SizedBox(
                            width: .infinity,
                            child: Image.asset(widget.coffee.coffee, fit: .cover,)),
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
                              Text(widget.coffee.title, style: AppTextStyles.btnTextStyle.copyWith(fontSize: 20),),
                              Text(widget.coffee.subtitle, style: AppTextStyles.regularTextStyle.copyWith(fontSize: 12, color: AppColors.greyColor),),
                              Row(
                                children: [
                                  Icon(
                                    Icons.star_rate_rounded, color: AppColors.ratingYellowColor, size: 20
                                  ),
                                  RichText(text: TextSpan(
                                    text: '${widget.coffee.rating} ',
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
                    Text('\$ ${widget.coffee.price}', style: AppTextStyles.btnTextStyle.copyWith(color: AppColors.primaryColor),)
                  ],
                ),
                Expanded(child: PrimaryBtn(btnText: "Buy Now", onTap: ()=> context.push(NamedRoutes.orderScreen.routeName, extra: widget.coffee),))
              ],
            ),
          ),)
        ],
      )),
    );
  }

  Widget _buildSizeItemWidget({required String size}) {
    bool isSelected = _selectedSize == size;
    return GestureDetector(
      onTap: ()=> onSelectSizeTap(size),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: .circular(12),
            border: .all(color: isSelected ? AppColors.primaryColor : AppColors.lightWhiteColor),
          color: isSelected ? AppColors.primaryColor.withValues(alpha: 0.1) : null
        ),
        padding: .symmetric(vertical: 10),
        child: Text(size, style: AppTextStyles.regularTextStyle, textAlign: .center,),
      ),
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
  
  void onSelectSizeTap(String size) => setState(() => _selectedSize = size);
}