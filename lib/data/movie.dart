class RentedMovie {
  final String title;
  final String? id;
  final String? posterUrl;
  final num popularity;
  final String releaseDate;

  RentedMovie({
    required this.title,
    required this.id,
    this.posterUrl,
    required this.popularity,
    required this.releaseDate,
  });

  factory RentedMovie.fromJson(Map<String, dynamic> json) {
    return RentedMovie(
      title: json['title'] ?? 'No Title',
      id: json['id']?.toString(),
      posterUrl: json['poster_path'],
      popularity: json['popularity'] ?? 0,
      releaseDate: json['release_date'] ?? 'Unknown',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'id': id,
      'poster_path': posterUrl,
      'popularity': popularity,
      'release_date': releaseDate,
    };
  }
}
