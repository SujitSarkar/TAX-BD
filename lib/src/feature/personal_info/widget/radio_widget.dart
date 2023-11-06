import 'package:flutter/material.dart';
import '../../../constant/text_size.dart';

class PersonalInfoRadioWidget extends StatelessWidget {
  const PersonalInfoRadioWidget(
      {Key? key,
      required this.title,
      required this.groupValue,
      required this.onChanged})
      : super(key: key);
  final String title;
  final String groupValue;
  final Function(String?) onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,style: const TextStyle(fontSize: TextSize.bodyText,fontWeight: FontWeight.bold)),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Radio<String>(
              value: 'Yes',
              groupValue: groupValue,
              onChanged: onChanged,
            ),
            const Text('Yes'),
            Radio<String>(
              value: 'No',
              groupValue: groupValue,
              onChanged: onChanged,
            ),
            const Text('No'),
          ],
        ),
      ],
    );
  }
}
