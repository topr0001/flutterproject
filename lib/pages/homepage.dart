import 'dart:math';
import 'package:flutter/material.dart';
import '../data/movie.dart';
import '../data/httphelper.dart';
import '../providers/preferenceprovider.dart';
import '../components/moviecard.dart';
import '../pages/rentedpage.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _keywordController = TextEditingController();
  List<RentedMovie> searchResults = [];

  void _search() async {
    Navigator.of(context).pop();
    String keyword = _keywordController.text;
    var results = await HttpHelper.searchMovies(keyword);

    final preferenceProvider = Provider.of<PreferenceProvider>(
      context,
      listen: false,
    );
    await preferenceProvider.getRentedMovies();

    List<RentedMovie> rentedMovies = preferenceProvider.rentedMovies;

    results.removeWhere(
      (movie) => rentedMovies.any((rentedMovie) => rentedMovie.id == movie.id),
    );

    setState(() {
      searchResults = results;
    });

    if (results.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('No movies found')));
    }
  }

  void _showSearchDialog() {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text('Search Movies'),
            content: TextField(
              controller: _keywordController,
              decoration: InputDecoration(labelText: 'Enter keyword'),
            ),
            actions: [
              TextButton(child: Text('Search'), onPressed: _search),
              TextButton(
                child: Text('Cancel'),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
    );
  }

  void _showRentDialog(RentedMovie movie) {
    double randomPrice = (Random().nextDouble() * 10) + 5;
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text(movie.title),
            content: Text(
              'Rent this movie for \$${randomPrice.toStringAsFixed(2)}?',
            ),
            actions: [
              TextButton(
                onPressed: () async {
                  final preferenceProvider = Provider.of<PreferenceProvider>(
                    context,
                    listen: false,
                  );
                  await preferenceProvider.addRentedMovie(movie);
                  setState(() {
                    searchResults.removeWhere((m) => m.id == movie.id);
                  });

                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text('Movie rented!')));
                },
                child: Text('Confirm'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text('Cancel'),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Movie App'),
        actions: [
          IconButton(
            icon: Icon(Icons.movie),
            onPressed: () {
              Navigator.of(
                context,
              ).push(MaterialPageRoute(builder: (context) => RentedPage()));
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            if (searchResults.isEmpty)
              Text(
                'Welcome!\nHit the search button to search for movies!',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: searchResults.length,
                itemBuilder: (context, index) {
                  final movie = searchResults[index];
                  return MovieCard(
                    movie: movie,
                    buttonLabel: 'Rent',
                    onButtonPressed: () => _showRentDialog(movie),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showSearchDialog,
        child: Icon(Icons.search),
      ),
    );
  }
}
