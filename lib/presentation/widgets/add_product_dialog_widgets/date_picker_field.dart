import 'package:flutter/material.dart';
import 'package:iconnect_crm/common/extensions/date_extensions.dart';

class DatePickerField extends StatefulWidget {
  const DatePickerField({
    super.key,
    required this.dateController,
    this.endDate,
  });

  final TextEditingController dateController;
  final DateTime? endDate;

  @override
  State<DatePickerField> createState() => _StartDateFormFieldState();
}

class _StartDateFormFieldState extends State<DatePickerField> {
  final DateTime startDate = DateTime(2022);

  bool _canDecrement() {
    final currentDate = widget.dateController.text.parseLocalDate;
    final minDate = startDate;
    return currentDate.isAfter(minDate);
  }

  bool _canIncrement() {
    final currentDate = widget.dateController.text.parseLocalDate;
    final maxDate = widget.endDate ?? DateTime.now();
    return currentDate.isBefore(maxDate.subtract(const Duration(days: 1)));
  }

  void _decrementDate() {
    if (_canDecrement()) {
      setState(() {
        widget.dateController.text =
            widget.dateController.text.parseLocalDate
                .subtract(const Duration(days: 1))
                .toLocalFormat;
      });
    }
  }

  void _incrementDate() {
    if (_canIncrement()) {
      setState(() {
        widget.dateController.text =
            widget.dateController.text.parseLocalDate
                .add(const Duration(days: 1))
                .toLocalFormat;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (_canDecrement())
          IconButton(
            onPressed: () => _decrementDate(),
            icon: const Icon(Icons.arrow_back_ios_new),
          ),
        Expanded(
          child: TextFormField(
            controller: widget.dateController,
            readOnly: true,
            onTap: () async {
              final date = await showDatePicker(
                context: context,
                initialDate: widget.dateController.text.parseLocalDate,
                firstDate: DateTime(2022),
                lastDate: widget.endDate ?? DateTime.now(),
              );
              if (date != null) {
                setState(() {
                  widget.dateController.text = date.toLocalFormat;
                });
              }
            },
          ),
        ),
        if (_canIncrement())
          IconButton(
            onPressed: () => _incrementDate(),
            icon: const Icon(Icons.arrow_forward_ios),
          ),
      ],
    );
  }
}
