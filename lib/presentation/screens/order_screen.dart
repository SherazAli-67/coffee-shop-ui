import 'package:coffee_app/core/app_colors.dart';
import 'package:coffee_app/core/app_icons.dart';
import 'package:coffee_app/core/models/coffee_model.dart';
import 'package:coffee_app/presentation/widgets/primary_btn.dart';
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
                child: Column(
                  children: [
                    Padding(
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
                              Divider(color: AppColors.lightWhiteColor,),
                              Row(
                                children: [
                                  Expanded(
                                    child: Row(
                                      spacing: 16,
                                      children: [
                                        ClipRRect(
                                          borderRadius: .circular(8),
                                          child: Image.asset(coffee.coffee, height: 55, width: 55,),
                                        ),
                                        Column(
                                          crossAxisAlignment: .start,
                                          children: [
                                            Text(coffee.title, style: AppTextStyles.btnTextStyle,),
                                            Text(coffee.subtitle, style: AppTextStyles.regularTextStyle.copyWith(color: AppColors.greyColor, fontSize: 12),)
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                  Row(
                                    spacing: 16,
                                    children: [
                                      _buildIncreaseDecreaseBtn(onTap: provider.onDecreaseQuantityTap),
                                      Text('${provider.quantity}', style: AppTextStyles.regularTextStyle.copyWith(fontWeight: .w600),),
                                      _buildIncreaseDecreaseBtn(onTap: provider.onIncreaseQuantityTap, isIncrease: true),
                                    ],
                                  )

                                ],
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    Container(
                      height: 2,
                      width: .infinity,
                      color: AppColors.borderColor,
                    ),
                    Padding(padding: .symmetric(horizontal: 24, vertical: 16), child: Column(
                      spacing: 24,
                      crossAxisAlignment: .start,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: .circular(16)
                          ),
                          padding: .symmetric(horizontal: 16, vertical: 17.5),
                          child: Row(
                            spacing: 16,
                            children: [
                              Expanded(child: Row(
                                spacing: 16,
                                children: [
                                  SvgPicture.asset(AppIcons.icDiscount),
                                  Text("1 Discount is Applies", style: AppTextStyles.regularTextStyle.copyWith(fontWeight: .w600),)
                                ],
                              )),
                              Icon(Icons.arrow_forward_ios_sharp)
                            ],
                          ),
                        ),
                        Column(
                          crossAxisAlignment: .start,
                          spacing: 16,
                          children: [
                            Text("Payment Summary", style: AppTextStyles.btnTextStyle,),
                            Column(
                              crossAxisAlignment: .start,
                              spacing: 8,
                              children: [
                                Row(
                                  mainAxisAlignment: .spaceBetween,
                                  children: [
                                    Text("Price", style: AppTextStyles.regularTextStyle,),
                                    Text('\$ ${coffee.price}', style: AppTextStyles.regularTextStyle.copyWith(fontWeight: .bold),),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: .spaceBetween,
                                  children: [
                                    Text("Delivery Fee", style: AppTextStyles.regularTextStyle,),
                                    Row(
                                      spacing: 8,
                                      children: [
                                        Text("\$ 2.0", style: AppTextStyles.regularTextStyle.copyWith(decoration: .lineThrough),),
                                        Text('\$ 1.0', style: AppTextStyles.regularTextStyle.copyWith(fontWeight: .bold),),
                                      ],
                                    )
                                  ],
                                ),

                              ],
                            )
                          ],
                        )
                      ],
                    ),),
                    const Spacer(),
                    Padding(padding: .only(top: 8), child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white
                      ),
                      padding: .symmetric(horizontal: 24, vertical: 20),
                      child: Column(
                        spacing: 8,
                        children: [
                          Row(
                            spacing: 16,
                            children: [
                              SvgPicture.asset(AppIcons.icWallet),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: .start,
                                  children: [
                                    Text("Cash/Wallet", style: AppTextStyles.regularTextStyle,),
                                    Text('\$ ${coffee.price + 1.0}', style: AppTextStyles.btnTextStyle.copyWith(color: AppColors.primaryColor),)
                                  ],
                                ),
                              ),
                              Icon(Icons.keyboard_arrow_down)
                            ],
                          ),
                          SizedBox(
                            width: .infinity,
                            child: PrimaryBtn(btnText: "Order"),
                          )
                        ],
                      ),
                    ),)
                  ],
                ),
              ),
            );
          }
        );
      }
    );
  }

  Widget _buildIncreaseDecreaseBtn({bool isIncrease = false, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            shape: .circle,
            border: .all(color: AppColors.borderColor)
        ),
        child: Icon(isIncrease ? Icons.add_rounded : Icons.remove, color: AppColors.greyColor, size: 16,),
      ),
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
