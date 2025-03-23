import 'package:flutter/material.dart';

class MenuItem {
  String title;
  IconData icon;
  String route;

  MenuItem({required this.title, required this.icon, required this.route});

  static final List<MenuItem> menuItems = [
    MenuItem(title: 'Товары', icon: Icons.phone_android, route: '/products'),
    MenuItem(title: 'Чеки', icon: Icons.document_scanner, route: '/cheques'),
    MenuItem(title: 'Персонал', icon: Icons.people, route: '/employees'),
  ];
}
