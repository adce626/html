import 'package:flutter/services.dart';

class PhoneFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    final text = newValue.text.replaceAll(RegExp(r'[\s\-]'), '');
    if (text.length > 11) return oldValue;

    final buffer = StringBuffer();
    for (var i = 0; i < text.length; i++) {
      if (i == 4 || i == 7) buffer.write(' ');
      buffer.write(text[i]);
    }

    final formatted = buffer.toString();
    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }

  static String format(String phone) {
    final cleaned = phone.replaceAll(RegExp(r'[\s\-]'), '');
    if (cleaned.length <= 4) return cleaned;
    if (cleaned.length <= 7) return '${cleaned.substring(0, 4)} ${cleaned.substring(4)}';
    return '${cleaned.substring(0, 4)} ${cleaned.substring(4, 7)} ${cleaned.substring(7)}';
  }
}
