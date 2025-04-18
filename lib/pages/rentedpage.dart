import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/preferenceprovider.dart';
import '../components/moviecard.dart';
import '../pages/watchpage.dart';

class RentedPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Rented Movies')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Consumer<PreferenceProvider>(
          builder: (context, provider, _) {
            final rentedMovies = provider.rentedMovies;
            if (rentedMovies.isEmpty) {
              return Center(child: Text('No rented movies.'));
            }
            return ListView.builder(
              itemCount: rentedMovies.length,
              itemBuilder: (context, index) {
                final movie = rentedMovies[index];
                return MovieCard(
                  movie: movie,
                  buttonLabel: 'Watch',
                  onButtonPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => WatchPage(movie: movie),
                      ),
                    );
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}
