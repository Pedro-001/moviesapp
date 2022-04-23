import 'package:flutter/material.dart';
import 'package:pizzabloc/providers/movies_provider.dart';
import 'package:pizzabloc/search/search_delegate.dart';
import 'package:pizzabloc/widgets/widgets.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  static const String routerName = 'Home';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final moviesProvier = Provider.of<MoviesProvider>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () =>
                  showSearch(context: context, delegate: MovieSearchDelegate()),
              icon: Icon(Icons.search_outlined))
        ],
        title: Center(child: Text('Directorio Peliculas')),
      ),
      drawer: sideMenu(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CardSwiper(
              movies: moviesProvier.onDisplayMovies,
            ),
            //TODO: CardSwiper
            MoviesSlider(
              title: 'Populares',
              moviesList: moviesProvier.popularMovies,
              onNextPage: () => moviesProvier.getPopularMovies(),
            ),
            MoviesSlider(
              title: 'Pronto en cines',
              moviesList: moviesProvier.upComingMovies,
              onNextPage: () => moviesProvier.getUpcomingMovies(),
            ),
            MoviesSlider(
                title: 'Acción',
                moviesList: moviesProvier.actionMovies,
                onNextPage: () => moviesProvier.getMoviesAction()),
            MoviesSlider(
                title: 'Comedia',
                moviesList: moviesProvier.comedyMovies,
                onNextPage: () => moviesProvier.getMoviesComedy()),
            MoviesSlider(
                title: 'Aventura',
                moviesList: moviesProvier.adventureMovies,
                onNextPage: () => moviesProvier.getMoviesAdventure()),
            MoviesSlider(
                title: 'Crimen',
                moviesList: moviesProvier.crimeMovies,
                onNextPage: () => moviesProvier.getMoviesCrime()),
            MoviesSlider(
                title: 'Animadas',
                moviesList: moviesProvier.animationMovies,
                onNextPage: () => moviesProvier.getMoviesAnimated()),
            MoviesSlider(
                title: 'Drama',
                moviesList: moviesProvier.dramaMovies,
                onNextPage: () => moviesProvier.getMoviesDrama()),
            MoviesSlider(
                title: 'Para toda la familia',
                moviesList: moviesProvier.familyMovies,
                onNextPage: () => moviesProvier.getMoviesFamily()),
            MoviesSlider(
                title: 'Fantasia',
                moviesList: moviesProvier.fantasyMovies,
                onNextPage: () => moviesProvier.getMoviesFantasy()),
            MoviesSlider(
                title: 'Terror',
                moviesList: moviesProvier.horrorMovies,
                onNextPage: () => moviesProvier.getMoviesHorror()),
            MoviesSlider(
                title: 'SciFi',
                moviesList: moviesProvier.scifiMovies,
                onNextPage: () => moviesProvier.getMoviesScriFi()),
          ],
        ),
      ),
    );
  }
}
