import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
      color: Theme.of(context).cardTheme.color,
      child: Column(
        children: [
          Image.asset('assets/images/logo_iconnect_black.png'),
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
                                    ? const Color(0xFF4880FF)
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
                            child: ListTile(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              title: Text(MenuItem.menuItems[index].title),
                              leading: Icon(MenuItem.menuItems[index].icon),
                              selected: state.selectedIndex == index,
                              onTap: () async {
                                context.read<MenuCubit>().changeIndex(index);
                                NavigationService.navigateTo(
                                  MenuItem.menuItems[index].route,
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
