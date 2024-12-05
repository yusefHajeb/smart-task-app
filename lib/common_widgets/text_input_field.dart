// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class TextInputField extends StatefulWidget {
  const TextInputField({
    super.key,
    this.borderRadius,
    this.keyBoardType = TextInputType.text,
    this.hint,
    required this.initialValue,
    this.onChange,
    this.validator,
    this.onSaved,
    this.icon,
    this.enabled = true,
    this.radius = 14.0,
    this.maxLines,
    this.readOnly = false,
    this.onTap,
    this.controller,
    this.contentPadding =
        const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
    this.isPassword = false,
  });
  final BorderRadius? borderRadius;

  final TextInputType keyBoardType;
  final String? hint;
  final String initialValue;
  final ValueChanged<String>? onChange;
  final FormFieldValidator<String>? validator;
  final FormFieldSetter<String>? onSaved;
  final IconData? icon;

  final bool isPassword, enabled, readOnly;
  final double radius;
  final int? maxLines;
  final void Function()? onTap;
  final TextEditingController? controller;
  final EdgeInsetsGeometry contentPadding;

  @override
  State<TextInputField> createState() => _TextInputFieldState();
}

class _TextInputFieldState extends State<TextInputField> {
  late TextEditingController _textEditingController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _textEditingController =
        TextEditingController(text: widget.controller?.text);
  }

  @override
  void dispose() {
    super.dispose();
    _textEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _textEditingController,
      obscureText: widget.isPassword,
      onChanged: widget.onChange,
      validator: widget.validator,
      onSaved: widget.onSaved,
      readOnly: widget.readOnly,
      keyboardType: widget.keyBoardType,
      maxLines: widget.maxLines,
      onTap: widget.onTap,
      textAlign: TextAlign.start,
      decoration: InputDecoration(
        prefixIcon: widget.icon != null
            ? Icon(
                widget.icon!,
              )
            : null,
        hintText: widget.hint,
        enabled: widget.enabled,
        contentPadding: widget.contentPadding,
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
      ),
    );
  }
}
