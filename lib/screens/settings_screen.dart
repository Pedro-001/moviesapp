import 'package:flutter/material.dart';
import 'package:pizzabloc/widgets/widgets.dart';

class SettingsScreen extends StatelessWidget {
  static const String routerName = 'Settings';

  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const sideMenu(),
      appBar: AppBar(
        title: const Text('Configuraciones'),
      ),
      body: Center(
        child: Column(
          children: [
            Text('Modo oscuro'),
            Divider(),
            Text('Color de la aplicación'),
            Divider(),
            Text('Modo oscuro'),
            Divider(),
          ],
        ),
      ),
    );
  }
}
