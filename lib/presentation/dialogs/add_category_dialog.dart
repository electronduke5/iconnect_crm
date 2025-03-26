import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../common/constans.dart';
import '../cubits/category_cubit/category_cubit.dart';

class CategoryDialogs {
  static final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  static Future openDialog({
    required BuildContext context,
    required CategoryCubit categoryCubit,
  }) {
    TextEditingController titleController = TextEditingController();

    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Добавить категорию',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(width: MediaQuery.of(context).size.width / 10),
              IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: Icon(Icons.close),
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(
                    lightTheme.scaffoldBackgroundColor,
                  ),
                  shape: WidgetStatePropertyAll(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                  ),
                ),
              ),
            ],
          ),
          content: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 10, bottom: 5),
                  child: Text(
                    'Название категории',
                    style: TextStyle(color: DynamicColors.helperTextColor),
                  ),
                ),
                TextFormField(
                  controller: titleController,
                  decoration: InputDecoration(
                    hintText: 'Телевизоры',
                    hintStyle: TextStyle(color: DynamicColors.helperTextColor),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Название категории должно быть заполнено!';
                    }
                    return null;
                  },
                  inputFormatters: [LengthLimitingTextInputFormatter(30)],
                ),
              ],
            ),
          ),
          actions: [
            BlocBuilder<CategoryCubit, CategoryState>(
              builder: (context, state) {
                return ElevatedButton(
                  onPressed: () {
                    formKey.currentState!.save();
                    if (formKey.currentState!.validate()) {
                      categoryCubit
                        ..addCategory(titleController.text)
                        ..loadAllCategories();
                    }
                    formKey.currentState!.reset();
                    Navigator.of(context).pop();
                  },
                  child: const Text('Сохранить'),
                );
              },
            ),
          ],
        );
      },
    );
  }
}
