import 'package:flutter/material.dart';

// Theme
import 'package:mandado_express_dev/theme/colors.dart';

class CustomTheme {

  ThemeData customTheme;

  CustomTheme() {
    this.customTheme = ThemeData.light().copyWith(
      primaryColor: CustomColors.primary,
      accentColor: CustomColors.accent,
      primaryColorLight: CustomColors.primaryLight,
      scaffoldBackgroundColor: Colors.white,
    );
  }

}