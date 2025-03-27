import 'package:flutter/material.dart';

import '../../../common/constants.dart';

class HelperText extends StatelessWidget {
  const HelperText(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 10, bottom: 5),
      child: Text(text, style: TextStyle(color: DynamicColors.helperTextColor)),
    );
  }
}
