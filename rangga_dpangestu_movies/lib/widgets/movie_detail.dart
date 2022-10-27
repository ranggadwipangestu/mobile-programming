import 'package:flutter/material.dart';
import 'package:rangga_dpangestu_movie_app/model/movie.dart';

class MovieDetail extends StatelessWidget {
  final Movie movie;
  const MovieDetail({Key? key, required this.movie}) : super(key: key);

  final String imgPath = 'https://image.tmdb.org/t/p/w500/';

  @override
  Widget build(BuildContext context) {
    String path;
    // ignore: unnecessary_null_comparison
    if (movie.posterPath == null || movie.posterPath == 'null') {
      path =
          'https://images.freeimages.com/images/large-previews/5eb/movie-clapboard-1184339.jpg';
    } else {
      path = imgPath + (movie.posterPath ?? '');
    }

    double height = MediaQuery.of(context)
        .size
        .height; //untuk mendapatkan tinggi atau lebar layar

    return Scaffold(
      appBar: AppBar(
        title: Text(movie.title ?? ''),
      ),
      body: SingleChildScrollView(
        child: Center(
            child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              height: height / 1.5,
              child: Image.network(path),
            ),
            Container(
              padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
              child: Text(movie.overview ?? ''),
            )
          ],
        )),
      ),
    );
  }
}
