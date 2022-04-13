import 'package:flutter/material.dart';
import 'package:pizzabloc/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.search_outlined))
        ],
        title: Center(child: Text('Peliculas en Cines')),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CardSwiper(),
            //TODO: CardSwiper
            MoviesSlider(),
          ],
        ),
      ),
    );
  }
}
