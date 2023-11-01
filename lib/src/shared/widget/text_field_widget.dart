import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../constant/app_color.dart';
import '../../constant/text_size.dart';

class TextFormFieldWidget extends StatefulWidget {
  const TextFormFieldWidget(
      {Key? key,
      required this.controller,
      required this.labelText,
      required this.hintText,
      this.onTap,
      this.obscure = false,
      this.readOnly = false,
      this.required = false,
      this.textInputType,
      this.textCapitalization,
      this.textAlign = TextAlign.left,
      this.prefixIcon,
      this.suffixIcon,
      this.suffixColor,
      this.prefixColor,
      this.maxLine,
      this.minLine,
      this.maxLength,
      this.suffixOnTap,
      this.prefixOnTap,
      this.onChanged,
      this.onEditingComplete,
      this.contentPadding,
      this.focusNode})
      : super(key: key);

  final TextEditingController controller;
  final String labelText;
  final String hintText;
  final TextInputType? textInputType;
  final TextCapitalization? textCapitalization;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final Color? suffixColor;
  final Color? prefixColor;
  final TextAlign? textAlign;
  final bool obscure;
  final bool required;
  final bool readOnly;
  final int? maxLine;
  final int? minLine;
  final int? maxLength;
  final Function()? onTap;
  final Function(String)? onChanged;
  final Function()? onEditingComplete;
  final Function()? suffixOnTap;
  final Function()? prefixOnTap;
  final FocusNode? focusNode;
  final EdgeInsetsGeometry? contentPadding;

  @override
  State<TextFormFieldWidget> createState() => _TextFormFieldWidgetState();
}

class _TextFormFieldWidgetState extends State<TextFormFieldWidget> {
  bool _obscure = true;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text.rich(
          TextSpan(
            children: <InlineSpan>[
              WidgetSpan(
                child: Text(widget.labelText, style: const TextStyle(fontSize: TextSize.bodyText,fontWeight: FontWeight.bold)),
              ),
              WidgetSpan(
                child: Text(widget.required ? '*' : '',
                    style: const TextStyle(color: Colors.red)),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        TextFormField(
          validator: (val) => !widget.required || val != null && val.isNotEmpty
              ? null
              : "${widget.labelText.replaceAll('0', "")
              .replaceAll('1', "").replaceAll('2', "").replaceAll('3', "")
              .replaceAll('4', "").replaceAll('5', "").replaceAll('6', "")
              .replaceAll('7', "").replaceAll('8', "")
              .replaceAll('9', "").replaceFirst('.', "")
              .replaceFirst(' ', '')} can't be empty",
          controller: widget.controller,
          onTap: widget.onTap,
          focusNode: widget.focusNode,
          onChanged: (val) {
            if (widget.onChanged != null) {
              widget.onChanged!(val);
            }
          },
          maxLength: widget.maxLength,
          onEditingComplete: widget.onEditingComplete,
          readOnly: widget.readOnly,
          obscureText: widget.obscure ? _obscure : false,
          keyboardType: widget.textInputType ?? TextInputType.text,
          textCapitalization:
              widget.textCapitalization ?? TextCapitalization.none,
          maxLines: widget.maxLine ?? 1,
          minLines: widget.minLine ?? 1,
          textAlign: widget.textAlign!,
          style: TextStyle(
              color: AppColor.textColor,
              fontWeight: FontWeight.w500,
              fontSize: 14),
          decoration: InputDecoration(
              alignLabelWithHint: true,
              border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  borderSide: BorderSide(
                      color: AppColor.textFieldOutlineColor, width: 0.5)),
              enabledBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  borderSide: BorderSide(
                      color: AppColor.textFieldOutlineColor, width: 0.5)),
              focusedBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  borderSide: BorderSide(color: AppColor.primaryColor)),
              errorBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  borderSide:
                      BorderSide(color: AppColor.errorColor, width: 0.5)),
              isDense: true,
              contentPadding: widget.contentPadding ?? const EdgeInsets.all(12),
              floatingLabelAlignment: FloatingLabelAlignment.start,
              hintText: widget.hintText,
              floatingLabelBehavior: FloatingLabelBehavior.auto,
              hintStyle: const TextStyle(
                  color: AppColor.textFieldHintColor,
                  fontWeight: FontWeight.w500,
                  fontSize: 14),
              prefixIcon: widget.prefixIcon != null
                  ? InkWell(
                      onTap: widget.prefixOnTap,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 8, left: 10),
                        child: Icon(widget.prefixIcon,
                            size: 20,
                            color: widget.prefixColor ?? AppColor.primaryColor),
                      ),
                    )
                  : null,
              suffixIconConstraints: BoxConstraints.loose(size),
              prefixIconConstraints: BoxConstraints.loose(size),
              suffixIcon: widget.obscure
                  ? InkWell(
                      onTap: () => setState(() => _obscure = !_obscure),
                      child: Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Icon(
                            _obscure
                                ? CupertinoIcons.eye_slash
                                : CupertinoIcons.eye,
                            size: 20,
                            color: widget.suffixColor ?? Colors.grey.shade600),
                      ),
                    )
                  : InkWell(
                      onTap: widget.suffixOnTap,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Icon(widget.suffixIcon, size: 28),
                      ),
                    )),
        ),
      ],
    );
  }
}
