import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTextStyles {
  static const String defaultFontFamily = "Almarai";

  /// The style for the body text.
  static TextStyle get bodyText => _baseStyle.copyWith(
        fontSize: 12.sp,
        fontWeight: FontWeight.w500,
      );

  /// The style for the large body text.
  static TextStyle get largeBodyText => _baseStyle.copyWith(
        fontSize: 24.sp,
        fontWeight: FontWeight.w700,
      );

  /// The style for the small body text.
  static TextStyle get smallBodyText => _baseStyle.copyWith(
        fontSize: 13.sp,
        fontWeight: FontWeight.w400,
      );

  /// The style for the heading 1.
  static TextStyle get heading1 => _baseStyle.copyWith(
        fontSize: 24.sp,
        fontWeight: FontWeight.w300,
      );

  /// The style for the heading 2.
  static TextStyle get heading2 => _baseStyle.copyWith(
        fontSize: 20.sp,
        fontWeight: FontWeight.w400,
      );

  /// The style for the heading 3.
  static TextStyle get heading3 => _baseStyle.copyWith(
        fontSize: 20.sp,
        fontWeight: FontWeight.w300,
      );

  /// The style for the small headline.
  static TextStyle get smallHeadline => _baseStyle.copyWith(
        fontSize: 14.sp,
        fontWeight: FontWeight.w600,
      );

  /// The style for the medium title.
  static TextStyle get mediumTitle => _baseStyle.copyWith(
        fontSize: 14.sp,
        fontWeight: FontWeight.w600,
      );

  /// The style for the medium headline.
  static TextStyle get mediumHeadline => _baseStyle.copyWith(
        fontSize: 16.sp,
        fontWeight: FontWeight.w500,
      );

  /// The style for the large headline.
  static TextStyle get largeHeadline => _baseStyle.copyWith(
        fontSize: 20.sp,
        fontWeight: FontWeight.w700,
      );

  /// The style for the headline 6.
  static TextStyle get headline6 => _baseStyle.copyWith(
        fontSize: 16.sp,
        fontWeight: FontWeight.w500,
      );

  /// The style for the button text.
  static TextStyle get buttonText => _baseStyle.copyWith(
        fontSize: 16.sp,
        fontWeight: FontWeight.w600,
      );

  /// The base style for all text styles.
  static TextStyle get _baseStyle => TextStyle(
        fontSize: 12.sp,
        fontWeight: FontWeight.w500,
        fontFamily: defaultFontFamily,
      );

  /// The style for the label text.
}
