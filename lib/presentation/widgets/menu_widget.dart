import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconnect_crm/common/constans.dart';
import 'package:iconnect_crm/presentation/cubits/theme_cubit/theme_cubit.dart';

import '../../common/menu_items.dart';
import '../../core/navigatioin_service.dart';
import '../cubits/menu_cubit/menu_cubit.dart';

class MenuWidget extends StatefulWidget {
  const MenuWidget({super.key});

  @override
  State<MenuWidget> createState() => _MenuWidgetState();
}

class _MenuWidgetState extends State<MenuWidget> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 60,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('assets/images/logo_iconnect_black.png'),
              ),
            ),
          ),
          Expanded(
            child: BlocBuilder<MenuCubit, MenuState>(
              builder: (context, state) {
                return ListView.builder(
                  itemCount: MenuItem.menuItems.length,
                  itemBuilder: (context, index) {
                    return Row(
                      children: [
                        Container(
                          width: 5,
                          height: 45,
                          decoration: BoxDecoration(
                            color:
                                state.selectedIndex == index
                                    ? mainTheme.primaryColor
                                    : Colors.transparent,
                            borderRadius: const BorderRadius.horizontal(
                              right: Radius.circular(10),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(
                              left: 10.0,
                              right: 10.0,
                            ),
                            child: buildMenuListTile(index, state, context),
                          ),
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

  ListTile buildMenuListTile(int index, MenuState state, BuildContext context) {
    return ListTile(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      title: Text(MenuItem.menuItems[index].title),
      leading: Icon(
        MenuItem.menuItems[index].icon,
        color:
            state.selectedIndex == index
                ? Colors.white
                : mainTheme.disabledColor,
      ),
      selected: state.selectedIndex == index,
      onTap: () async {
        context.read<MenuCubit>().changeIndex(index);
        NavigationService.navigateTo(MenuItem.menuItems[index].route);
      },
    );
  }
}
