import 'package:coffee_app/core/app_colors.dart';
import 'package:coffee_app/core/models/coffee_model.dart';
import 'package:coffee_app/providers/order_provider.dart';
import 'package:flutter/material.dart';
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
