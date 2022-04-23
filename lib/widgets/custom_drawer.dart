import 'package:flutter/material.dart';
import 'package:pizzabloc/providers/theme_provider.dart';
import 'package:pizzabloc/screens/screens.dart';
import 'package:pizzabloc/share_preferences/preferences.dart';
import 'package:provider/provider.dart';

class sideMenu extends StatefulWidget {
  const sideMenu({Key? key}) : super(key: key);

  @override
  State<sideMenu> createState() => _sideMenuState();
}

class _sideMenuState extends State<sideMenu> {
  // bool isDarkmode = false;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          _DrawerHeader(),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Inicio'),
            onTap: () {
              Navigator.pushReplacementNamed(context, HomeScreen.routerName);
            },
          ),
          ListTile(
            leading: const Icon(Icons.account_circle),
            title: const Text('Cuenta'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.settings_outlined),
            title: const Text('Configuraciones'),
            onTap: () {
              Navigator.pushReplacementNamed(
                  context, SettingsScreen.routerName);
            },
          ),
          SwitchListTile.adaptive(
              title: const Text('Modo Oscuro'),
              value: Preferences.isDarkMode,
              onChanged: (value) {
                Preferences.isDarkMode = value;
                final themeProvider =
                    Provider.of<ThemeProvider>(context, listen: false);
                value
                    ? themeProvider.setDarkMode()
                    : themeProvider.setLightMode();
                setState(() {});
              })
        ],
      ),
    );
  }
}

class _DrawerHeader extends StatelessWidget {
  const _DrawerHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DrawerHeader(
        padding: EdgeInsets.zero,
        child: Container(decoration: BoxDecoration(color: Colors.orange[800])
            //shape: BoxShape.circle,
            //image: DecorationImage(
            //  image: NetworkImage(
            //     'https://images.unsplash.com/photo-1594908900066-3f47337549d8?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1470&q=80'))),
            ));
  }
}
