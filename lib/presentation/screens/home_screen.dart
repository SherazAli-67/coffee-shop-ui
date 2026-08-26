import 'package:coffee_app/core/app_colors.dart';
import 'package:coffee_app/core/app_data.dart';
import 'package:coffee_app/core/app_gradients.dart';
import 'package:coffee_app/core/app_icons.dart';
import 'package:coffee_app/core/app_textstyles.dart';
import 'package:coffee_app/presentation/widgets/coffee_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: _buildHeaderWidget(),
          ),
          Expanded(
              flex: 3,
              child: _buildContentWidget()),
        ],
      ),
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
                          gradient: AppGradients.blackSmokeGradient,
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

  Widget _buildContentWidget() {
    return Padding(
      padding: const .all(24.0),
      child: Column(
        crossAxisAlignment: .start,
        children: [
          SizedBox(
            height: 30,
            child: ListView.separated(
                scrollDirection: .horizontal,
                itemBuilder: (_, index)=> _buildCategoryItemWidget(category: AppData.categoriesList[index], isSelected: index == 0, onTap: (){}), separatorBuilder: (_, _) => const SizedBox(width: 16,), itemCount: AppData.categoriesList.length),
          ),
          Expanded(child: GridView.builder(
              itemCount: AppData.coffeesList.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, mainAxisSpacing: 15, crossAxisSpacing: 15, childAspectRatio: 0.64 ), itemBuilder: (ctx, index)=> CoffeeItemWidget(coffee: AppData.coffeesList[index])))
        ],
      ),
    );
  }

  Widget _buildCategoryItemWidget({required String category, required bool isSelected, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: .circular(6),
            color: isSelected ? AppColors.primaryColor : AppColors.lightWhiteColor.withValues(alpha: 0.35)
        ),
        padding: .symmetric(horizontal: 8, vertical: 4,),
        alignment: .center,
        child: Text(category, style: AppTextStyles.regularTextStyle.copyWith(color: isSelected ? Colors.white : AppColors.gradientBlackColor2, fontWeight: isSelected ? .w600 : .w400),),
      ),
    );
  }
}
