// ignore_for_file: unnecessary_this

class Movie {
  int? id;
  String? title;
  String? voteAverage;
  String? releaseDate;
  String? overview;
  String? posterPath;

  Movie(this.id, this.title, this.voteAverage, this.releaseDate, this.overview,
      this.posterPath);

  Movie.fromJson(Map<String, dynamic> parsedJson) {
    id = parsedJson['id'];
    title = parsedJson['title'];
    voteAverage = parsedJson['vote_average'].toString();
    releaseDate = parsedJson['release_date'];
    overview = parsedJson['overview'];
    posterPath = parsedJson['poster_path'];
  }
}
