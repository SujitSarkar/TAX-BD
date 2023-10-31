import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import '../../constant/app_color.dart';

class CustomDropdown extends StatelessWidget {
  final List<String> items;
  String? selectedValue;
  final String labelText;
  final Function(String) onChanged;

  CustomDropdown(
      {Key? key,
      required this.items,
      required this.selectedValue,
      required this.labelText,
      required this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(labelText, style: TextStyle(color: AppColor.textColor)),
        const SizedBox(height: 5),
        DropdownButtonHideUnderline(
          child: DropdownButton2(
            isExpanded: true,
            hint: const Text('Select',
                style: TextStyle(color: AppColor.textFieldHintColor),
                overflow: TextOverflow.ellipsis),
            items: items
                .map((item) => DropdownMenuItem<String>(
                      value: item,
                      child: Text(
                        item,
                        style: TextStyle(
                            color:
                                selectedValue != null && selectedValue == item
                                    ? AppColor.primaryColor
                                    : null),
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
              iconEnabledColor: AppColor.secondaryColor,
              iconDisabledColor: Colors.grey,
            ),
            buttonStyleData: ButtonStyleData(
              height: 50,
              width: double.infinity,
              padding: const EdgeInsets.only(left: 14, right: 14),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                border: Border.all(color: Colors.grey, width: 0.5),
                // color: ThemeViewModel.instance.cardBgColor()
              ),
              elevation: 0,
            ),
            menuItemStyleData: const MenuItemStyleData(
              height: 40,
              padding: EdgeInsets.only(left: 14, right: 14),
            ),
            dropdownStyleData: DropdownStyleData(
              maxHeight: 500,
              width: MediaQuery.of(context).size.width * .9,
              padding: null,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                // color: ThemeViewModel.instance.cardBgColor()
              ),
              elevation: 8,
              scrollbarTheme: ScrollbarThemeData(
                radius: const Radius.circular(10),
                thickness: MaterialStateProperty.all(6),
                thumbVisibility: MaterialStateProperty.all(true),
              ),
              offset: const Offset(-10, 0),
            ),
          ),
        ),
      ],
    );
  }
}
