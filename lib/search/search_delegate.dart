import 'package:flutter/material.dart';
import 'package:pizzabloc/screens/details_screen.dart';
import 'package:provider/provider.dart';

import '../models/models.dart';
import '../providers/movies_provider.dart';

class MovieSearchDelegate extends SearchDelegate {
  @override
  // TODO: implement searchFieldLabel
  String? get searchFieldLabel => 'Buscar Pelicula';
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    return Text('buildActions');
  }

  Widget _EmptyContainer() {
    return Container(
      child: Center(
          child: Icon(
        Icons.movie_creation_outlined,
        color: Colors.black38,
        size: 100,
      )),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return _EmptyContainer();
    }

    final moviesProvider = Provider.of<MoviesProvider>(context, listen: false);
    moviesProvider.getSuggestionsbyQuery(query);

    return StreamBuilder(
        stream: moviesProvider.suggestionStream,
        builder: (BuildContext context, AsyncSnapshot<List<Movie>> snapshot) {
          if (!snapshot.hasData) {
            return _EmptyContainer();
          }
          final movies = snapshot.data!;

          return ListView.builder(
            itemCount: movies.length,
            itemBuilder: (BuildContext context, int index) {
              return _SuggestionItem(movie: movies[index]);
            },
          );
        });
  }
}

class _SuggestionItem extends StatelessWidget {
  final movie;

  const _SuggestionItem({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: FadeInImage(
        placeholder: AssetImage('images/no-image.jpg'),
        image: NetworkImage(movie.fullPosterImage),
        width: 50,
        fit: BoxFit.contain,
      ),
      title: Text(movie.title),
      subtitle: Text(movie.originalTitle),
      onTap: () {
        Navigator.pushNamed(context, DetailsScreen.routerName,
            arguments: movie);
      },
    );
  }
}
