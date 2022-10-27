// ignore_for_file: unnecessary_this

import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:rangga_dpangestu_movie_app/model/movie.dart';
import 'package:rangga_dpangestu_movie_app/utils/http_helper.dart';
import 'package:rangga_dpangestu_movie_app/widgets/movie_detail.dart';

class MovieList extends StatefulWidget {
  const MovieList({Key? key}) : super(key: key);

  @override
  State<MovieList> createState() => _MovieListState();
}

class _MovieListState extends State<MovieList> {
  final String iconBase = 'https://image.tmdb.org/t/p/w92/';
  final String defaultImage =
      'https://images.freeimages.com/images/large-previews/5eb/movie-clapboard-1184339.jpg';

  String result = '';
  int moviesCount = 0;
  List movies = [];
  late HttpHelper httpHelper;

  Icon visibleIcon = const Icon(Icons.search);
  Widget searchBar = const Text('Movies App Rangga');

  @override
  void initState() {
    httpHelper = HttpHelper();
    initialize();

    super.initState();
  }

  Future search(title) async {
    movies = await httpHelper.findMovies(title);
    setState(() {
      moviesCount = movies.length;
      movies = movies;
    });
  }

  Future initialize() async {
    movies = await httpHelper.getUpcoming();
    setState(() {
      moviesCount = movies.length;
      movies = movies;
    });
  }

  @override
  Widget build(BuildContext context) {
    NetworkImage image;
    return Scaffold(
        appBar: AppBar(
          title: searchBar,
          actions: <Widget>[
            // action button yang akan tampil di bagian atas
            IconButton(
                onPressed: () {
                  setState(() {
                    if (this.visibleIcon.icon == Icons.search) {
                      setState(() {
                        this.searchBar = TextField(
                          textInputAction: TextInputAction.search,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                          ),
                          onSubmitted: (title) {
                            search(title);
                          },
                        );
                        this.visibleIcon = const Icon(Icons.cancel);
                      });
                    } else {
                      setState(() {
                        this.visibleIcon = const Icon(Icons.search);
                        this.searchBar = const Text('Movies App Rangga');
                        initialize();
                      });
                    }
                  });
                },
                icon: visibleIcon)
          ],
        ),
        //
        //
        body: RefreshIndicator(
          //pulldown refresh
          onRefresh: initialize,
          child: ListView.builder(
            itemCount: moviesCount,
            itemBuilder: (context, position) {
              if (movies[position].posterPath == null ||
                  movies[position].posterPath == 'null') {
                image = NetworkImage(defaultImage);
              } else {
                image = NetworkImage(iconBase + movies[position].posterPath);
              }
              return Card(
                color: Colors.white,
                elevation: 2.0,
                child: ListTile(
                  leading: CircleAvatar(backgroundImage: image),
                  title: Text(movies[position].title),
                  subtitle: Text(
                      'Released date : ${movies[position].releaseDate} - Vote : ${movies[position].voteAverage.toString()}'),
                  onTap: () {
                    MaterialPageRoute route = MaterialPageRoute(
                        builder: (context) => MovieDetail(
                              movie: movies[position],
                            ));
                    Navigator.push(context, route);
                  },
                ),
              );
            },
          ),
        ));
  }
}
