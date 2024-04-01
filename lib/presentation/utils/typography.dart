import 'package:flutter/material.dart';

import 'package:github_api/presentation/utils/colors.dart';

class AppFontFamily {
  AppFontFamily._();

  static const raleway = 'Raleway';
}

class AppFontWeight {
  AppFontWeight._();

  static const regular = FontWeight.w400;
  static const semiBold = FontWeight.w600;
}

class AppFontSize {
  AppFontSize._();

  static const font_size_14 = 14.0;
  static const font_size_16 = 16.0;
}

class AppLineHeight {
  AppLineHeight._();

  static const line_height_19 = 19.0;
  static const line_height_20 = 20.0;
}

class AppTextStyle extends TextStyle {
  const AppTextStyle.header({Color? color})
      : super(
          color: color ?? AppColors.primaryTextColor,
          fontFamily: AppFontFamily.raleway,
          fontWeight: AppFontWeight.semiBold,
          fontSize: AppFontSize.font_size_16,
        );

  const AppTextStyle.body({Color? color})
      : super(
          color: color ?? AppColors.primaryTextColor,
          fontFamily: AppFontFamily.raleway,
          fontWeight: AppFontWeight.regular,
          fontSize: AppFontSize.font_size_14,
        );
}
