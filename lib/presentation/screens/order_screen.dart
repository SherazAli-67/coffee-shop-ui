import 'package:coffee_app/core/app_colors.dart';
import 'package:coffee_app/core/app_icons.dart';
import 'package:coffee_app/core/models/coffee_model.dart';
import 'package:coffee_app/providers/order_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../core/app_textstyles.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key, required this.coffee});
  final CoffeeModel coffee;
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => OrderProvider(),
      builder: (_, child) {
        return Consumer<OrderProvider>(
          builder: (_, provider, _) {
            return Scaffold(
              body: SafeArea(
                child: Padding(
                  padding: .symmetric(horizontal: 24, vertical: 20),
                  child: Column(
                    crossAxisAlignment: .start,
                    spacing: 24,
                    children: [
                      Row(
                        mainAxisAlignment: .spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: Icon(Icons.arrow_back_ios_new),
                          ),
                          Text("Order", style: AppTextStyles.btnTextStyle),
                          const SizedBox(width: 40),
                        ],
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: AppColors.lightWhiteColor,
                          borderRadius: .circular(12)
                        ),
                        padding: .all(4),
                        child: Row(
                          children: [
                            Expanded(child: _buildOrderType(title: 'Deliver', isSelected: provider.isDeliverOrder, onTap: ()=> provider.changeDeliveryType('Deliver'))),
                            Expanded(child: _buildOrderType(title: 'Pick Up', isSelected: !provider.isDeliverOrder, onTap: ()=> provider.changeDeliveryType('Pick Up')))

                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: .start,
                        spacing: 16,
                        children: [
                          Text("Delivery Address", style: AppTextStyles.btnTextStyle,),
                          Column(
                            crossAxisAlignment: .start,
                            spacing: 4,
                            children: [
                              Text("Sheraz Ali", style: AppTextStyles.regularTextStyle.copyWith(fontWeight: .bold),),
                              Text("Kpg. Sutoyo No. 620, Bilzen, Tanjungbalai.", style: AppTextStyles.regularTextStyle.copyWith(color: AppColors.greyColor),)
                            ],
                          ),
                          Row(
                            spacing: 8,
                            children: [
                              _buildAddressAndNotesWidget(icon: AppIcons.icEdit, title: 'Edit Address'),
                              _buildAddressAndNotesWidget(icon: AppIcons.icNotes, title: 'Add Notes'),
                            ],
                          ),
                          Divider(color: AppColors.lightWhiteColor,)
                        ],
                      )
                    ],
                  ),
                ),
              ),
            );
          }
        );
      }
    );
  }

  Widget _buildAddressAndNotesWidget({required String icon, required String title}) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: .circular(99),
          border: .all(color: AppColors.greyColor)
      ),
      padding: .symmetric(vertical: 6, horizontal: 12),
      child: Row(
        spacing: 4,
        children: [
          SvgPicture.asset(icon, height: 14,),
          Text(title,
            style: AppTextStyles.regularTextStyle.copyWith(fontSize: 12),)
        ],
      ),
    );
  }

  Widget _buildOrderType({required String title, required bool isSelected, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: .circular(8),
            color: isSelected ? AppColors.primaryColor : Colors
                .transparent
        ),
        padding: .symmetric(vertical: 8),
        child: Text(title,
          style: AppTextStyles.btnTextStyle.copyWith(color: isSelected ? Colors.white : AppColors.blackColor, fontWeight: isSelected ? .w600 : .w400),
          textAlign: .center,),
      ),
    );
  }
}
