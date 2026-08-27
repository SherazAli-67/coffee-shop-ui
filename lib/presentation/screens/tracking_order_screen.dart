import 'package:coffee_app/constants/string_const.dart';
import 'package:coffee_app/core/app_colors.dart';
import 'package:coffee_app/core/app_icons.dart';
import 'package:coffee_app/core/app_textstyles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TrackingOrderScreen extends StatefulWidget{
  const TrackingOrderScreen({super.key});

  @override
  State<TrackingOrderScreen> createState() => _TrackingOrderScreenState();
}

class _TrackingOrderScreenState extends State<TrackingOrderScreen> with TickerProviderStateMixin {
  late final AnimationController _sheetController;
  late final AnimationController _progressController;
  late final AnimationController _pinController;
  late final Animation<Offset> _sheetOffset;
  late final Animation<double> _etaOpacity;
  late final Animation<double> _statusOpacity;
  late final Animation<double> _courierOpacity;
  late final Animation<double> _pinScale;
  late final Animation<double> _pinOpacity;
  bool _isCallPressed = false;

  @override
  void initState() {
    super.initState();
    _sheetController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 750),
    );
    _progressController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    );
    _pinController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    )..repeat(reverse: true);
    _sheetOffset = Tween<Offset>(begin: const Offset(0, 1), end: .zero).animate(
      CurvedAnimation(
        parent: _sheetController,
        curve: const Interval(0.0, 0.7, curve: Curves.easeOutCubic),
      ),
    );
    _etaOpacity = CurvedAnimation(
      parent: _sheetController,
      curve: const Interval(0.25, 0.55, curve: Curves.easeOutCubic),
    );
    _statusOpacity = CurvedAnimation(
      parent: _sheetController,
      curve: const Interval(0.4, 0.7, curve: Curves.easeOutCubic),
    );
    _courierOpacity = CurvedAnimation(
      parent: _sheetController,
      curve: const Interval(0.5, 0.85, curve: Curves.easeOutCubic),
    );
    _pinScale = Tween<double>(begin: 0.85, end: 1.35).animate(
      CurvedAnimation(parent: _pinController, curve: Curves.easeInOut),
    );
    _pinOpacity = Tween<double>(begin: 0.55, end: 0.15).animate(
      CurvedAnimation(parent: _pinController, curve: Curves.easeInOut),
    );
    _sheetController.forward().then((_) {
      if (mounted) _progressController.forward();
    });
  }

  @override
  void dispose() {
    _sheetController.dispose();
    _progressController.dispose();
    _pinController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(AppIcons.trackingMapImg),
              fit: .cover,
            ),
          ),
          child: Stack(
            children: [
              Align(
                alignment: const Alignment(0, -0.15),
                child: _buildMapPinWidget(),
              ),
              Align(
                alignment: .bottomCenter,
                child: SlideTransition(
                  position: _sheetOffset,
                  child: Container(
                    padding: .only(bottom: 46, left: 24, right: 24, top: 16),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: .only(topLeft: .circular(20), topRight: .circular(20))
                    ),
                    child: Column(
                      mainAxisAlignment: .end,
                      mainAxisSize: .min,
                      spacing: 15,
                      children: [
                        Container(
                          height: 5,
                          width: 45,
                          decoration: BoxDecoration(
                              color: AppColors.lightWhiteColor,
                              borderRadius: .circular(99)
                          ),
                        ),
                        FadeTransition(
                          opacity: _etaOpacity,
                          child: Column(
                            mainAxisSize: .min,
                            children: [
                              Text('10 minutes left', style: AppTextStyles.btnTextStyle,),
                              RichText(text: TextSpan(
                                  text: 'Delivery to ',
                                  style: AppTextStyles.regularTextStyle.copyWith(fontSize: 12, color: AppColors.greyColor, fontFamily: StringConst.appFontFamily),
                                  children: [
                                    TextSpan(
                                      text: 'Sheraz Ali',
                                      style: AppTextStyles.regularTextStyle.copyWith(fontSize: 12, color: AppColors.blackColor, fontWeight: .w600, fontFamily: StringConst.appFontFamily),
                                    )
                                  ]
                              ))
                            ],
                          ),
                        ),
                        FadeTransition(
                          opacity: _statusOpacity,
                          child: Padding(padding: .only(top: 10), child: Row(
                              spacing: 10,
                              children: List.generate(4, (index) => _buildProgressBar(index: index))
                          ),),
                        ),
                        FadeTransition(
                          opacity: _statusOpacity,
                          child: Material(
                            color: Colors.transparent,
                            child: ListTile(
                              shape: RoundedRectangleBorder(borderRadius: .circular(12),side: BorderSide(color: AppColors.greyColor.withValues(alpha: 0.1))),
                              contentPadding: .symmetric(horizontal: 16),
                              leading: Container(
                                decoration: BoxDecoration(
                                    borderRadius: .circular(12),
                                    border: .all(color: AppColors.greyColor.withValues(alpha: 0.1))
                                ),
                                padding: .all(6),
                                child: Image.asset(AppIcons.icRider, height: 44,),
                              ),
                              title: Text("Delivered your order", style: AppTextStyles.regularTextStyle.copyWith(fontWeight: .w600),),
                              subtitle: Text("We will deliver your goods to you in the shortes possible time.", style: AppTextStyles.regularTextStyle.copyWith(fontSize: 12, color: AppColors.greyColor),),
                            ),
                          ),
                        ),
                        FadeTransition(
                          opacity: _courierOpacity,
                          child: Material(
                            color: Colors.transparent,
                            child: ListTile(
                              contentPadding: .symmetric(horizontal: 16),
                              leading: ClipRRect(
                                borderRadius: .circular(12),
                                child: Image.network(AppIcons.userProfile, height: 56, width: 56, fit: .cover,),
                              ),
                              title: Text("Brooklyn Simmons", style: AppTextStyles.regularTextStyle.copyWith(fontWeight: .w600),),
                              subtitle: Text("Personal Courier", style: AppTextStyles.regularTextStyle.copyWith(fontSize: 12, color: AppColors.greyColor),),
                              trailing: GestureDetector(
                                onTapDown: (_) => setState(() => _isCallPressed = true),
                                onTapUp: (_) => setState(() => _isCallPressed = false),
                                onTapCancel: () => setState(() => _isCallPressed = false),
                                child: AnimatedScale(
                                  scale: _isCallPressed ? 0.85 : 1.0,
                                  duration: const Duration(milliseconds: 120),
                                  curve: Curves.easeOutCubic,
                                  child: SvgPicture.asset(AppIcons.icPhoneCall),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          )
      ),
    );
  }

  Widget _buildMapPinWidget() {
    return SizedBox(
      width: 72,
      height: 72,
      child: Stack(
        alignment: .center,
        children: [
          FadeTransition(
            opacity: _pinOpacity,
            child: ScaleTransition(
              scale: _pinScale,
              child: Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  shape: .circle,
                  color: AppColors.primaryColor.withValues(alpha: 0.35),
                ),
              ),
            ),
          ),
          Container(
            width: 18,
            height: 18,
            decoration: BoxDecoration(
              shape: .circle,
              color: AppColors.primaryColor,
              border: .all(color: Colors.white, width: 3),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primaryColor.withValues(alpha: 0.35),
                  blurRadius: 8,
                  spreadRadius: 1,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressBar({required int index}) {
    final start = 0.05 + index * 0.2;
    final end = (start + 0.22).clamp(0.0, 1.0);
    return Expanded(
      child: AnimatedBuilder(
        animation: _progressController,
        builder: (context, child) {
          final progress = index == 3
              ? 0.0
              : Interval(start, end, curve: Curves.easeOutCubic).transform(_progressController.value);
          return Container(
            height: 4,
            decoration: BoxDecoration(
              color: AppColors.lightWhiteColor,
              borderRadius: .circular(99),
            ),
            clipBehavior: .hardEdge,
            child: Align(
              alignment: .centerLeft,
              child: FractionallySizedBox(
                widthFactor: progress,
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.progressGreenColor,
                    borderRadius: .circular(99),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
