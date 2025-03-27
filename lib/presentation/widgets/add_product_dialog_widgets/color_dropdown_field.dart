import 'package:flutter/material.dart';
import 'package:iconnect_crm/presentation/widgets/add_product_dialog_widgets/helper_text_widget.dart';

import 'color_picker_field.dart';

class ColorDropdownField extends StatelessWidget {
  const ColorDropdownField({super.key});

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 3,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [HelperText('Цвет'), ColorPickerField()],
      ),
    );
  }
}
