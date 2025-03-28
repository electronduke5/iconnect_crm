import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconnect_crm/presentation/dialogs/add_product_dialog.dart';

class ProductCounterField extends ConsumerStatefulWidget {
  const ProductCounterField({super.key});

  @override
  ConsumerState<ProductCounterField> createState() =>
      _ProductCounterFieldState();
}

class _ProductCounterFieldState extends ConsumerState<ProductCounterField> {
  final TextEditingController _countController = TextEditingController(
      text: '1');
  final int _minValue = 1;
  final int _maxValue = 999;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Первоначальная проверка состояния
    _updateState();
  }

  void _updateState() {
    final serialNumber = ref.read(serialNumberProvider);
    if (serialNumber.isEmpty && _countController.text != '1') {
      _countController.text = '1';
    }
  }

  void _increment() {
    final currentValue = int.tryParse(_countController.text) ?? _minValue;
    if (currentValue < _maxValue) {
      _countController.text = (currentValue + 1).toString();
    }
  }

  void _decrement() {
    final currentValue = int.tryParse(_countController.text) ?? _minValue;
    if (currentValue > _minValue) {
      _countController.text = (currentValue - 1).toString();
    }
  }

  @override
  void dispose() {
    _countController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Слушаем изменения провайдера
    final serialNumber = ref.watch(serialNumberProvider);

    // Реакция на изменения serialNumber
    if (serialNumber.isNotEmpty && _countController.text != '1') {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _countController.text = '1';
      });
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: 60,
          child: TextFormField(
            enabled: serialNumber.isEmpty,
            controller: _countController,
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(vertical: 12),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Theme
                    .of(context)
                    .primaryColor
                    .withValues(alpha: 0.2),),
                borderRadius: BorderRadius.circular(8),
              ),
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
          ),
        ),
        const SizedBox(width: 4),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              onPressed: serialNumber.isEmpty ? _increment : null,
              icon: const Icon(Icons.arrow_drop_up),
              padding: const EdgeInsets.all(2),
              constraints: const BoxConstraints(),
              style: IconButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                  side: BorderSide(color: Theme
                      .of(context)
                      .primaryColor
                      .withValues(alpha: 0.2),),
                ),
              ),
            ),
            IconButton(
              onPressed: serialNumber.isEmpty ? _decrement : null,
              icon: const Icon(Icons.arrow_drop_down),
              padding: const EdgeInsets.all(2),
              constraints: const BoxConstraints(),
              style: IconButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                  side: BorderSide(
                    color: Theme
                        .of(context)
                        .primaryColor
                        .withValues(alpha: 0.2),
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