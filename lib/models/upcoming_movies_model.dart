// To parse this JSON data, do
//
//     final upcomingMovieResponse = upcomingMovieResponseFromMap(jsonString);

import 'dart:convert';

import 'models.dart';

import 'package:pizzabloc/models/dates_model.dart';

class UpcomingMovieResponse {
  UpcomingMovieResponse({
    required this.dates,
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  Dates dates;
  int page;
  List<Movie> results;
  int totalPages;
  int totalResults;

  factory UpcomingMovieResponse.fromJson(String str) =>
      UpcomingMovieResponse.fromMap(json.decode(str));

  factory UpcomingMovieResponse.fromMap(Map<String, dynamic> json) =>
      UpcomingMovieResponse(
        dates: Dates.fromMap(json["dates"]),
        page: json["page"],
        results: List<Movie>.from(json["results"].map((x) => Movie.fromMap(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
      );
}
