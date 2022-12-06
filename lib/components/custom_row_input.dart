import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// extension FormatterHelper on String {
//   // static bool isFirst = true;
//   static const separator = '.'; // Change this to '.' for other locales

//   String formatCurrency(TextEditingController controller) {
//     return NumberFormat.currency(
//       customPattern: "#0.###",
//       symbol: 'R\$',
//     ).format(controller.text);

//     // String newValue = replaceAll(',', '').replaceAll('.', '');
//     // if (isEmpty || newValue == '00') {
//     //   controller.clear();
//     //   isFirst = true;
//     // }
//     // double value1 = double.parse(newValue);
//     // if (!isFirst) value1 = value1 * 100;

//     // controller.value = TextEditingValue(
//     //   text: NumberFormat.currency(customPattern: '###,###.##')
//     //       .format(value1 / 100),
//     //   selection: TextSelection.collapsed(offset: length),
//     // );
//     // return controller.text;
//   }
// }

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
          child: TextField(
            maxLength: 5,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              border: InputBorder.none,
              counterText: '',
            ),
            inputFormatters: [CustomMoneyFormatter()],
            // onChanged: (text) {
            //   // text.formatCurrency(widget.controller);
            // },
            controller: widget.controller,
          ),
        ),
      ],
    );
  }
}

class CustomMoneyFormatter extends TextInputFormatter {
  static const separator = '.';
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isEmpty) {
      return newValue.copyWith(text: '');
    }

    String oldValueText = oldValue.text.replaceAll(separator, '');
    String newValueText = newValue.text.replaceAll(separator, '');

    if (oldValue.text.endsWith(separator) &&
        oldValue.text.length == newValue.text.length + 1) {
      newValueText = newValueText.substring(0, newValueText.length - 1);
    }

    if (oldValueText != newValueText) {
      int selectionIndex =
          newValue.text.length - newValue.selection.extentOffset;
      final chars = newValueText.split('');

      String newString = '';
      for (int i = chars.length - 1; i >= 0; i--) {
        if ((chars.length - 1 - i) % 2 == 0 && i != chars.length - 1) {
          newString = separator + newString;
        }
        newString = chars[i] + newString;
      }

      return TextEditingValue(
        text: newString,
        selection: TextSelection.collapsed(
          offset: newString.length - selectionIndex,
        ),
      );
    }

    // If the new value and old value are the same, just return as-is
    return newValue;
  }
}
