import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconnect_crm/data/models/category.dart';

final selectedCategoryProvider = StateProvider.autoDispose<Category?>((ref) {
  return null;
});

class CategoryDropdown extends ConsumerStatefulWidget {
  const CategoryDropdown({super.key, required this.categories});

  final List<Category> categories;

  @override
  ConsumerState<CategoryDropdown> createState() => _CategoryDropdownState();
}

class _CategoryDropdownState extends ConsumerState<CategoryDropdown> {
  TextEditingController categoryController = TextEditingController();
  Category? _selectedCategory;

  @override
  Widget build(BuildContext context) {
    return DropdownMenu<Category>(
      controller: categoryController,
      dropdownMenuEntries:
          widget.categories.map((department) {
            return DropdownMenuEntry<Category>(
              value: department,
              label: department.title,
            );
          }).toList(),
      menuHeight: 150,
      hintText: 'Выберите категорию',
      requestFocusOnTap: true,
      enableFilter: true,
      onSelected: (Category? category) {
        setState(() {
          FocusScope.of(context).requestFocus(FocusNode());
          _selectedCategory = category ?? _selectedCategory;
          ref.read(selectedCategoryProvider.notifier).state = _selectedCategory;
          //context.read<CategoryCubit>().filterByDepartment(department!.id);
        });
      },
    );
  }
}
