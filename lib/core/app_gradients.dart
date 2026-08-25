import 'package:flutter/cupertino.dart';
import 'app_colors.dart';

class AppGradients {
  static LinearGradient get blackSmokeGradient => LinearGradient(
      colors: [
        AppColors.gradientBlackColor1,
        AppColors.gradientBlackColor2,
      ],
      stops: [
        0.0,
        1.0
      ],
      begin: .topLeft,
      end: .topRight
  );
}