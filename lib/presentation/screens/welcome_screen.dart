import 'package:coffee_app/core/app_colors.dart';
import 'package:coffee_app/core/app_icons.dart';
import 'package:coffee_app/core/app_textstyles.dart';
import 'package:coffee_app/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../widgets/primary_btn.dart';

class WelcomeScreen extends StatefulWidget{
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> with TickerProviderStateMixin {
  late final AnimationController _imageController;
  late final AnimationController _contentController;
  late final Animation<double> _imageScale;
  late final Animation<double> _headlineOpacity;
  late final Animation<Offset> _headlineOffset;
  late final Animation<double> _subtitleOpacity;
  late final Animation<Offset> _subtitleOffset;
  late final Animation<double> _buttonOpacity;
  late final Animation<Offset> _buttonOffset;

  @override
  void initState() {
    super.initState();
    _imageController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 12),
    )..repeat(reverse: true);
    _imageScale = Tween<double>(begin: 1.0, end: 1.08).animate(
      CurvedAnimation(parent: _imageController, curve: Curves.easeInOut),
    );
    _contentController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );
    _headlineOpacity = CurvedAnimation(
      parent: _contentController,
      curve: const Interval(0.0, 0.45, curve: Curves.easeOutCubic),
    );
    _headlineOffset = Tween<Offset>(begin: const Offset(0, 0.16), end: .zero).animate(
      CurvedAnimation(
        parent: _contentController,
        curve: const Interval(0.0, 0.45, curve: Curves.easeOutCubic),
      ),
    );
    _subtitleOpacity = CurvedAnimation(
      parent: _contentController,
      curve: const Interval(0.15, 0.6, curve: Curves.easeOutCubic),
    );
    _subtitleOffset = Tween<Offset>(begin: const Offset(0, 0.16), end: .zero).animate(
      CurvedAnimation(
        parent: _contentController,
        curve: const Interval(0.15, 0.6, curve: Curves.easeOutCubic),
      ),
    );
    _buttonOpacity = CurvedAnimation(
      parent: _contentController,
      curve: const Interval(0.3, 0.85, curve: Curves.easeOutCubic),
    );
    _buttonOffset = Tween<Offset>(begin: const Offset(0, 0.16), end: .zero).animate(
      CurvedAnimation(
        parent: _contentController,
        curve: const Interval(0.3, 0.85, curve: Curves.easeOutCubic),
      ),
    );
    _contentController.forward();
  }

  @override
  void dispose() {
    _imageController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.blackColor,
        body: Column(
      children: [
        Expanded(child: ClipRect(
          child: ScaleTransition(
            scale: _imageScale,
            child: Image.asset(AppIcons.welcomeImg, fit: .cover, width: .infinity, height: .infinity,),
          ),
        )),
        SafeArea(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [
                    AppColors.blackColor.withValues(alpha: 0.0),
                    AppColors.blackColor
                  ],
                  stops: [
                    0.0,
                    1.0
                  ],
                begin: .topCenter,
                end: .bottomCenter
              ),
              color: AppColors.blackColor
            ),
            padding: .symmetric(horizontal: 24),
            child: Column(
              mainAxisAlignment: .end,
              spacing: 32,
              children: [
                Column(
                  spacing: 8,
                  children: [
                    _buildFadeSlideWidget(
                      opacity: _headlineOpacity,
                      position: _headlineOffset,
                      child: Text("Fall in Love with Coffee in Blissful Delight!", style: AppTextStyles.headingTextStyle.copyWith(color: Colors.white), textAlign: .center,),
                    ),
                    _buildFadeSlideWidget(
                      opacity: _subtitleOpacity,
                      position: _subtitleOffset,
                      child: Text("Welcome to our cozy coffee corner, where every cup is a delightful for you.", style: AppTextStyles.regularTextStyle.copyWith(color: AppColors.greyColor),textAlign: .center,),
                    )
                  ],
                ),
                SizedBox(
                  width: .infinity,
                  child: _buildFadeSlideWidget(
                    opacity: _buttonOpacity,
                    position: _buttonOffset,
                    child: PrimaryBtn(btnText: 'Get Started', onTap: ()=> context.push(NamedRoutes.home.routeName),),
                  ),
                )
              ],
            ),
          ),
        )
      ],
    ));
  }

  Widget _buildFadeSlideWidget({required Animation<double> opacity, required Animation<Offset> position, required Widget child}) {
    return FadeTransition(
      opacity: opacity,
      child: SlideTransition(
        position: position,
        child: child,
      ),
    );
  }
}
