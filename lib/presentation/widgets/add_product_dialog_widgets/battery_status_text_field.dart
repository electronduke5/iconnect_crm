import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../common/constants.dart';
import '../../../common/custom_input_formatter.dart';
import 'helper_text_widget.dart';

class BatteryStatusTextField extends StatelessWidget {
  const BatteryStatusTextField({super.key, required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 1,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HelperText('Батарея'),
          TextFormField(
            controller: controller,
            decoration: InputDecoration(
              suffixIcon: Icon(Icons.percent),
              hintText: '100',
              hintStyle: TextStyle(color: DynamicColors.helperTextColor),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Состояние батареи обязательно!';
              }
              return null;
            },
            inputFormatters: [
              LengthLimitingTextInputFormatter(3),
              PercentBatteryFormatter(),
            ],
          ),
        ],
      ),
    );
  }
}
