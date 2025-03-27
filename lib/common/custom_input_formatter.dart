import 'package:flutter/services.dart';

class PercentBatteryFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    // Если поле пустое - разрешаем (чтобы можно было очистить поле)
    if (newValue.text.isEmpty) {
      return newValue;
    }

    // Проверяем, что введены только цифры
    if (!RegExp(r'^\d*$').hasMatch(newValue.text)) {
      return oldValue;
    }

    // Парсим число
    final number = int.tryParse(newValue.text) ?? 0;

    // Проверяем диапазон
    if (number < 1) {
      return oldValue;
    } else if (number > 100) {
      return const TextEditingValue(
        text: '100',
        selection: TextSelection.collapsed(offset: 3),
      );
    }

    return newValue;
  }
}

class ThousandsSeparatorInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    // Удаляем все пробелы из текущего значения
    final newText = newValue.text.replaceAll(' ', '');

    // Если строка пустая - возвращаем как есть
    if (newText.isEmpty) {
      return newValue;
    }

    // Парсим число
    final numValue = int.tryParse(newText);
    if (numValue == null) {
      return oldValue;
    }

    // Форматируем с пробелами
    final formattedText = _formatWithSpaces(numValue);

    // Возвращаем новое значение с корректной позицией курсора
    return TextEditingValue(
      text: formattedText,
      selection: _calculateCursorPosition(
        oldValue: oldValue,
        newValue: newValue,
        formattedText: formattedText,
      ),
    );
  }

  String _formatWithSpaces(int number) {
    final String text = number.toString();
    final StringBuffer buffer = StringBuffer();

    for (int i = 0; i < text.length; i++) {
      if (i > 0 && (text.length - i) % 3 == 0) {
        buffer.write(' ');
      }
      buffer.write(text[i]);
    }

    return buffer.toString();
  }

  TextSelection _calculateCursorPosition({
    required TextEditingValue oldValue,
    required TextEditingValue newValue,
    required String formattedText,
  }) {
    // Логика для корректного позиционирования курсора
    final oldText = oldValue.text.replaceAll(' ', '');
    final newText = newValue.text.replaceAll(' ', '');

    final insertedSpaces = formattedText.length - newText.length;

    final newOffset = newValue.selection.extentOffset + insertedSpaces;

    return TextSelection.collapsed(
      offset: newOffset.clamp(0, formattedText.length),
    );
  }
}
