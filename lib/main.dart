import 'package:flutter/material.dart';
import 'package:pizzabloc/providers/movies_provider.dart';
import 'package:pizzabloc/providers/theme_provider.dart';
import 'package:pizzabloc/screens/screens.dart';
import 'package:pizzabloc/share_preferences/preferences.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Preferences.init();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (BuildContext context) => MoviesProvider(),
        lazy: false,
      ),
      ChangeNotifierProvider(
          create: (BuildContext context) =>
              ThemeProvider(isDarkmode: Preferences.isDarkMode)),
    ],
    child: MyApp(),
  ));
}

//class AppState extends StatelessWidget {
//  const AppState({Key? key}) : super(key: key);
//  //Estado del provider
//
//  @override
//  Widget build(BuildContext context) {
//    return MultiProvider(
//      providers: [
//        ChangeNotifierProvider(
//          create: (BuildContext context) => MoviesProvider(),
//          lazy: false,
//        ),
//      ],
//      child: MyApp(),
//    );
//  }
//}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Peliculas',
      initialRoute: HomeScreen.routerName,
      routes: {
        HomeScreen.routerName: (context) => HomeScreen(),
        DetailsScreen.routerName: (context) => DetailsScreen(),
        SettingsScreen.routerName: (context) => SettingsScreen(),
      },
      //theme: ThemeData.light()
      //    .copyWith(appBarTheme: AppBarTheme(color: Colors.orange[800])),

      theme: Provider.of<ThemeProvider>(context).currentTheme,
    );
  }
}
