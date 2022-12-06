import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomRowInput extends StatefulWidget {
  const CustomRowInput({
    Key? key,
    required this.label,
    required this.controller,
  }) : super(key: key);

  final String label;
  final TextEditingController controller;

  @override
  State<CustomRowInput> createState() => _CustomRowInputState();
}

class _CustomRowInputState extends State<CustomRowInput> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.label),
        const SizedBox(height: 5),
        Container(
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 12),
            child: TextField(
              maxLength: 5,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                border: InputBorder.none,
                counterText: '',
              ),
              inputFormatters: [CustomMoneyFormatter()],
              controller: widget.controller,
            ),
          ),
        ),
      ],
    );
  }
}

class CustomMoneyFormatter extends TextInputFormatter {
  static const String separator = '.';
  static String oldValueText = '';
  static String newValueText = '';
  static int currentIndex = 0;

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    return customFormat(oldValue, newValue);
  }

  TextEditingValue customFormat(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isEmpty) {
      return newValue.copyWith(text: '');
    }

    oldValueText = oldValue.text.replaceAll(separator, '');
    newValueText = newValue.text.replaceAll(separator, '');

    if (oldValue.text.endsWith(separator) &&
        oldValue.text.length == newValue.text.length + 1) {
      newValueText = newValueText.substring(0, newValueText.length - 1);
    }

    if (oldValueText != newValueText) {
      String newString = '';

      currentIndex = newValue.text.length - newValue.selection.extentOffset;
      final chars = newValueText.split('');

      for (int i = chars.length - 1; i >= 0; i--) {
        if ((chars.length - 1 - i) % 2 == 0 && i != chars.length - 1) {
          newString = separator + newString;
        }
        newString = chars[i] + newString;
      }

      return TextEditingValue(
        text: newString,
        selection: TextSelection.collapsed(
          offset: newString.length - currentIndex,
        ),
      );
    }

    return newValue;
  }
}
