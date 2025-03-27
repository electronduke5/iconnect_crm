import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/category.dart';
import '../../cubits/category_cubit/category_cubit.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    super.key,
    required this.category,
    //required this.categoryCubit,
  });

  final Category category;
  //final CategoryCubit categoryCubit;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).primaryColor,
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Row(
          children: [
            Text(category.title, style: TextStyle(color: Colors.white)),
            const SizedBox(width: 10),
            BlocBuilder<CategoryCubit, CategoryState>(
              builder: (context, state) {
                return IconButton(
                  onPressed: () async {
                    await context.read<CategoryCubit>().deleteCategory(
                      category.id,
                    );
                    state.getCategoriesState.item!.remove(category);
                  },
                  icon: Icon(Icons.delete_outline, color: Colors.white),
                  padding: EdgeInsets.zero,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
