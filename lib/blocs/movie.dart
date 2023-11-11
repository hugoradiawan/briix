class Movie {
  late String id, title, director, summary;
  late List<String> genres;

  Movie({
    required this.id,
    required this.title,
    required this.director,
    required this.summary,
    required this.genres,
  });

  Movie.empty() {
    id = '';
    title = '';
    director = '';
    summary = '';
    genres = [];
  }

  Movie.fromJson(Map<String, dynamic> data)
      : id = data['id'],
        title = data['title'],
        director = data['director'],
        summary = data['summary'],
        genres = data['genres'] == null ? [] : data['genres'].cast<String>();

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'director': director,
        'summary': summary,
        'genres': genres,
      };
}
