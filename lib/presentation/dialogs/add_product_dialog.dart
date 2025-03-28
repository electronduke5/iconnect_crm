import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconnect_crm/common/extensions/date_extensions.dart';
import 'package:iconnect_crm/presentation/widgets/add_product_dialog_widgets/battery_status_text_field.dart';
import 'package:iconnect_crm/presentation/widgets/add_product_dialog_widgets/date_picker_field.dart';
import 'package:iconnect_crm/presentation/widgets/add_product_dialog_widgets/helper_text_widget.dart';
import 'package:iconnect_crm/presentation/widgets/add_product_dialog_widgets/product_counter_field.dart';
import 'package:iconnect_crm/presentation/widgets/caetgory_widgets/category_dropdown_widget.dart';

import '../../common/constants.dart';
import '../../common/custom_input_formatter.dart';
import '../../data/models/category.dart';
import '../cubits/category_cubit/category_cubit.dart';
import '../widgets/add_product_dialog_widgets/color_dropdown_field.dart';

final serialNumberProvider = StateProvider.autoDispose<String>((ref) {
  return '';
});

class ProductDialogs {
  static final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  static Future openDialog({
    required BuildContext context,
    //required ProductCubit productCubit,
    required List<Category>? categories,
  }) {
    TextEditingController titleController = TextEditingController();
    TextEditingController purchasePriceController = TextEditingController();
    TextEditingController dateController = TextEditingController(text: DateTime
        .now()
        .toLocalFormat);
    TextEditingController productCountController = TextEditingController(
      text: '1',
    );
    TextEditingController serialNumberController = TextEditingController();
    TextEditingController batteryController = TextEditingController();

    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Добавить товар',
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
            child: Consumer(
              builder: (context, ref, child) {
                final selectedCategory = ref.watch(selectedCategoryProvider);
                return SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      HelperText('Категория'),
                          () {
                        if (categories == null || categories.isEmpty) {
                          return Text('Категорий ещё не добавлено!');
                        } else {
                          return CategoryDropdown(categories: categories);
                        }
                      }(),
                      HelperText('Название товара'),
                      TextFormField(
                        controller: titleController,
                        decoration: InputDecoration(
                          hintText: 'iPhone 16 Pro Max',
                          hintStyle: TextStyle(
                            color: DynamicColors.helperTextColor,
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Название товара должно быть заполнено!';
                          }
                          return null;
                        },
                        inputFormatters: [LengthLimitingTextInputFormatter(50)],
                      ),
                      HelperText('Серийный номер'),
                      Consumer(
                        builder: (context, ref, child) {
                          return TextFormField(
                            controller: serialNumberController,
                            decoration: InputDecoration(
                              hintText: 'S/N',
                              hintStyle: TextStyle(
                                color: DynamicColors.helperTextColor,
                              ),
                            ),
                            onChanged: (value) {
                              ref
                                  .read(serialNumberProvider.notifier)
                                  .state = value;
                            },
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(50)
                            ],
                          );
                        },
                      ),
                          () {
                        if (selectedCategory != null &&
                            selectedCategory.title == 'Смартфоны' &&
                            selectedCategory.id == 1) {
                          return Row(
                            children: [
                              ColorDropdownField(),
                              const SizedBox(width: 10),
                              BatteryStatusTextField(
                                controller: batteryController,
                              ),
                            ],
                          );
                        }
                        return const SizedBox();
                      }(),
                      Row(
                        children: [
                          Flexible(
                            flex: 2,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                HelperText('Стоимость при покупке'),
                                TextFormField(
                                  controller: purchasePriceController,
                                  decoration: InputDecoration(
                                    suffixIcon: Icon(Icons.currency_ruble),
                                    hintText: '53 700',
                                    hintStyle: TextStyle(
                                      color: DynamicColors.helperTextColor,
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Серийный номер должен быть заполнен!';
                                    }
                                    return null;
                                  },
                                  inputFormatters: [
                                    LengthLimitingTextInputFormatter(12),
                                    FilteringTextInputFormatter.digitsOnly,
                                    ThousandsSeparatorInputFormatter(),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 10),
                          Flexible(
                            flex: 1,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                HelperText('Количество'),
                                ProductCounterField(),
                              ],
                            ),
                          ),
                        ],
                      ),
                      HelperText('Дата покупки'),
                      DatePickerField(dateController: dateController)
                    ],
                  ),
                );
              },
            ),
          ),
          actions: [
            BlocBuilder<CategoryCubit, CategoryState>(
              builder: (context, state) {
                return ElevatedButton(
                  onPressed: () {
                    //formKey.currentState!.save();
                    if (formKey.currentState!.validate()) {}
                    // formKey.currentState!.reset();
                    // Navigator.of(context).pop();
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
