import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:tax_bd/src/constant/text_size.dart';
import '../../constant/app_color.dart';

class CustomDropdown extends StatelessWidget {
  final List<String> items;
  String? selectedValue;
  final String labelText;
  final Function(String) onChanged;
  final double? buttonHeight;
  final double? dropdownWidth;

  CustomDropdown(
      {Key? key,
      required this.items,
      required this.selectedValue,
      required this.labelText,
      required this.onChanged,
      this.buttonHeight = 45,
      this.dropdownWidth})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(labelText, style: TextStyle(color: AppColor.textColor,fontSize: TextSize.bodyText,fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        DropdownButtonHideUnderline(
          child: DropdownButton2(
            isExpanded: true,
            hint: const Text('Select',
                style: TextStyle(color: AppColor.textFieldHintColor),
                overflow: TextOverflow.ellipsis),
            style: TextStyle(
                color: AppColor.textColor, fontSize: TextSize.bodyText),
            items: items
                .map((item) => DropdownMenuItem<String>(
                      value: item,
                      child: Text(
                        item,
                        style: TextStyle(color: AppColor.textColor),
                      ),
                    ))
                .toList(),
            value: selectedValue,
            onChanged: (value) {
              selectedValue = value as String;
              onChanged(selectedValue!);
            },
            iconStyleData: const IconStyleData(
              icon: Icon(Icons.keyboard_arrow_down, size: 20),
              iconSize: 14,
              iconEnabledColor: AppColor.textFieldHintColor,
              iconDisabledColor: Colors.grey,
            ),
            buttonStyleData: ButtonStyleData(
              height: buttonHeight,
              width: double.infinity,
              padding: const EdgeInsets.only(left: 14, right: 14),
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(5)),
                  border: Border.all(color: Colors.grey, width: 0.5),
                  color: Colors.white),
              elevation: 0,
            ),
            menuItemStyleData: const MenuItemStyleData(
              height: 40,
              padding: EdgeInsets.only(left: 14, right: 14),
            ),
            dropdownStyleData: DropdownStyleData(
              maxHeight: 500,
              width: dropdownWidth?? MediaQuery.of(context).size.width * .9,
              padding: null,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5), color: Colors.white),
              elevation: 8,
              scrollbarTheme: ScrollbarThemeData(
                radius: const Radius.circular(10),
                thickness: MaterialStateProperty.all(6),
                thumbVisibility: MaterialStateProperty.all(true),
              ),
              // offset: const Offset(-10, 0),
            ),
          ),
        ),
      ],
    );
  }
}
