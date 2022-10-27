import 'package:flutter/material.dart';
import 'package:rangga_dpangestu_movie_app/widgets/movie_list.dart';

void main(List<String> args) => runApp(const MyMovies());

class MyMovies extends StatelessWidget {
  const MyMovies({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "My Movies",
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const Home(),
    );
  }
}

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MovieList();
  }
}
