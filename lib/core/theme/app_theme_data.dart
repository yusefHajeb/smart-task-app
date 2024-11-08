import 'package:flutter/material.dart';
import 'package:smart_task/core/constant/size.dart';

extension AppThemeData on ThemeData {
  // static ThemeData light() =>
  //     FlexThemeData.light(scheme: AppColors.background)._customAppTheme();

  // static ThemeData dark() =>
  //     FlexThemeData.dark(scheme: AppColors.background)._customAppTheme();

  ThemeData _customAppTheme() {
    // An updated theme with bigger text sizes
    return copyWith(
      textTheme: TextTheme(
        headlineLarge: textTheme.headlineLarge?.copyWith(fontSize: 32.0),
        headlineMedium: textTheme.headlineMedium?.copyWith(fontSize: 28.0),
        headlineSmall: textTheme.headlineSmall?.copyWith(fontSize: 24.0),
        titleLarge: textTheme.titleLarge?.copyWith(fontSize: 22.0),
        titleMedium: textTheme.titleMedium?.copyWith(fontSize: 18.0),
        titleSmall: textTheme.titleMedium?.copyWith(fontSize: 14.0),
        bodyLarge: textTheme.bodyLarge?.copyWith(fontSize: 20.0),
        bodyMedium: textTheme.bodyMedium?.copyWith(fontSize: 18.0),
        bodySmall: textTheme.bodySmall?.copyWith(fontSize: 14.0),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.all(Sizes.p16),
          textStyle:
              const TextStyle(fontSize: 20.0, fontWeight: FontWeight.w500),
        ),
      ),
      segmentedButtonTheme: SegmentedButtonThemeData(
        style: SegmentedButton.styleFrom(
          padding: const EdgeInsets.all(Sizes.p16),
          textStyle: const TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
