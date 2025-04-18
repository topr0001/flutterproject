import 'package:flutter/material.dart';
import '../data/movie.dart';

class MovieCard extends StatelessWidget {
  final RentedMovie movie;
  final String buttonLabel;
  final VoidCallback onButtonPressed;

  const MovieCard({
    required this.movie,
    required this.buttonLabel,
    required this.onButtonPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.secondary,
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Row(
          children: [
            Image.network(
              movie.posterUrl != null
                  ? 'https://image.tmdb.org/t/p/w200${movie.posterUrl}'
                  : 'https://s3-ap-southeast-1.amazonaws.com/popcornsg/placeholder-movieimage.png',
              width: 100,
              height: 150,
              fit: BoxFit.cover,
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                children: [
                  Text(
                    movie.title,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  SizedBox(height: 8),
                  Text('Popularity: ${movie.popularity}'),
                  Text('Release Date: ${movie.releaseDate}'),
                  SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: onButtonPressed,
                    child: Text(buttonLabel),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
