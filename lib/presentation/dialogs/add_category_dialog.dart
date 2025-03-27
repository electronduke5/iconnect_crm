import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconnect_crm/presentation/widgets/add_product_dialog_widgets/helper_text_widget.dart';

import '../../common/constants.dart';
import '../../data/models/category.dart';
import '../cubits/category_cubit/category_cubit.dart';

class CategoryDialogs {
  static final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  static Future openDialog({
    required BuildContext context,
    required CategoryCubit categoryCubit,
    required List<Category>? categories
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
                    Theme.of(context).scaffoldBackgroundColor,
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
                HelperText('Название категории'),
                TextFormField(
                  controller: titleController,
                  decoration: InputDecoration(
                    hintText: 'Телевизоры',
                    hintStyle: TextStyle(color: DynamicColors.helperTextColor),
                  ),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Название категории должно быть заполнено!';
                    }
                    if (categories != null &&
                        categories.any((category) => category.title == value)) {
                      return 'Такая категория уже есть!';
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
                      formKey.currentState!.reset();
                      Navigator.of(context).pop();
                    }
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
