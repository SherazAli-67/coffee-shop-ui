import 'package:coffee_app/core/app_colors.dart';
import 'package:coffee_app/core/app_gradients.dart';
import 'package:coffee_app/core/app_textstyles.dart';
import 'package:coffee_app/core/models/coffee_model.dart';
import 'package:flutter/material.dart';

class CoffeeItemWidget extends StatelessWidget{
  const CoffeeItemWidget({super.key, required this.coffee});

  final CoffeeModel coffee;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: .circular(16)
      ),
      padding: .all(8),
      child: Column(
        spacing: 8,
        crossAxisAlignment: .start,
        children: [
          Expanded(child: Align(
            alignment: .center,
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: .circular(12),
                  child: Image.asset(coffee.coffee, fit: .cover,),
                ),

                Positioned(
                  right: 0,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: AppGradients.blackSmokeGradient,
                      borderRadius: .only(topLeft: .circular(0), topRight: .circular(12), bottomRight: .circular(0), bottomLeft: .circular(24))
                    ),
                    padding: .symmetric(horizontal: 14, vertical: 8),
                    alignment: .topEnd,
                    child: Row(
                      mainAxisSize: .min,
                      spacing: 5,
                      mainAxisAlignment: .end,
                      children: [
                        Icon(Icons.star, color: AppColors.ratingYellowColor, size: 10,),
                        Text('${coffee.rating}', style: AppTextStyles.regularTextStyle.copyWith(fontSize: 8, fontWeight: .w600, color: Colors.white),)
                      ],
                    ),
                  ),
                )
              ],
            ),
          )),
          Column(
            crossAxisAlignment: .start,
            children: [
              Text(coffee.title, style: AppTextStyles.btnTextStyle,),
              Text(coffee.subtitle, style: AppTextStyles.regularTextStyle.copyWith(color: AppColors.greyColor, fontSize: 12),)
            ],
          ),
          Row(
            mainAxisAlignment: .spaceBetween,
            children: [
              Text('\$${coffee.price}', style: AppTextStyles.btnTextStyle,),
              Container(
                decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: .circular(8)
                ),
                padding: .all(8),
                child: Icon(Icons.add_rounded, color: Colors.white,),
              )
            ],
          )
        ],
      ),
    );
  }
}