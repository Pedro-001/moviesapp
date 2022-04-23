import 'package:flutter/material.dart';
import 'package:pizzabloc/widgets/widgets.dart';

import '../models/models.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Movie movie = ModalRoute.of(context)!.settings.arguments as Movie;
    print(movie.title);
    return Scaffold(
        body: CustomScrollView(
      slivers: [
        _CustomAppBar(
          movie: movie,
        ),
        SliverList(
            delegate: SliverChildListDelegate([
          _PosterAndTitle(
            movie: movie,
          ),
          _Overview(movie: movie),
          CastingCards(
            movieId: movie.id,
          )
        ]))
      ],
    ));
  }
}

class _CustomAppBar extends StatelessWidget {
  final movie;
  const _CustomAppBar({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.orange[800],
      expandedHeight: 200,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: EdgeInsets.all(0),
        centerTitle: true,
        title: Container(
            padding: EdgeInsets.all(10),
            width: double.infinity,
            alignment: Alignment.bottomCenter,
            color: Colors.black12,
            child: Text(
              movie.title,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            )),
        background: FadeInImage(
          placeholder: AssetImage('images/loading.gif'),
          image: NetworkImage(movie.fullBackdropPath),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class _PosterAndTitle extends StatelessWidget {
  final movie;
  const _PosterAndTitle({Key? key, required this.movie}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      margin: EdgeInsets.only(top: 20),
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: FadeInImage(
              placeholder: AssetImage('images/no-image.jpg'),
              image: NetworkImage(movie.fullPosterImage),
              height: 150,
            ),
          ),
          SizedBox(
            width: 20,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ConstrainedBox(
                constraints: BoxConstraints(maxWidth: size.width - 200),
                child: Text(
                  movie.title,
                  style: textTheme.headline5,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 3,
                ),
              ),
              ConstrainedBox(
                constraints: BoxConstraints(maxWidth: size.width - 200),
                child: Text(
                  movie.originalTitle,
                  style: textTheme.subtitle1,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
              Row(
                children: [
                  Icon(
                    Icons.star_outline,
                    size: 15,
                    color: Colors.grey,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    movie.voteAverage.toString(),
                    style: textTheme.caption,
                  )
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}

class _Overview extends StatelessWidget {
  final movie;
  const _Overview({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: Text(
        movie.overview,
        textAlign: TextAlign.justify,
        style: Theme.of(context).textTheme.subtitle1,
      ),
    );
  }
}
