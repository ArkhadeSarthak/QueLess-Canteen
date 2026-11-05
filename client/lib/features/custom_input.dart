import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:queue_less/theme/app_colors.dart';

class CustomInput extends StatelessWidget {
  final TextEditingController? controller;
  final AutovalidateMode? autovalidateMode;
  final ValueChanged<String>? onSubmit;
  final double? fontsize;
  final Color? color;
  final bool? enabled;
  final Color? backColor;
  final IconData? prefixIcon;
  final String? hintText;
  final double? borderRadius;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;
  final bool? obsecure;
  final ValueChanged<String>? onChanged;
  final int? maxLength;
  final int? maxLines;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? formatter;
  final FocusNode? focusNode;
  const CustomInput({
    super.key,
    this.controller,
    this.autovalidateMode,
    this.onSubmit,
    this.fontsize,
    this.color,
    this.enabled,
    this.backColor,
    this.prefixIcon,
    this.hintText,
    this.validator,
    this.borderRadius,
    this.suffixIcon,
    this.obsecure,
    this.onChanged,
    this.maxLength,
    this.maxLines,
    this.keyboardType,
    this.formatter,
    this.focusNode
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      autovalidateMode: autovalidateMode ?? AutovalidateMode.onUserInteraction,
      focusNode: focusNode,
      onFieldSubmitted: onSubmit,
      onChanged: onChanged,
      obscureText: obsecure ?? false,
      style: GoogleFonts.outfit(
        fontSize: fontsize ?? 14,
        fontWeight: FontWeight.w500,
        color: color ?? AppColors.darkGreen,
      ),
      keyboardType: keyboardType,
      inputFormatters: formatter,
      maxLength: maxLength,
      maxLines: maxLines,
      decoration: InputDecoration(
        enabled: enabled ?? true,
        filled: true,
        fillColor: backColor ?? AppColors.white,
        isDense: true,
        border: OutlineInputBorder(
          borderSide: BorderSide(color: backColor ?? AppColors.white),
          borderRadius: BorderRadius.circular(borderRadius ?? 10),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: backColor ?? AppColors.white),
          borderRadius: BorderRadius.circular(borderRadius ?? 10),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: backColor ?? AppColors.white),
          borderRadius: BorderRadius.circular(borderRadius ?? 10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: backColor ?? AppColors.white),
          borderRadius: BorderRadius.circular(borderRadius ?? 10),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: backColor ?? AppColors.white),
          borderRadius: BorderRadius.circular(borderRadius ?? 10),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: backColor ?? AppColors.white),
          borderRadius: BorderRadius.circular(borderRadius ?? 10),
        ),
        prefixIcon: prefixIcon != null
            ? Icon(prefixIcon, color: AppColors.secondaryGreen, size: 18)
            : null,
        hintText: hintText ?? "",
        hintStyle: GoogleFonts.outfit(
          color: color ?? AppColors.darkGreen,
          fontSize: fontsize ?? 12,
        ),
        suffixIcon: suffixIcon,
        counterText: "",
      ),
      validator: validator,
    );
  }
}
