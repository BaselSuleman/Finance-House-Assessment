import 'package:finance_house_assessment/core/utils/extentions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/failures/field_failure/field_failure.dart';


class CustomFormField extends StatefulWidget {
  const CustomFormField({
    super.key,
    required this.hintText,
    this.title,
    this.titleStyle,
    this.textStyle,
    this.initValue,
    this.prefixIcon,
    this.suffixIcon,
    this.isPassword = false,
    this.keyboardType = TextInputType.text,
    this.controller,
    this.validator,
    this.autoValidate = true,
    this.onChange,
    this.onTap,
    this.textInputAction,
    this.fillColor,
    this.suffixText,
    this.readOnly = false,
    this.hintStyle,
    this.maxLines = 1,
    this.inputFormatters,
    this.maxLength,
    this.enable = true,
    this.focusNode,
    this.onFieldSubmitted,
    this.isRequired = false,
    this.direction,
    this.padding,
    this.boarderColor,
    this.prefixIconConstraints,
    this.suffixIconConstraints,
    this.enabledBorder,
    this.focusedBorder,
    this.errorBorder,
    this.contentPadding,
  });

  final bool autoValidate;
  final int maxLines;
  final String? initValue;
  final String hintText;
  final String? title;
  final TextStyle? titleStyle;
  final Widget? suffixIcon;
  final String? suffixText;
  final Widget? prefixIcon;
  final BoxConstraints? prefixIconConstraints;
  final BoxConstraints? suffixIconConstraints;
  final TextInputType keyboardType;
  final TextEditingController? controller;
  final Function(String)? onChange;
  final Function(String)? onFieldSubmitted;
  final FieldFailure? Function(String)? validator;
  final bool isPassword;
  final Function()? onTap;
  final bool readOnly;
  final Color? fillColor;
  final TextInputAction? textInputAction;
  final TextStyle? hintStyle;
  final TextStyle? textStyle;
  final List<TextInputFormatter>? inputFormatters;
  final int? maxLength;
  final bool? enable;
  final FocusNode? focusNode;
  final bool isRequired;
  final EdgeInsetsGeometry? padding;
  final Color? boarderColor;
  final InputBorder? errorBorder;
  final InputBorder? enabledBorder;
  final InputBorder? focusedBorder;
  final EdgeInsetsGeometry? contentPadding;
  final TextDirection? direction;

  @override
  State<CustomFormField> createState() => _CustomFormFieldState();
}

class _CustomFormFieldState extends State<CustomFormField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.padding ?? EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.title != null) ...[
            Padding(
              padding: EdgeInsets.only(bottom: 8.h),
              child: RichText(
                text: TextSpan(
                  text: widget.title,
                  style: widget.titleStyle ??
                      TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 14.sp,
                      ),
                  children: widget.isRequired
                      ? [
                          TextSpan(
                            text: "*",
                            style:
                                TextStyle(color: Colors.red, fontSize: 16.sp),
                          ),
                        ]
                      : [],
                ),
              ),
            ),
          ],
          Directionality(
            textDirection: widget.direction != null
                ? widget.direction!
                : context.isArabic
                    ? TextDirection.rtl
                    : TextDirection.ltr,
            child: TextFormField(
              onFieldSubmitted: widget.onFieldSubmitted,
              initialValue: widget.initValue,
              onTap: widget.onTap,
              enabled: widget.enable,
              focusNode: widget.focusNode,
              maxLines: widget.maxLines,
              validator: (widget.isRequired == true)
                  ? widget.validator != null
                      ? (value) {
                          return context.fieldFailureParser(
                              widget.validator!(value ?? ''));
                        }
                      : null
                  : null,
              readOnly: widget.readOnly,
              onChanged: widget.onChange,
              keyboardType: widget.keyboardType,
              controller: widget.controller,
              autovalidateMode: widget.autoValidate
                  ? AutovalidateMode.always
                  : AutovalidateMode.disabled,
              obscureText: widget.isPassword,
              inputFormatters: widget.inputFormatters,
              maxLength: widget.maxLength,
              style: widget.textStyle ??
                  TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
              decoration: InputDecoration(
                hintText: widget.hintText,
                hintStyle: widget.hintStyle ?? context.textTheme.bodySmall,
                fillColor: widget.fillColor,
                suffixText: widget.suffixText,
                suffixIcon: widget.suffixIcon,
                prefixIcon: widget.prefixIcon,
                errorMaxLines: 3,
                suffixIconConstraints: widget.suffixIconConstraints ??
                    BoxConstraints(maxWidth: 30.w),
                prefixIconConstraints: widget.prefixIconConstraints ??
                    BoxConstraints(maxWidth: 10.w),
                disabledBorder: widget.focusedBorder ??
                    UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: widget.boarderColor ??
                              HexColor.fromHex("#2EB9CC"),
                          width: 2),
                    ),
                enabledBorder: widget.enabledBorder ??
                    UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: widget.boarderColor ??
                              HexColor.fromHex("#E1E1E1"),
                          width: 1.5),
                    ),
                focusedBorder: widget.focusedBorder ??
                    UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: widget.boarderColor ??
                              HexColor.fromHex("#2EB9CC"),
                          width: 2),
                    ),
                errorBorder: widget.errorBorder ??
                    UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.red, width: 2),
                    ),
                focusedErrorBorder: widget.errorBorder ??
                    UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.red, width: 2),
                    ),
                contentPadding: widget.contentPadding ??
                    EdgeInsets.symmetric(horizontal: 14.w, vertical: 11),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
