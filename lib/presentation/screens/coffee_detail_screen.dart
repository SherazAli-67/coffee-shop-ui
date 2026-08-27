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

class _CoffeeDetailScreenState extends State<CoffeeDetailScreen> with TickerProviderStateMixin {

  String _selectedSize = '';
  bool _isFavorite = false;
  bool _isDescriptionExpanded = false;
  late final AnimationController _entranceController;
  late final AnimationController _favoriteController;
  late final Animation<double> _titleOpacity;
  late final Animation<Offset> _titleOffset;
  late final Animation<double> _metaOpacity;
  late final Animation<double> _icon1Opacity;
  late final Animation<double> _icon2Opacity;
  late final Animation<double> _icon3Opacity;
  late final Animation<double> _descriptionOpacity;
  late final Animation<double> _sizeOpacity;
  late final Animation<Offset> _bottomBarOffset;
  late final Animation<double> _favoriteScale;

  static const _fullDescription = 'A cappuccino is an approximately 150 ml (5 oz) beverage, with 25 ml of espresso coffee and 85ml of fresh milk the foamed milk creates a creamy texture that balances the bold espresso for a smooth, rich cup every time.';

  @override
  void initState() {
    super.initState();
    _entranceController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );
    _favoriteController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _titleOpacity = CurvedAnimation(
      parent: _entranceController,
      curve: const Interval(0.15, 0.45, curve: Curves.easeOutCubic),
    );
    _titleOffset = Tween<Offset>(begin: const Offset(0, 0.12), end: .zero).animate(
      CurvedAnimation(
        parent: _entranceController,
        curve: const Interval(0.15, 0.45, curve: Curves.easeOutCubic),
      ),
    );
    _metaOpacity = CurvedAnimation(
      parent: _entranceController,
      curve: const Interval(0.28, 0.55, curve: Curves.easeOutCubic),
    );
    _icon1Opacity = CurvedAnimation(
      parent: _entranceController,
      curve: const Interval(0.32, 0.55, curve: Curves.easeOutCubic),
    );
    _icon2Opacity = CurvedAnimation(
      parent: _entranceController,
      curve: const Interval(0.38, 0.6, curve: Curves.easeOutCubic),
    );
    _icon3Opacity = CurvedAnimation(
      parent: _entranceController,
      curve: const Interval(0.44, 0.65, curve: Curves.easeOutCubic),
    );
    _descriptionOpacity = CurvedAnimation(
      parent: _entranceController,
      curve: const Interval(0.48, 0.72, curve: Curves.easeOutCubic),
    );
    _sizeOpacity = CurvedAnimation(
      parent: _entranceController,
      curve: const Interval(0.58, 0.82, curve: Curves.easeOutCubic),
    );
    _bottomBarOffset = Tween<Offset>(begin: const Offset(0, 1), end: .zero).animate(
      CurvedAnimation(
        parent: _entranceController,
        curve: const Interval(0.55, 0.9, curve: Curves.easeOutCubic),
      ),
    );
    _favoriteScale = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 1.2), weight: 50),
      TweenSequenceItem(tween: Tween(begin: 1.2, end: 1.0), weight: 50),
    ]).animate(CurvedAnimation(parent: _favoriteController, curve: Curves.easeOutCubic));
    Future.delayed(const Duration(milliseconds: 200), () {
      if (mounted) _entranceController.forward();
    });
  }

  @override
  void dispose() {
    _entranceController.dispose();
    _favoriteController.dispose();
    super.dispose();
  }

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
                      GestureDetector(
                        onTap: onFavoriteTap,
                        child: ScaleTransition(
                          scale: _favoriteScale,
                          child: SvgPicture.asset(
                            AppIcons.icFavorite,
                            colorFilter: _isFavorite ? .mode(AppColors.primaryColor, .srcIn) : null,
                          ),
                        ),
                      )
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
                  FadeTransition(
                    opacity: _titleOpacity,
                    child: SlideTransition(
                      position: _titleOffset,
                      child: Row(
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
                                  FadeTransition(
                                    opacity: _metaOpacity,
                                    child: Text(widget.coffee.subtitle, style: AppTextStyles.regularTextStyle.copyWith(fontSize: 12, color: AppColors.greyColor),),
                                  ),
                                  FadeTransition(
                                    opacity: _metaOpacity,
                                    child: Row(
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
                                    ),
                                  )
                                ],
                              )
                            ],
                          )),
                          Expanded(child: Row(
                            spacing: 12,
                            children: [
                              FadeTransition(opacity: _icon1Opacity, child: _buildDetailIconWidget(icon: AppIcons.icRider)),
                              FadeTransition(opacity: _icon2Opacity, child: _buildDetailIconWidget(icon: AppIcons.icCoffeeBean)),
                              FadeTransition(opacity: _icon3Opacity, child: _buildDetailIconWidget(icon: AppIcons.icCoffeePackage)),
                            ],
                          ))
                        ],
                      ),
                    ),
                  ),
                  FadeTransition(
                    opacity: _descriptionOpacity,
                    child: Divider(color: AppColors.lightWhiteColor,),
                  ),
                  FadeTransition(
                    opacity: _descriptionOpacity,
                    child: Column(
                      crossAxisAlignment: .start,
                      spacing: 8,
                      children: [
                        Text("Description", style: AppTextStyles.btnTextStyle,),
                        AnimatedSize(
                          duration: const Duration(milliseconds: 250),
                          curve: Curves.easeOutCubic,
                          alignment: .topLeft,
                          child: GestureDetector(
                            onTap: ()=> setState(() => _isDescriptionExpanded = !_isDescriptionExpanded),
                            child: RichText(text: TextSpan(
                              text: _isDescriptionExpanded ? _fullDescription : StringConst.coffeeDescription,
                              style: AppTextStyles.regularTextStyle.copyWith(color: AppColors.greyColor, fontFamily: StringConst.appFontFamily, height: 1.5),
                              children: [
                                TextSpan(
                                    text: _isDescriptionExpanded ? ' Read Less' : 'Read More',
                                    style: AppTextStyles.regularTextStyle.copyWith(color: AppColors.primaryColor, fontWeight: .w600, fontFamily: StringConst.appFontFamily, height: 1.5)
                                )
                              ]
                            )),
                          ),
                        )
                      ],
                    ),
                  ),
                  FadeTransition(
                    opacity: _sizeOpacity,
                    child: Padding(padding: .only(top: 8), child: Column(
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
                  ),
                ],
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
              child: Row(
                spacing: 34,
                children: [
                  Column(
                    crossAxisAlignment: .start,
                    children: [
                      Text("Price", style: AppTextStyles.regularTextStyle,),
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 200),
                        transitionBuilder: (child, animation) => FadeTransition(
                          opacity: animation,
                          child: SlideTransition(
                            position: Tween<Offset>(begin: const Offset(0, 0.3), end: .zero).animate(animation),
                            child: child,
                          ),
                        ),
                        child: Text(
                          '\$ ${widget.coffee.price}',
                          key: ValueKey(_selectedSize.isEmpty ? 'default' : _selectedSize),
                          style: AppTextStyles.btnTextStyle.copyWith(color: AppColors.primaryColor),
                        ),
                      )
                    ],
                  ),
                  Expanded(child: PrimaryBtn(btnText: "Buy Now", onTap: ()=> context.push(NamedRoutes.orderScreen.routeName, extra: widget.coffee),))
                ],
              ),
            ),),
          )
        ],
      )),
    );
  }

  Widget _buildSizeItemWidget({required String size}) {
    bool isSelected = _selectedSize == size;
    return GestureDetector(
      onTap: ()=> onSelectSizeTap(size),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOutCubic,
        decoration: BoxDecoration(
            borderRadius: .circular(12),
            border: .all(color: isSelected ? AppColors.primaryColor : AppColors.lightWhiteColor),
          color: isSelected ? AppColors.primaryColor.withValues(alpha: 0.1) : null
        ),
        padding: .symmetric(vertical: 10),
        child: AnimatedDefaultTextStyle(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOutCubic,
          style: AppTextStyles.regularTextStyle.copyWith(
            color: isSelected ? AppColors.primaryColor : AppColors.blackColor,
            fontWeight: isSelected ? .w600 : .w400,
          ),
          child: Text(size, textAlign: .center,),
        ),
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

  void onFavoriteTap() {
    setState(() => _isFavorite = !_isFavorite);
    _favoriteController.forward(from: 0);
  }
}
