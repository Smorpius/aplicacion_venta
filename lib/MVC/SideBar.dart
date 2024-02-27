import 'package:flutter/material.dart';

class SideBar extends StatelessWidget {
  final List<NavItem> navItems;
  final Function(int) onNavItemTap;

  SideBar({required this.navItems, required this.onNavItemTap});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.green,
            ),
            child: Text(
              'Inicio',
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
          ),
          for (var item in navItems)
            ListTile(
              title: Text(item.title),
              onTap: () => onNavItemTap(item.index),
            ),
        ],
      ),
    );
  }
}

class NavItem {
  final String title;
  final int index;

  NavItem({required this.title, required this.index});
}
