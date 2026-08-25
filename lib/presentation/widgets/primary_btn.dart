import 'package:flutter/material.dart';
import '../../core/app_colors.dart';
import '../../core/app_textstyles.dart';

class PrimaryBtn extends StatelessWidget {
  const PrimaryBtn({
    super.key,
    required this.btnText,
    this.onTap
  });
  final String btnText;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap ?? (){},
      style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryColor,
          shape: RoundedRectangleBorder(borderRadius: .circular(16)),
          padding: .symmetric(vertical: 16)
      ),
      child: Text(btnText, style: AppTextStyles.btnTextStyle.copyWith(color: Colors.white)),
    );
  }
}