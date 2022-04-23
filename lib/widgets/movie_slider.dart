import 'package:flutter/material.dart';
import 'package:pizzabloc/screens/details_screen.dart';

import '../models/models.dart';

class MoviesSlider extends StatefulWidget {
  final String? title;
  final List<Movie> moviesList;
  final Function onNextPage;

  const MoviesSlider({
    Key? key,
    this.title,
    required this.moviesList,
    required this.onNextPage,
  }) : super(key: key);

  @override
  State<MoviesSlider> createState() => _MoviesSliderState();
}

class _MoviesSliderState extends State<MoviesSlider> {
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    scrollController.addListener(() {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent - 500) {
        this.widget.onNextPage();
        print('Obtener siguiente pagina');
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 280,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          widget.title == null
              ? Container()
              : Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    widget.title!,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
          SizedBox(
            height: 5,
          ),
          Expanded(
            child: ListView.builder(
              controller: scrollController,
              scrollDirection: Axis.horizontal,
              itemCount: widget.moviesList.length,
              itemBuilder: (BuildContext context, int index) {
                final movie = widget.moviesList[index];
                return _MoviePoster(
                  popularMovie: movie,
                );
              },
            ),
          )
        ],
      ),
    );
  }
}

class _MoviePoster extends StatelessWidget {
  final Movie popularMovie;
  const _MoviePoster({
    Key? key,
    required this.popularMovie,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 130,
      height: 190,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          GestureDetector(
            onTap: (() => Navigator.pushNamed(context, DetailsScreen.routerName,
                arguments: popularMovie)),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: FadeInImage(
                placeholder: AssetImage('images/no-image.jpg'),
                image: NetworkImage(popularMovie.fullPosterImage),
                width: 130,
                height: 180,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            popularMovie.title,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
