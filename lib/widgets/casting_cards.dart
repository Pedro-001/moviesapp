import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pizzabloc/providers/movies_provider.dart';
import 'package:pizzabloc/providers/movies_provider.dart';
import 'package:provider/provider.dart';

import '../models/models.dart';

class CastingCards extends StatelessWidget {
  final int movieId;
  const CastingCards({Key? key, required this.movieId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final moviesProvider = Provider.of<MoviesProvider>(context, listen: false);

    return FutureBuilder(
        future: moviesProvider.getMovieCast(movieId),
        builder: (BuildContext context, AsyncSnapshot<List<Cast>> snapshot) {
          if (!snapshot.hasData) {
            return Container(
              constraints: BoxConstraints(maxWidth: 50),
              height: 180,
              child: CupertinoActivityIndicator(),
            );
          }
          final List<Cast> cast = snapshot.data!;
          return Container(
            width: double.infinity,
            height: 180,
            margin: EdgeInsets.only(bottom: 30),
            child: ListView.builder(
              itemCount: cast.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index) {
                return _CastCard(actor: cast[index]);
              },
            ),
          );
        });
  }
}

class _CastCard extends StatelessWidget {
  final Cast actor;
  const _CastCard({Key? key, required this.actor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      width: 110,
      height: 100,
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: FadeInImage(
              placeholder: AssetImage('images/no-image.jpg'),
              image: NetworkImage(actor.fullProfilePathImage),
              height: 140,
              width: 100,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            actor.name,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          ),
          Expanded(
            child: Text(
              actor.character ?? '',
              maxLines: 1,
              overflow: TextOverflow.clip,
              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
    );
  }
}
