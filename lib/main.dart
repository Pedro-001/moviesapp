import 'package:flutter/material.dart';
import 'package:pizzabloc/providers/movies_provider.dart';
import 'package:pizzabloc/screens/screens.dart';
import 'package:provider/provider.dart';

void main() => runApp(AppState());

class AppState extends StatelessWidget {
  const AppState({Key? key}) : super(key: key);
  //Estado del provider

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (BuildContext context) => MoviesProvider(),
          lazy: false,
        ),
      ],
      child: MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Peliculas',
      initialRoute: 'home',
      routes: {
        'home': (context) => HomeScreen(),
        'details': (context) => DetailsScreen()
      },
      theme: ThemeData.light()
          .copyWith(appBarTheme: AppBarTheme(color: Colors.orange[800])),
    );
  }
}
