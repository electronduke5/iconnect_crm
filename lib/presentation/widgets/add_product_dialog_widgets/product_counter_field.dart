import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../common/constants.dart';

class ProductCounterField extends StatefulWidget {
  const ProductCounterField({super.key});

  @override
  State<ProductCounterField> createState() => _ProductCounterFieldState();
}

class _ProductCounterFieldState extends State<ProductCounterField> {
  final TextEditingController _countController = TextEditingController(
    text: '1',
  );
  final int _minValue = 1;
  final int _maxValue = 999;

  @override
  void dispose() {
    _countController.dispose();
    super.dispose();
  }

  void _increment() {
    final currentValue = int.tryParse(_countController.text) ?? _minValue;
    if (currentValue < _maxValue) {
      setState(() {
        _countController.text = (currentValue + 1).toString();
      });
    }
  }

  void _decrement() {
    final currentValue = int.tryParse(_countController.text) ?? _minValue;
    if (currentValue > _minValue) {
      setState(() {
        _countController.text = (currentValue - 1).toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: 60, // Фиксированная ширина поля
          child: TextFormField(
            controller: _countController,
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(vertical: 12),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Кол-во товара обязательно!';
              }
              return null;
            },
            inputFormatters: [
              LengthLimitingTextInputFormatter(3),
              FilteringTextInputFormatter.digitsOnly,
            ],
            onChanged: (value) {
              // Валидация ввода при ручном редактировании
              if (value.isNotEmpty) {
                final numValue = int.tryParse(value) ?? _minValue;
                if (numValue < _minValue) {
                  _countController.text = _minValue.toString();
                } else if (numValue > _maxValue) {
                  _countController.text = _maxValue.toString();
                }
              }
            },
          ),
        ),
        const SizedBox(width: 4),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              onPressed: _increment,
              icon: const Icon(Icons.arrow_drop_up),
              padding: const EdgeInsets.all(1),
              constraints: const BoxConstraints(),
              style: IconButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: BorderSide(
                    color: lightColorScheme.primary.withValues(alpha: 0.2),
                  ),
                ),
              ),
            ),
            IconButton(
              onPressed: _decrement,
              icon: const Icon(Icons.arrow_drop_down),
              padding: const EdgeInsets.all(1),
              constraints: const BoxConstraints(),
              style: IconButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: BorderSide(
                    color: lightColorScheme.primary.withValues(alpha: 0.2),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
