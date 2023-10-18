import 'package:flutter/material.dart';
import '../../constant/app_color.dart';

class TableTextFormFieldWidget extends StatelessWidget {
  const TableTextFormFieldWidget(
      {Key? key,
      required this.controller,
      required this.hintText,
      this.required = false,
      this.textInputType,
      this.textCapitalization,
      this.textAlign = TextAlign.left,
      this.maxLine,
      this.minLine,
      this.maxLength,
      this.readOnly=false,
      this.onChanged,
      this.onEditingComplete,
      this.contentPadding,
      this.focusNode, this.onTap})
      : super(key: key);

  final TextEditingController controller;
  final String hintText;
  final TextInputType? textInputType;
  final TextCapitalization? textCapitalization;
  final TextAlign? textAlign;
  final bool required;
  final int? maxLine;
  final int? minLine;
  final int? maxLength;
  final bool readOnly;
  final Function(String)? onChanged;
  final Function()? onEditingComplete;
  final FocusNode? focusNode;
  final EdgeInsetsGeometry? contentPadding;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (val) => !required || val != null && val.isNotEmpty
          ? null
          : "$hintText can't be empty",
      controller: controller,
      focusNode: focusNode,
      onChanged: (val) {
        if (onChanged != null) {
          onChanged!(val);
        }
      },
      maxLength: maxLength,
      onEditingComplete: onEditingComplete,
      keyboardType: textInputType ?? TextInputType.text,
      textCapitalization: textCapitalization ?? TextCapitalization.none,
      maxLines: maxLine ?? 1,
      minLines: minLine ?? 1,
      textAlign: textAlign!,
      readOnly: readOnly,
      onTap: onTap,
      style: TextStyle(
          color: AppColor.textColor, fontWeight: FontWeight.w500, fontSize: 14),
      decoration: InputDecoration(
        alignLabelWithHint: true,
        border: const OutlineInputBorder(borderSide: BorderSide.none),
        enabledBorder: const OutlineInputBorder(borderSide: BorderSide.none),
        focusedBorder: const OutlineInputBorder(borderSide: BorderSide.none),
        errorBorder: const OutlineInputBorder(borderSide: BorderSide.none),
        isDense: true,
        contentPadding: contentPadding ?? const EdgeInsets.all(12),
        floatingLabelAlignment: FloatingLabelAlignment.start,
        hintText: hintText,
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        hintStyle: const TextStyle(
            color: AppColor.textFieldHintColor,
            fontWeight: FontWeight.w500,
            fontSize: 14),
      ),
    );
  }
}
