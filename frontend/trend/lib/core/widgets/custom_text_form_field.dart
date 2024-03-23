import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    Key? key,
    this.labelText,
    this.hintText,
    this.onChange,
    this.prefixIcon,
    this.suffixIcon,
    this.controller,
    this.initialValue,
    this.minLines,
    this.maxLines = 1,
    this.validator,
    this.obscureText = false,
    this.textInputAction,
    this.keyboardType,
    this.maxLength,
    this.onFieldSubmitted,
    this.inputFormatters,
    this.enabled = true,
    this.onTap,
    this.enableInteractiveSelection,
    this.showCursor,
    this.mouseCursor,
    this.onTapOutside,
    this.decoration,
    this.focusNode,
    this.style,
    this.suffix,
    this.hintStyle,
    this.labelStyle,
    this.textAlign = TextAlign.start,
    this.readOnly = false,
  }) : super(key: key);

  final String? labelText;
  final String? hintText;
  final Function(String)? onChange;
  final Function(String)? onFieldSubmitted;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool obscureText;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final String? initialValue;
  final int? maxLines;
  final int? minLines;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final int? maxLength;
  final List<TextInputFormatter>? inputFormatters;
  final bool enabled;
  final VoidCallback? onTap;
  final bool? enableInteractiveSelection;
  final bool? showCursor;
  final bool readOnly;
  final MouseCursor? mouseCursor;
  final Function(PointerDownEvent)? onTapOutside;
  final TextAlign textAlign;
  final InputDecoration? decoration;
  final FocusNode? focusNode;
  final TextStyle? style;
  final TextStyle? hintStyle;
  final TextStyle? labelStyle;
  final Widget? suffix;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: focusNode,
      onChanged: onChange,
      decoration: decoration ??
          InputDecoration(
              labelStyle: labelStyle,
              hintStyle: hintStyle,
              labelText: labelText,
              hintText: hintText,
              prefixIcon: prefixIcon,
              suffixIcon: suffixIcon,
              alignLabelWithHint: false,
              suffix: suffix,
              suffixStyle: TextStyle(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
                fontSize: 16.sp,
              )),
      style: style ??
          TextStyle(
              fontSize: 15.sp,
              color: Theme.of(context).textTheme.displayLarge?.color),
      obscureText: obscureText,
      validator: validator,
      controller: controller,
      initialValue: initialValue,
      maxLines: maxLines,
      minLines: minLines,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      maxLength: maxLength,
      onFieldSubmitted: onFieldSubmitted,
      inputFormatters: inputFormatters,
      enabled: enabled,
      onTap: onTap,
      enableInteractiveSelection: enableInteractiveSelection,
      showCursor: showCursor,
      readOnly: readOnly,
      mouseCursor: mouseCursor,
      onTapOutside: onTapOutside,
      textAlign: textAlign,
      cursorColor: Theme.of(context).primaryColor,
    );
  }
}
