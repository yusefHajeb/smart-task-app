import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_task/core/theme/app_theme_model.dart';

class GlobalThemData {
  static Future<void> initialize() async {
    await ScreenUtil.ensureScreenSize();
    // await ScreenUtil.ensureScreenSizeAndInit(context)
  }

  static const ColorScheme lightColorScheme = ColorScheme(
    primary: Color.fromARGB(255, 54, 131, 255),
    onPrimary: Color.fromARGB(255, 0, 0, 0),
    secondary: Color(0xFFE6EBEB),
    onSecondary: Color(0xFF241E30),
    error: Colors.redAccent,
    inversePrimary: Color.fromARGB(255, 54, 131, 255),
    onSecondaryContainer: Color(0xFF241E30),
    onTertiary: Color(0xFF241E30),
    onTertiaryContainer: Color(0xFF241E30),
    outline: Color(0xFF241E30),
    outlineVariant: Color(0xFF241E30),
    scrim: Color(0xFF241E30),
    shadow: Color(0xFF241E30),
    surfaceTint: Color(0xFF241E30),
    tertiary: Color(0xFF241E30),
    onSurfaceVariant: Color(0xFF241E30),
    onError: Colors.redAccent,
    background: Color(0xFFF5F5F5),
    onBackground: Color(0xFF241E30),
    surface: Color(0xFFF5F5F5),
    onSurface: Color(0xFF241E30),
    brightness: Brightness.light,
  );

  static const ColorScheme darkColorScheme = ColorScheme(
    primary: Color(0xFF4F46E5),
    onPrimary: Colors.white,
    secondary: Color(0xFF241E30),
    onSecondary: Color(0xFFE6EBEB),
    error: Colors.redAccent,
    inversePrimary: Color.fromARGB(255, 244, 247, 252),
    onSecondaryContainer: Color(0xFFE6EBEB),
    onTertiary: Color(0xFFE6EBEB),
    onTertiaryContainer: Color(0xFFE6EBEB),
    outline: Color(0xFFE6EBEB),
    outlineVariant: Color(0xFFE6EBEB),
    scrim: Color(0xFFE6EBEB),
    shadow: Color(0xFFE6EBEB),
    surfaceTint: Color(0xFFE6EBEB),
    tertiary: Color(0xFFE6EBEB),
    onSurfaceVariant: Color(0xFFE6EBEB),
    onError: Colors.white,
    background: Color(0xFF241E30),
    onBackground: Colors.white,
    surface: Color(0xFF241E30),
    onSurface: Colors.white,
    brightness: Brightness.dark,
  );

  static final Color _lightFocusColor = Colors.black.withOpacity(0.12);
  static final Color _darkFocusColor = Colors.white.withOpacity(0.12);
  static ThemeData lightThemeData =
      themeData(lightColorScheme, _lightFocusColor);
  static ThemeData darkThemeData = themeData(darkColorScheme, _darkFocusColor);
  static ThemeData themeDataSelect(ThemeMode mode) =>
      mode == ThemeMode.dark ? darkThemeData : lightThemeData;
  static ThemeData themeData(
    ColorScheme colorScheme,
    Color focusColor,
  ) =>
      ThemeData(
        colorScheme: colorScheme,
        primaryColor: colorScheme.inversePrimary,
        canvasColor: colorScheme.surface,
        scaffoldBackgroundColor: colorScheme.surface,
        highlightColor: Colors.transparent,
        focusColor: focusColor,
        cardColor: colorScheme.surface,
        dialogBackgroundColor: colorScheme.surface,
        indicatorColor: colorScheme.secondary,
        hoverColor: Colors.transparent,
        splashColor: Colors.transparent,
        disabledColor: colorScheme.onSurface.withOpacity(0.4),
        //card
        cardTheme: CardTheme(
          color: colorScheme.surface,
          shadowColor: colorScheme.shadow,
          surfaceTintColor: colorScheme.primary,

          elevation: 0.6,
          // margin: const EdgeInsets.all(16),
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        buttonTheme: ButtonThemeData(
          buttonColor: colorScheme.secondary,
          textTheme: ButtonTextTheme.primary,
          disabledColor: colorScheme.onSecondary.withOpacity(0.4),
          padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 32.w),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
        ),
        snackBarTheme: SnackBarThemeData(
            showCloseIcon: true,
            backgroundColor: colorScheme.onSecondary,
            behavior: SnackBarBehavior.fixed,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            elevation: 0,
            dismissDirection: DismissDirection.horizontal,
            insetPadding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 8.w),
            actionTextColor: colorScheme.onPrimary,
            contentTextStyle:
                AppTextStyles.bodyText.copyWith(color: colorScheme.primary)),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: colorScheme.secondary,
          foregroundColor: colorScheme.onSecondary,
          disabledElevation: 0.0,
          elevation: 0.0,
          focusElevation: 0.0,
          hoverElevation: 0.0,
          highlightElevation: 0.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
        ),
        textTheme: TextTheme(
          displayLarge:
              AppTextStyles.headline6.copyWith(color: colorScheme.onPrimary),
          displayMedium:
              AppTextStyles.headline6.copyWith(color: colorScheme.onPrimary),
          displaySmall:
              AppTextStyles.headline6.copyWith(color: colorScheme.onPrimary),
          labelLarge: AppTextStyles.mediumHeadline
              .copyWith(color: colorScheme.onPrimary),
          labelMedium: AppTextStyles.mediumHeadline
              .copyWith(color: colorScheme.onPrimary),
          labelSmall: AppTextStyles.bodyText.copyWith(
              color: colorScheme.onPrimary,
              fontSize: 12.0.sp,
              letterSpacing: 1.5),
          bodyLarge: AppTextStyles.mediumHeadline.copyWith(
              color: colorScheme.onPrimary,
              letterSpacing: 0.5,
              fontWeight: FontWeight.w600),
          bodyMedium: AppTextStyles.mediumHeadline
              .copyWith(color: colorScheme.onPrimary, letterSpacing: 0.25),
          bodySmall: AppTextStyles.smallBodyText.copyWith(
              color: colorScheme.onPrimary,
              fontSize: 11.0.sp,
              letterSpacing: 0.4),
          headlineLarge: AppTextStyles.largeHeadline.copyWith(
            color: colorScheme.onPrimary,
            letterSpacing: 0.25,
            fontWeight: FontWeight.w600,
          ),
          headlineMedium: AppTextStyles.mediumHeadline.copyWith(
              color: colorScheme.onPrimary,
              fontSize: 20.0.sp,
              fontWeight: FontWeight.w400),
          headlineSmall: AppTextStyles.smallHeadline.copyWith(
              color: colorScheme.onPrimary,
              fontWeight: FontWeight.w400,
              letterSpacing: 0.15),
          titleLarge: AppTextStyles.mediumTitle.copyWith(
              color: colorScheme.onPrimary,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.15),
          titleMedium: AppTextStyles.mediumTitle.copyWith(
              color: colorScheme.onPrimary,
              fontWeight: FontWeight.w400,
              letterSpacing: 0.15),
          titleSmall: AppTextStyles.bodyText.copyWith(
              color: colorScheme.onPrimary,
              fontSize: 12.0.sp,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.1),
        ),
        //icon theme
        iconTheme: IconThemeData(
          color: colorScheme.onPrimary,
          size: 24.sp,
          opacity: 0.8,
          weight: const Icon(Icons.add).weight,
        ),
        //button style
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            elevation: 2.0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0.r)),
            minimumSize: Size(double.infinity, 38.0.h),
            shadowColor: colorScheme.shadow,
            backgroundColor: colorScheme.primary,
            disabledBackgroundColor: colorScheme.primary.withOpacity(0.4),
            disabledForegroundColor: Colors.grey,
            padding: EdgeInsets.symmetric(horizontal: 20.0.w, vertical: 16.0.h),
            textStyle: AppTextStyles.bodyText
                .copyWith(color: colorScheme.onPrimaryContainer),
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            elevation: 2.0,
            minimumSize: Size(double.infinity, 50.0.h),
            shadowColor: colorScheme.primaryContainer,
            side: BorderSide(color: colorScheme.secondary, width: 1.5),
            disabledForegroundColor: Colors.grey,
            foregroundColor: colorScheme.primary,
            textStyle:
                AppTextStyles.bodyText.copyWith(color: colorScheme.onPrimary),
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0.r),
            ),
          ).copyWith(
            backgroundColor: MaterialStateProperty.resolveWith<Color>(
              (Set<MaterialState> states) {
                if (states.contains(MaterialState.pressed))
                  return colorScheme.primary.withOpacity(0.5);
                return colorScheme.surface; // Default Color
              },
            ),
            overlayColor: MaterialStateProperty.all(
                colorScheme.primary.withOpacity(0.1)), // Ripple color
            animationDuration: Duration(milliseconds: 200),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          focusColor: colorScheme.primary,
          hoverColor: colorScheme.primary,
          labelStyle: AppTextStyles.bodyText,
          helperStyle: AppTextStyles.bodyText,
          counterStyle:
              TextStyle(color: Colors.grey.withOpacity(0.9), fontSize: 12.0.sp),
          filled: true,
          hintStyle: AppTextStyles.bodyText
              .copyWith(color: Colors.grey.withOpacity(0.9)),
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          border: OutlineInputBorder(
            borderSide:
                BorderSide(color: Colors.grey.withOpacity(0.4), width: 1.0.sp),
            borderRadius: BorderRadius.all(Radius.circular(14.r)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: colorScheme.primary, width: 1.0.sp),
            borderRadius: BorderRadius.all(Radius.circular(14.r)),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: Colors.grey.withOpacity(0.4), width: 1.0.sp),
            borderRadius: BorderRadius.all(Radius.circular(14.r)),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: colorScheme.error, width: 1.0.sp),
            borderRadius: BorderRadius.all(Radius.circular(14.r)),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: colorScheme.onError, width: 2.0.sp),
            borderRadius: BorderRadius.all(Radius.circular(14.r)),
          ),
        ),
        appBarTheme: AppBarTheme(
          actionsIconTheme: IconThemeData(color: colorScheme.onPrimary),
          iconTheme: IconThemeData(
            color: colorScheme.onPrimary,
            size: 24.sp,
            opacity: 0.8.sp,
            weight: const Icon(Icons.add).weight,
          ),
          shadowColor: Colors.transparent,
          elevation: 0.0,
          centerTitle: true,
          color: colorScheme.secondary,
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: colorScheme.brightness == Brightness.dark
                ? Brightness.light
                : Brightness.dark,
            statusBarBrightness: colorScheme.brightness == Brightness.dark
                ? Brightness.light
                : Brightness.dark,
          ),
        ),
      );
  // static ThemeData themeData(ColorScheme colorScheme, Color focusColor) {
  //   return ThemeData(
  //       textTheme: TextTheme(
  //         displayLarge: AppTextStyles.headline6,
  //         displayMedium: AppTextStyles.headline6,
  //         displaySmall: AppTextStyles.headline6,
  //         labelLarge: AppTextStyles.mediumHeadline,
  //         labelMedium: AppTextStyles.mediumHeadline,
  //         labelSmall: AppTextStyles.bodyText
  //             .copyWith(fontSize: 12.0, letterSpacing: 1.5),
  //         bodyLarge: AppTextStyles.mediumHeadline.copyWith(
  //             letterSpacing: 0.5,
  //             color: Colors.grey[600],
  //             fontWeight: FontWeight.w600),
  //         bodyMedium:
  //             AppTextStyles.mediumHeadline.copyWith(letterSpacing: 0.25),
  //         bodySmall: AppTextStyles.smallBodyText
  //             .copyWith(fontSize: 12.0, letterSpacing: 0.4),
  //         headlineLarge: AppTextStyles.largeHeadline.copyWith(
  //           letterSpacing: 0.25,
  //           color: Colors.grey[600],
  //           fontWeight: FontWeight.w600,
  //         ),
  //         headlineMedium: AppTextStyles.mediumHeadline
  //             .copyWith(fontSize: 20.0, fontWeight: FontWeight.w400),
  //         headlineSmall: AppTextStyles.smallHeadline
  //             .copyWith(fontWeight: FontWeight.w400, letterSpacing: 0.15),
  //         titleLarge: AppTextStyles.mediumTitle.copyWith(
  //             fontWeight: FontWeight.w500,
  //             letterSpacing: 0.15,
  //             color: Colors.grey[600]),
  //         titleMedium: AppTextStyles.mediumTitle
  //             .copyWith(fontWeight: FontWeight.w400, letterSpacing: 0.15),
  //         titleSmall: AppTextStyles.bodyText.copyWith(
  //             fontSize: 14.0, fontWeight: FontWeight.w500, letterSpacing: 0.1),
  //       ),
  //       //button style :
  //       elevatedButtonTheme: ElevatedButtonThemeData(
  //         style: ElevatedButton.styleFrom(
  //           elevation: 8.0,
  //           shape: RoundedRectangleBorder(
  //               borderRadius: BorderRadius.circular(30.0)),
  //           minimumSize: const Size(double.infinity, 56.0),
  //           shadowColor: colorScheme.primaryContainer,
  //           backgroundColor: colorScheme.primary,
  //           disabledBackgroundColor: colorScheme.primary.withOpacity(0.4),
  //           disabledForegroundColor: Colors.grey,
  //           padding:
  //               const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
  //           textStyle: TextStyle(
  //               fontSize: 16.0,
  //               fontWeight: FontWeight.bold,
  //               color: colorScheme.secondary),
  //         ),
  //       ),
  //       outlinedButtonTheme: OutlinedButtonThemeData(
  //         style: OutlinedButton.styleFrom(
  //           elevation: 8.0,
  //           minimumSize: const Size(double.infinity, 56.0),
  //           shadowColor: colorScheme.primaryContainer,
  //           side: BorderSide(color: colorScheme.secondary, width: 1.5),
  //           disabledForegroundColor: Colors.grey,
  //           foregroundColor: colorScheme.primary,
  //           textStyle: TextStyle(
  //               fontSize: 16.0,
  //               fontWeight: FontWeight.bold,
  //               color: colorScheme.secondary),
  //           padding:
  //               const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
  //           shape: RoundedRectangleBorder(
  //               borderRadius: BorderRadius.circular(10.0)),
  //         ),
  //       ),
  //       inputDecorationTheme: InputDecorationTheme(
  //         filled: true,
  //         hintStyle: TextStyle(color: Colors.grey.withOpacity(0.4)),
  //         floatingLabelBehavior: FloatingLabelBehavior.auto,
  //         border: OutlineInputBorder(
  //           borderSide:
  //               BorderSide(color: Colors.grey.withOpacity(0.4), width: 1.0),
  //           borderRadius: const BorderRadius.all(Radius.circular(14)),
  //         ),
  //         focusedBorder: OutlineInputBorder(
  //           borderSide: BorderSide(color: colorScheme.primary, width: 1.0),
  //           borderRadius: const BorderRadius.all(Radius.circular(14)),
  //         ),
  //         enabledBorder: OutlineInputBorder(
  //           borderSide:
  //               BorderSide(color: Colors.grey.withOpacity(0.4), width: 1.0),
  //           borderRadius: const BorderRadius.all(Radius.circular(14)),
  //         ),
  //         errorBorder: OutlineInputBorder(
  //           borderSide: BorderSide(color: colorScheme.error, width: 1.0),
  //           borderRadius: const BorderRadius.all(Radius.circular(14)),
  //         ),
  //         focusedErrorBorder: OutlineInputBorder(
  //           borderSide: BorderSide(color: colorScheme.onError, width: 2.0),
  //           borderRadius: const BorderRadius.all(Radius.circular(14)),
  //         ),
  //       ),
  //       colorScheme: colorScheme,
  //       primaryColor: colorScheme.primary,
  //       appBarTheme: AppBarTheme(
  //         shadowColor: Colors.transparent,
  //         elevation: 0.0,
  //         centerTitle: true,
  //         color: colorScheme.secondary,
  //         systemOverlayStyle: const SystemUiOverlayStyle(
  //           statusBarColor: Colors.transparent,
  //           statusBarIconBrightness: Brightness.light,
  //           statusBarBrightness: Brightness.dark,
  //         ),
  //       ),
  //       canvasColor: colorScheme.background,
  //       scaffoldBackgroundColor: colorScheme.background,
  //       highlightColor: Colors.transparent,
  //       focusColor: focusColor);
  // }
}

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
          padding: EdgeInsets.all(16.r),
          textStyle:
              const TextStyle(fontSize: 20.0, fontWeight: FontWeight.w500),
        ),
      ),
      segmentedButtonTheme: SegmentedButtonThemeData(
        style: SegmentedButton.styleFrom(
          padding: const EdgeInsets.all(16),
          textStyle: const TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
