import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iconnect_crm/common/constants.dart';
import 'package:iconnect_crm/presentation/cubits/category_cubit/category_cubit.dart';
import 'package:iconnect_crm/presentation/dialogs/add_category_dialog.dart';
import 'package:iconnect_crm/presentation/dialogs/add_product_dialog.dart';

import '../../data/models/category.dart';
import '../cubits/model_state.dart';
import '../widgets/caetgory_widgets/category_card_widget.dart';

class ProductsPage extends StatelessWidget {
  const ProductsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(41.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Привет, Павел👋', style: TextStyle(fontSize: 25)),
            const SizedBox(height: 20),
            Card(
              margin: EdgeInsets.zero,
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: DynamicColors.greenIconBackgroundColor,
                      radius: 40,
                      child: SvgPicture.asset(
                        'assets/images/profile-2user.svg',
                      ),
                    ),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Всего продаж',
                          style: TextStyle(
                            color: DynamicColors.secondaryTextColor,
                          ),
                        ),
                        Text(
                          '5,423',
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.arrow_upward,
                              color: DynamicColors.greenIconDataColor,
                            ),
                            Text('16%', style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: DynamicColors.greenIconDataColor,
                            ),),
                            Text(' в этом месяце'),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10,),
            SizedBox(
              height: 50,
              child: Card(
                child: BlocBuilder<CategoryCubit, CategoryState>(
                    builder: (context, state) {
                      switch (state.getCategoriesState) {
                        case IdleState<List<Category>> _:
                        case LoadingState<List<Category>> _:
                          return const Center(
                            child: LinearProgressIndicator(),);
                        case LoadedState<List<Category>> _:
                          if (state.getCategoriesState.item == null ||
                              state.getCategoriesState.item!.isEmpty) {
                            return const Center(
                              child: Text(
                                'Ещё нет ни одной категории...',
                              ),
                            );
                          } else {
                            return ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: state.getCategoriesState.item!.length,
                              itemBuilder: (context, index) {
                                return CategoryCard(
                                  category: state.getCategoriesState
                                      .item![index],);
                              },
                            );
                          }
                        default:
                          return const Center(
                            child: LinearProgressIndicator(),);
                      }
                    }),
              ),
            ),
            const Spacer(),
            Row(
              children: [
                ElevatedButton(
                  onPressed: () {
                    CategoryDialogs.openDialog(context: context,
                      categoryCubit: context.read<CategoryCubit>(),
                    categories: context.read<CategoryCubit>().state.getCategoriesState.item);
                  },
                  child: Text('Добавить категорию'),
                ),
                const SizedBox(width: 10,),
                ElevatedButton(
                  onPressed: () {
                    ProductDialogs.openDialog(
                        context: context, categories: context
                        .read<CategoryCubit>()
                        .state
                        .getCategoriesState
                        .item);
                  },
                  child: Text('Добавить товар'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

