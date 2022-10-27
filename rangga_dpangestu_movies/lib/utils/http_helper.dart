import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:rangga_dpangestu_movie_app/model/movie.dart';

class HttpHelper {
  final String urlKey = "api_key=a64c1432d61d8f3d0280c4cf13841601";
  final String urlBase = "https://api.themoviedb.org/3/movie";
  final String urlUpcoming = "/upcoming?";
  final String urlLanguage = "&languange=en-US";

  // final String urlSearchBase =
  //     'https://api.themoviedb.org/3/search/movie?api_key=a64c1432d61d8f3d0280c4cf13841601&query=';
  final String urlBaseSearch = 'https://api.themoviedb.org/3/search';
  final String urlMovie = '/movie?';
  final String urlQuery = '&query=';

  Future<List> getUpcoming() async {
    final String upcoming = urlBase + urlUpcoming + urlKey + urlLanguage;
    debugPrint(upcoming);

    http.Response result = await http.get(Uri.parse(upcoming));

    if (result.statusCode == HttpStatus.ok) {
      final jsonResponse = json.decode(result.body);
      final moviesMap = jsonResponse['results'];
      List movies = moviesMap.map((i) => Movie.fromJson(i)).toList();

      return movies;
    } else {
      return [];
    }
  }

//mengambil data api berupa list
  Future<List> findMovies(String title) async {
    // ada parameter karena harus ada yang diinput yaitu title (String title)
    final String query = urlBaseSearch + urlMovie + urlKey + urlQuery + title;
    http.Response result = await http.get(Uri.parse(query));
    debugPrint(query);

    if (result.statusCode == HttpStatus.ok) {
      final jsonResponse = json.decode(result.body);
      final moviesMap = jsonResponse['results'];
      List movies = moviesMap.map((i) => Movie.fromJson(i)).toList();

      return movies;
    } else {
      return [];
    }
  }
}
