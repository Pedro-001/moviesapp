import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:pizzabloc/helpers/debouncer.dart';
import 'package:pizzabloc/models/search_movies_model.dart';

import '../models/models.dart';

class MoviesProvider extends ChangeNotifier {
  String _apiKey = '196e6250c8b6831992e8bea115d77612';
  String _baseUrl = 'api.themoviedb.org';
  String _language = 'es-ES';
  String _region = "MX";
  List<Movie> onDisplayMovies = [];
  List<Movie> popularMovies = [];
  List<Movie> upComingMovies = [];
  List<Movie> actionMovies = [];
  List<Movie> adventureMovies = [];
  List<Movie> animationMovies = [];
  List<Movie> comedyMovies = [];
  List<Movie> crimeMovies = [];
  //List<Movie> documentaryMovies = [];
  List<Movie> dramaMovies = [];
  List<Movie> familyMovies = [];
  List<Movie> fantasyMovies = [];
  List<Movie> historyMovies = [];
  List<Movie> horrorMovies = [];
  List<Movie> musicMovies = [];
  List<Movie> misteryMovies = [];
  List<Movie> romanceMovies = [];
  List<Movie> scifiMovies = [];
  List<Movie> thrillerMovies = [];
  List<Movie> warMovies = [];
  List<Movie> westernMovies = [];

  Map<int, List<Cast>> moviesCast = {};

  int popularPage = 0;
  int actionPage = 0;
  int adventurePage = 0;
  int comedyPage = 0;
  int animatePage = 0;
  int crimePage = 0;
  //int documentaryPage = 0;
  int dramaPage = 0;
  int familyPage = 0;
  int fantasyPage = 0;
  int historyPage = 0;
  int horrorPage = 0;
  int musicPage = 0;
  int misteryPage = 0;
  int romancePage = 0;
  int scifiPage = 0;
  int thrillerPage = 0;
  int warPage = 0;
  int westernPage = 0;
  final StreamController<List<Movie>> _suggestionStreamController =
      new StreamController.broadcast();
  Stream<List<Movie>> get suggestionStream =>
      this._suggestionStreamController.stream;

  final debouncer = Debouncer(duration: Duration(milliseconds: 500));

  MoviesProvider() {
    print('MovioesProvider Incializado');
    getOnDisplayMovies();
    getPopularMovies();
    getUpcomingMovies();
    getMoviesAction();
    getMoviesComedy();
    getMoviesAdventure();
    getMoviesCrime();
    getMoviesAnimated();
    getMoviesDrama();
    getMoviesFamily();
    getMoviesFantasy();
    getMoviesHorror();
    getMoviesScriFi();
  }

  _getJsonData(String endpoint, [int page = 1]) async {
    //Construcción del url
    final url = Uri.https(_baseUrl, endpoint,
        {'api_key': _apiKey, 'language': _language, 'page': '$page'});
    //Await the http get response, then decode the json-formatted response.
    final response = await http.get(url);
    return response.body;
  }

  getOnDisplayMovies() async {
    final url = Uri.https(_baseUrl, '3/movie/now_playing', {
      'api_key': _apiKey,
      'language': _language,
      'page': '1',
      'region': 'MX'
    });
    print(url);
    final jsonData = await http.get(url);
    final nowPlayingResponse = NowPlayingResponse.fromJson(jsonData.body);

    //onDisplayMovies = [...onDisplayMovies, ...nowPlayingResponse.results];
    for (var i = 0; i < nowPlayingResponse.results.length; i++) {
      if (nowPlayingResponse.results[i].voteAverage > 1) {
        onDisplayMovies.add(nowPlayingResponse.results[i]);
      }
    }
    notifyListeners();
  }

  getUpcomingMovies() async {
    final url = Uri.https(_baseUrl, '3/movie/upcoming', {
      'api_key': _apiKey,
      'language': _language,
      'page': '1',
      'region': 'MX'
    });
    final jsonData = await http.get(url);
    final upcomingMovieResponse = UpcomingMovieResponse.fromJson(jsonData.body);
    upComingMovies = [...upComingMovies, ...upcomingMovieResponse.results];
    notifyListeners();
  }

  getPopularMovies() async {
    popularPage++;
    final jsonData = await this._getJsonData('3/movie/popular', popularPage);
    final popularResponse = PopularResponse.fromJson(jsonData);
    popularMovies = [...popularMovies, ...popularResponse.results];
    notifyListeners();
  }

  Future<List<Cast>> getMovieCast(int movieId) async {
    if (moviesCast.containsKey(movieId)) return moviesCast[movieId]!;
    print('Info servidor actores');
    final jsonData = await this._getJsonData('3/movie/${movieId}/credits');
    final creditsResponse = CreditsResponse.fromJson(jsonData);
    moviesCast[movieId] = creditsResponse.cast;
    return creditsResponse.cast;
  }

  Future<List<Movie>> searchMovie(String query, [int page = 1]) async {
    final url = Uri.https(_baseUrl, '3/search/movie', {
      'api_key': _apiKey,
      'language': _language,
      'query': query,
    });
    final response = await http.get(url);
    final searchResponse = SearchMovieResponse.fromJson(response.body);
    return searchResponse.results;
  }

  void getSuggestionsbyQuery(String searchTerm) {
    debouncer.value = '';
    debouncer.onValue = (value) async {
      final results = await this.searchMovie(value);
      this._suggestionStreamController.add(results);
    };

    final timer = Timer.periodic(Duration(milliseconds: 300), (_) {
      debouncer.value = searchTerm;
    });

    Future.delayed(Duration(milliseconds: 301)).then((_) => timer.cancel());
  }

  getMoviesAction() async {
    actionPage++;
    final jsonData = await this._getJsonData('3/movie/popular', actionPage);
    final moviesByGenre = await PopularResponse.fromJson(jsonData);
    actionMovies = [
      ...actionMovies,
      ...moviesByGenre.results.where((movies) => movies.genreIds.contains(28))
    ];
    notifyListeners();
  }

  getMoviesAdventure() async {
    adventurePage++;
    final jsonData = await this._getJsonData('3/movie/popular', adventurePage);
    final moviesByGenre = PopularResponse.fromJson(jsonData);
    adventureMovies = [
      ...adventureMovies,
      ...moviesByGenre.results.where((e) => e.genreIds.contains(12))
    ];
    print('cantidad de peliculas: ' + adventureMovies.length.toString());

    notifyListeners();
  }

  getMoviesComedy() async {
    comedyPage++;
    final jsonData = await this._getJsonData('3/movie/popular', comedyPage);
    final moviesByGenre = PopularResponse.fromJson(jsonData);
    comedyMovies = [
      ...comedyMovies,
      ...moviesByGenre.results.where((e) => e.genreIds.contains(35))
    ];
    notifyListeners();
  }

  getMoviesCrime() async {
    crimePage++;
    final jsonData = await this._getJsonData('3/movie/popular', crimePage);
    final moviesByGenre = PopularResponse.fromJson(jsonData);
    crimeMovies = [
      ...crimeMovies,
      ...moviesByGenre.results.where((e) => e.genreIds.contains(80))
    ];
    notifyListeners();
  }

  getMoviesAnimated() async {
    animatePage++;
    final jsonData = await this._getJsonData('3/movie/popular', animatePage);
    final moviesByGenre = PopularResponse.fromJson(jsonData);
    animationMovies = [
      ...animationMovies,
      ...moviesByGenre.results.where((e) => e.genreIds.contains(16))
    ];
    notifyListeners();
  }

  getMoviesDrama() async {
    dramaPage++;

    if (dramaMovies.length < 5) {
      for (int i = 1; i < 5; i++) {
        final jsonData = await this._getJsonData('3/movie/popular', i);
        final moviesByGenre = PopularResponse.fromJson(jsonData);
        dramaMovies = [
          ...dramaMovies,
          ...moviesByGenre.results.where((e) => e.genreIds.contains(18))
        ];
      }
      dramaPage = 5;
    }
    final jsonData = await this._getJsonData('3/movie/popular', dramaPage);
    final moviesByGenre = PopularResponse.fromJson(jsonData);
    dramaMovies = [
      ...dramaMovies,
      ...moviesByGenre.results.where((e) => e.genreIds.contains(18))
    ];
    notifyListeners();
  }

  getMoviesFamily() async {
    familyPage++;
    final jsonData = await this._getJsonData('3/movie/popular', familyPage);
    final moviesByGenre = PopularResponse.fromJson(jsonData);
    familyMovies = [
      ...familyMovies,
      ...moviesByGenre.results.where((e) => e.genreIds.contains(10751))
    ];
    notifyListeners();
  }

  getMoviesFantasy() async {
    fantasyPage++;
    final jsonData = await this._getJsonData('3/movie/popular', fantasyPage);
    final moviesByGenre = PopularResponse.fromJson(jsonData);
    fantasyMovies = [
      ...fantasyMovies,
      ...moviesByGenre.results.where((e) => e.genreIds.contains(14))
    ];
    notifyListeners();
  }

  getMoviesHorror() async {
    horrorPage++;
    if (horrorMovies.length < 5) {
      for (int i = 1; i < 5; i++) {
        final jsonData = await this._getJsonData('3/movie/popular', i);
        final moviesByGenre = PopularResponse.fromJson(jsonData);
        horrorMovies = [
          ...horrorMovies.toSet(),
          ...moviesByGenre.results.where((e) => e.genreIds.contains(27))
        ];
      }
      horrorPage = 5;
    }
    final jsonData = await this._getJsonData('3/movie/popular', horrorPage);
    final moviesByGenre = PopularResponse.fromJson(jsonData);

    horrorMovies = [
      ...horrorMovies.toSet(),
      ...moviesByGenre.results.where((e) => e.genreIds.contains(27))
    ];
    notifyListeners();
  }

  getMoviesScriFi() async {
    scifiPage++;
    final jsonData = await this._getJsonData('3/movie/popular', scifiPage);
    final moviesByGenre = PopularResponse.fromJson(jsonData);
    scifiMovies = [
      ...scifiMovies,
      ...moviesByGenre.results.where((e) => e.genreIds.contains(878))
    ];
    notifyListeners();
  }
}
