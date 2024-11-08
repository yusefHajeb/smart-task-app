// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class TextInputField extends StatelessWidget {
  const TextInputField({
    super.key,
    this.borderRadius,
    this.keyBoardType = TextInputType.text,
    this.hint,
    this.initialValue,
    this.onChange,
    this.validator,
    this.onSaved,
    this.icon,
    this.blurColor = Colors.grey,
    this.enabled = true,
    this.radius = 14.0,
    this.maxLines = 1,
    this.onTap,
    this.controller,
    this.contentPadding =
        const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
    this.focusColor = Colors.pink,
    this.isPassword = false,
  });
  final BorderRadius? borderRadius;

  final TextInputType keyBoardType;
  final String? hint;
  final String? initialValue;
  final ValueChanged<String>? onChange;
  final FormFieldValidator<String>? validator;
  final FormFieldSetter<String>? onSaved;
  final IconData? icon;
  final Color focusColor, blurColor;
  final bool isPassword, enabled;
  final double radius;
  final int maxLines;
  final void Function()? onTap;
  final TextEditingController? controller;
  final EdgeInsetsGeometry contentPadding;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      initialValue: initialValue,
      obscureText: isPassword,
      onChanged: onChange,
      validator: validator,
      onSaved: onSaved,
      keyboardType: keyBoardType,
      maxLines: maxLines,
      onTap: onTap,
      textAlign: TextAlign.start,
      decoration: InputDecoration(
        prefixIcon: icon != null
            ? Icon(
                icon!,
                color: Colors.black45,
              )
            : null,
        hintText: hint,
        enabled: enabled,
        contentPadding: contentPadding,
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: blurColor,
            width: 1,
          ),
          borderRadius: borderRadius ??
              BorderRadius.all(
                Radius.circular(radius),
              ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: focusColor,
            width: 2,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(radius),
          ),
        ),
      ),
    );
  }
}
