import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconnect_crm/common/color_enum.dart';

final selectedColorProvider = StateProvider.autoDispose<ColorEnum?>((ref) {
  return null;
});

class ColorPickerField extends ConsumerStatefulWidget {
  const ColorPickerField({super.key});

  @override
  ConsumerState<ColorPickerField> createState() => _ColorPickerFieldState();
}

class _ColorPickerFieldState extends ConsumerState<ColorPickerField> {
  final TextEditingController _colorController = TextEditingController();
  ColorEnum? _selectedColor;

  @override
  Widget build(BuildContext context) {
    return DropdownMenu<ColorEnum>(
      controller: _colorController,
      dropdownMenuEntries:
          ColorEnum.values.map((item) {
            return DropdownMenuEntry<ColorEnum>(
              value: item,
              label: item.name,
              leadingIcon: Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: item.color,
                ),
              ),
            );
          }).toList(),
      requestFocusOnTap: true,
      menuHeight: 150,
      enableFilter: true,
      hintText: 'Выберите цвет',
      leadingIcon: Icon(Icons.circle, color: _selectedColor?.color),
      onSelected: (ColorEnum? color) {
        setState(() {
          FocusScope.of(context).requestFocus(FocusNode());
          _selectedColor = color ?? _selectedColor;
          ref.read(selectedColorProvider.notifier).state = _selectedColor;
        });
      },
    );
  }
}
