import 'package:coffee_app/core/app_colors.dart';
import 'package:coffee_app/core/app_data.dart';
import 'package:coffee_app/core/app_gradients.dart';
import 'package:coffee_app/core/app_icons.dart';
import 'package:coffee_app/core/app_textstyles.dart';
import 'package:coffee_app/presentation/widgets/coffee_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  late final AnimationController _entranceController;
  late final Animation<double> _locationOpacity;
  late final Animation<double> _searchOpacity;
  late final Animation<Offset> _searchOffset;
  late final Animation<double> _promoOpacity;
  late final Animation<double> _promoScale;
  late final Animation<double> _categoryOpacity;
  late final FocusNode _searchFocusNode;
  int _selectedCategoryIndex = 0;
  bool _isSearchFocused = false;

  @override
  void initState() {
    super.initState();
    _searchFocusNode = FocusNode()
      ..addListener(() {
        setState(() => _isSearchFocused = _searchFocusNode.hasFocus);
      });
    _entranceController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    _locationOpacity = CurvedAnimation(
      parent: _entranceController,
      curve: const Interval(0.0, 0.35, curve: Curves.easeOutCubic),
    );
    _searchOpacity = CurvedAnimation(
      parent: _entranceController,
      curve: const Interval(0.12, 0.48, curve: Curves.easeOutCubic),
    );
    _searchOffset = Tween<Offset>(begin: const Offset(0, 0.12), end: .zero).animate(
      CurvedAnimation(
        parent: _entranceController,
        curve: const Interval(0.12, 0.48, curve: Curves.easeOutCubic),
      ),
    );
    _promoOpacity = CurvedAnimation(
      parent: _entranceController,
      curve: const Interval(0.22, 0.58, curve: Curves.easeOutCubic),
    );
    _promoScale = Tween<double>(begin: 0.94, end: 1.0).animate(
      CurvedAnimation(
        parent: _entranceController,
        curve: const Interval(0.22, 0.58, curve: Curves.easeOutCubic),
      ),
    );
    _categoryOpacity = CurvedAnimation(
      parent: _entranceController,
      curve: const Interval(0.38, 0.68, curve: Curves.easeOutCubic),
    );
    _entranceController.forward();
  }

  @override
  void dispose() {
    _searchFocusNode.dispose();
    _entranceController.dispose();
    super.dispose();
  }

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
                FadeTransition(
                  opacity: _locationOpacity,
                  child: Column(
                      crossAxisAlignment: .start,
                      spacing: 8,
                      children: [
                        Text("Location", style: AppTextStyles.regularTextStyle.copyWith(color: AppColors.greyColor, fontSize: 12),),
                        Text("Karachi, Sindh, Pakistan", style: AppTextStyles.regularTextStyle.copyWith(fontWeight: .w600, color: Colors.white),)
                      ]),
                ),
                FadeTransition(
                  opacity: _searchOpacity,
                  child: SlideTransition(
                    position: _searchOffset,
                    child: Row(
                      spacing: 16,
                      children: [
                        Expanded(child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          curve: Curves.easeOutCubic,
                          decoration: BoxDecoration(
                              gradient: AppGradients.blackSmokeGradient,
                            borderRadius: .circular(12),
                            border: .all(color: _isSearchFocused ? AppColors.primaryColor : Colors.transparent)
                          ),
                          child: TextField(
                            focusNode: _searchFocusNode,
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
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        FadeTransition(
          opacity: _promoOpacity,
          child: ScaleTransition(
            scale: _promoScale,
            child: ClipRRect(
              borderRadius: .circular(16),
              child: Image.asset(AppIcons.promoBanner),
            ),
          ),
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
          FadeTransition(
            opacity: _categoryOpacity,
            child: SizedBox(
              height: 30,
              child: ListView.separated(
                  scrollDirection: .horizontal,
                  itemBuilder: (_, index)=> _buildCategoryItemWidget(category: AppData.categoriesList[index], isSelected: index == _selectedCategoryIndex, onTap: ()=> setState(() => _selectedCategoryIndex = index)), separatorBuilder: (_, _) => const SizedBox(width: 16,), itemCount: AppData.categoriesList.length),
            ),
          ),
          Expanded(child: GridView.builder(
              itemCount: AppData.coffeesList.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, mainAxisSpacing: 15, crossAxisSpacing: 15, childAspectRatio: 0.64 ), itemBuilder: (ctx, index)=> _buildStaggeredGridItemWidget(index: index, child: CoffeeItemWidget(coffee: AppData.coffeesList[index]))))
        ],
      ),
    );
  }

  Widget _buildCategoryItemWidget({required String category, required bool isSelected, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOutCubic,
        decoration: BoxDecoration(
            borderRadius: .circular(6),
            color: isSelected ? AppColors.primaryColor : AppColors.lightWhiteColor.withValues(alpha: 0.35)
        ),
        padding: .symmetric(horizontal: 8, vertical: 4,),
        alignment: .center,
        child: AnimatedDefaultTextStyle(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOutCubic,
          style: AppTextStyles.regularTextStyle.copyWith(color: isSelected ? Colors.white : AppColors.gradientBlackColor2, fontWeight: isSelected ? .w600 : .w400),
          child: Text(category),
        ),
      ),
    );
  }

  Widget _buildStaggeredGridItemWidget({required int index, required Widget child}) {
    final start = (0.45 + index * 0.08).clamp(0.0, 0.7);
    final end = (start + 0.32).clamp(0.0, 1.0);
    return AnimatedBuilder(
      animation: _entranceController,
      builder: (context, child) {
        final progress = Interval(start, end, curve: Curves.easeOutCubic).transform(_entranceController.value);
        return Opacity(
          opacity: progress,
          child: Transform.translate(
            offset: Offset(0, 12 * (1 - progress)),
            child: child,
          ),
        );
      },
      child: child,
    );
  }
}
