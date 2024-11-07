import 'package:flutter/material.dart';

class Sizes {
  static const p4 = 4.0;
  static const p8 = 8.0;
  static const p12 = 12.0;
  static const p16 = 16.0;
  static const p20 = 20.0;
  static const p24 = 24.0;
  static const p32 = 32.0;
  static const p40 = 40.0;
  static const p48 = 48.0;
  static const p64 = 64.0;
}

class AppSize {
  static SizedBox h16() => const SizedBox(height: Sizes.p16);
  static SizedBox h24() => const SizedBox(height: Sizes.p24);
  static SizedBox h32() => const SizedBox(height: Sizes.p32);
  static SizedBox h40() => const SizedBox(height: Sizes.p40);
  static SizedBox h48() => const SizedBox(height: Sizes.p48);
  static SizedBox h64() => const SizedBox(height: Sizes.p64);
  static SizedBox w16() => const SizedBox(width: Sizes.p16);
  static SizedBox w24() => const SizedBox(width: Sizes.p24);
  static SizedBox w32() => const SizedBox(width: Sizes.p32);
  static SizedBox w40() => const SizedBox(width: Sizes.p40);
  static SizedBox w48() => const SizedBox(width: Sizes.p48);
  static SizedBox w64() => const SizedBox(width: Sizes.p64);
}
