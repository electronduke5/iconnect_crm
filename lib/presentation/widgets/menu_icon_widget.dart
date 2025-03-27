import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconnect_crm/presentation/cubits/theme_cubit/theme_cubit.dart';

import '../../common/constants.dart';
import '../../common/menu_items.dart';
import '../../core/navigatioin_service.dart';
import '../cubits/menu_cubit/menu_cubit.dart';

class MenuIconWidget extends StatefulWidget {
  const MenuIconWidget({super.key});

  @override
  State<MenuIconWidget> createState() => _MenuIconWidgetState();
}

class _MenuIconWidgetState extends State<MenuIconWidget> {

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0),
      ),
      color: Theme.of(context).cardColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: BlocBuilder<MenuCubit, MenuState>(
              builder: (context, state) {
                return ListView.builder(
                  itemCount: MenuItem.menuItems.length,
                  itemBuilder: (context, index){
                    return Row(
                      children: [
                        Container(
                          width: 5,
                          height: 55,
                          decoration: BoxDecoration(
                            color: state.selectedIndex == index
                                ? lightTheme.primaryColor
                                : Colors.transparent,
                            borderRadius: const BorderRadius.horizontal(
                              right: Radius.circular(10),
                            ),
                          ),
                        ),
                        IconButton(
                          icon: Icon(MenuItem.menuItems[index].icon),
                          onPressed: () {
                            context.read<MenuCubit>().changeIndex(index);
                            NavigationService.navigateTo(MenuItem.menuItems[index].route);
                          },
                          iconSize: 25,
                          color: state.selectedIndex == index
                              ? lightTheme.primaryColor
                              : Theme
                              .of(context)
                              .disabledColor,
                        ),
                      ],
                    );
                  },

                );
              },
            ),
          ),
          Consumer(
            builder: (context, ref, child) {
              final theme = ref.watch(appThemeProvider).getThemeMode();
              return IconButton(
                onPressed: () {
                  ref
                      .read(appThemeProvider.notifier)
                      .setThemeMode(
                    theme == ThemeMode.light
                        ? ThemeMode.dark
                        : ThemeMode.light,
                  );
                },
                icon: Icon(
                  theme == ThemeMode.dark ? Icons.light_mode : Icons.dark_mode,
                ),
              );
            },
          ),

        ],
      ),
    );
  }
}
