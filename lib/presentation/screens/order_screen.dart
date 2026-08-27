import 'package:coffee_app/core/app_colors.dart';
import 'package:coffee_app/core/app_icons.dart';
import 'package:coffee_app/core/models/coffee_model.dart';
import 'package:coffee_app/presentation/widgets/primary_btn.dart';
import 'package:coffee_app/providers/order_provider.dart';
import 'package:coffee_app/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../core/app_textstyles.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key, required this.coffee});
  final CoffeeModel coffee;

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> with TickerProviderStateMixin {
  late final AnimationController _entranceController;
  late final AnimationController _qtyController;
  late final Animation<double> _qtyScale;
  late final Animation<double> _contentOpacity;
  late final Animation<Offset> _contentOffset;
  late final Animation<Offset> _bottomBarOffset;
  bool _isDiscountExpanded = false;

  @override
  void initState() {
    super.initState();
    _entranceController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );
    _qtyController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 280),
    );
    _qtyScale = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 1.35), weight: 50),
      TweenSequenceItem(tween: Tween(begin: 1.35, end: 1.0), weight: 50),
    ]).animate(CurvedAnimation(parent: _qtyController, curve: Curves.easeOutCubic));
    _contentOpacity = CurvedAnimation(
      parent: _entranceController,
      curve: const Interval(0.0, 0.65, curve: Curves.easeOutCubic),
    );
    _contentOffset = Tween<Offset>(begin: const Offset(0, 0.06), end: .zero).animate(
      CurvedAnimation(
        parent: _entranceController,
        curve: const Interval(0.0, 0.65, curve: Curves.easeOutCubic),
      ),
    );
    _bottomBarOffset = Tween<Offset>(begin: const Offset(0, 1), end: .zero).animate(
      CurvedAnimation(
        parent: _entranceController,
        curve: const Interval(0.35, 1.0, curve: Curves.easeOutCubic),
      ),
    );
    _entranceController.forward();
  }

  @override
  void dispose() {
    _entranceController.dispose();
    _qtyController.dispose();
    super.dispose();
  }

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
                    Expanded(
                      child: FadeTransition(
                        opacity: _contentOpacity,
                        child: SlideTransition(
                          position: _contentOffset,
                          child: SingleChildScrollView(
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
                                      _buildDeliveryTypeToggle(provider: provider),
                                      Column(
                                        crossAxisAlignment: .start,
                                        spacing: 16,
                                        children: [
                                          AnimatedSize(
                                            duration: const Duration(milliseconds: 280),
                                            curve: Curves.easeOutCubic,
                                            alignment: .topCenter,
                                            clipBehavior: .hardEdge,
                                            child: provider.isDeliverOrder
                                                ? Column(
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
                                                    ],
                                                  )
                                                : const SizedBox(width: .infinity),
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
                                                      child: Image.asset(widget.coffee.coffee, height: 55, width: 55,),
                                                    ),
                                                    Column(
                                                      crossAxisAlignment: .start,
                                                      children: [
                                                        Text(widget.coffee.title, style: AppTextStyles.btnTextStyle,),
                                                        Text(widget.coffee.subtitle, style: AppTextStyles.regularTextStyle.copyWith(color: AppColors.greyColor, fontSize: 12),)
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ),
                                              Row(
                                                spacing: 16,
                                                children: [
                                                  _buildIncreaseDecreaseBtn(
                                                    onTap: ()=> _onQuantityTap(provider.onDecreaseQuantityTap),
                                                    enabled: provider.quantity > 1,
                                                  ),
                                                  ScaleTransition(
                                                    scale: _qtyScale,
                                                    child: AnimatedSwitcher(
                                                      duration: const Duration(milliseconds: 180),
                                                      transitionBuilder: (child, animation) => FadeTransition(
                                                        opacity: animation,
                                                        child: ScaleTransition(scale: animation, child: child),
                                                      ),
                                                      child: Text(
                                                        '${provider.quantity}',
                                                        key: ValueKey(provider.quantity),
                                                        style: AppTextStyles.regularTextStyle.copyWith(fontWeight: .w600),
                                                      ),
                                                    ),
                                                  ),
                                                  _buildIncreaseDecreaseBtn(
                                                    onTap: ()=> _onQuantityTap(provider.onIncreaseQuantityTap),
                                                    isIncrease: true,
                                                  ),
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
                                    Material(
                                      color: Colors.white,
                                      borderRadius: .circular(16),
                                      child: InkWell(
                                        onTap: ()=> setState(() => _isDiscountExpanded = !_isDiscountExpanded),
                                        borderRadius: .circular(16),
                                        child: Padding(
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
                                              AnimatedRotation(
                                                turns: _isDiscountExpanded ? 0.25 : 0,
                                                duration: const Duration(milliseconds: 200),
                                                curve: Curves.easeOutCubic,
                                                child: Icon(Icons.arrow_forward_ios_sharp),
                                              )
                                            ],
                                          ),
                                        ),
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
                                                _buildAnimatedAmountText(
                                                  text: '\$ ${widget.coffee.price * provider.quantity}',
                                                  keyValue: 'price-${provider.quantity}',
                                                  style: AppTextStyles.regularTextStyle.copyWith(fontWeight: .bold),
                                                ),
                                              ],
                                            ),
                                            AnimatedSize(
                                              duration: const Duration(milliseconds: 280),
                                              curve: Curves.easeOutCubic,
                                              clipBehavior: .hardEdge,
                                              child: provider.isDeliverOrder
                                                  ? Row(
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
                                                    )
                                                  : const SizedBox(width: .infinity),
                                            ),
                                          ],
                                        )
                                      ],
                                    )
                                  ],
                                ),),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    SlideTransition(
                      position: _bottomBarOffset,
                      child: Padding(padding: .only(top: 8), child: Container(
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
                                      _buildAnimatedAmountText(
                                        text: '\$ ${((widget.coffee.price * provider.quantity) + (provider.isDeliverOrder ? 1.0 : 0.0)).toStringAsFixed(2)}',
                                        keyValue: 'wallet-${provider.quantity}-${provider.isDeliverOrder}',
                                        style: AppTextStyles.btnTextStyle.copyWith(color: AppColors.primaryColor),
                                      ),
                                    ],
                                  ),
                                ),
                                Icon(Icons.keyboard_arrow_down)
                              ],
                            ),
                            SizedBox(
                              width: .infinity,
                              child: PrimaryBtn(btnText: "Order", onTap: ()=> context.push(NamedRoutes.trackingOrder.routeName),),
                            )
                          ],
                        ),
                      ),),
                    )
                  ],
                ),
              ),
            );
          }
        );
      }
    );
  }

  void _onQuantityTap(VoidCallback action) {
    action();
    _qtyController.forward(from: 0);
  }

  Widget _buildDeliveryTypeToggle({required OrderProvider provider}) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.lightWhiteColor,
        borderRadius: .circular(12)
      ),
      padding: .all(4),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final pillWidth = constraints.maxWidth / 2;
          return Stack(
            children: [
              AnimatedPositioned(
                duration: const Duration(milliseconds: 280),
                curve: Curves.easeOutCubic,
                left: provider.isDeliverOrder ? 0 : pillWidth,
                top: 0,
                bottom: 0,
                width: pillWidth,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: .circular(8),
                    color: AppColors.primaryColor,
                  ),
                ),
              ),
              Row(
                children: [
                  Expanded(child: _buildOrderType(title: 'Deliver', isSelected: provider.isDeliverOrder, onTap: ()=> provider.changeDeliveryType('Deliver'))),
                  Expanded(child: _buildOrderType(title: 'Pick Up', isSelected: !provider.isDeliverOrder, onTap: ()=> provider.changeDeliveryType('Pick Up')))
                ],
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildAnimatedAmountText({required String text, required String keyValue, required TextStyle style}) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 220),
      transitionBuilder: (child, animation) => FadeTransition(
        opacity: animation,
        child: SlideTransition(
          position: Tween<Offset>(begin: const Offset(0, 0.35), end: .zero).animate(animation),
          child: child,
        ),
      ),
      child: Text(text, key: ValueKey(keyValue), style: style,),
    );
  }

  Widget _buildIncreaseDecreaseBtn({bool isIncrease = false, required VoidCallback onTap, bool enabled = true}) {
    return GestureDetector(
      onTap: enabled ? onTap : null,
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 200),
        opacity: enabled ? 1.0 : 0.4,
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              shape: .circle,
              border: .all(color: AppColors.borderColor)
          ),
          child: Icon(isIncrease ? Icons.add_rounded : Icons.remove, color: AppColors.greyColor, size: 16,),
        ),
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
      behavior: .opaque,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: .circular(8),
            color: Colors.transparent
        ),
        padding: .symmetric(vertical: 8),
        child: AnimatedDefaultTextStyle(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOutCubic,
          style: AppTextStyles.btnTextStyle.copyWith(color: isSelected ? Colors.white : AppColors.blackColor, fontWeight: isSelected ? .w600 : .w400),
          child: Text(title, textAlign: .center,),
        ),
      ),
    );
  }
}
