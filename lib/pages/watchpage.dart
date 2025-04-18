import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';
import '../data/movie.dart';
import '../providers/preferenceprovider.dart';

class WatchPage extends StatefulWidget {
  final RentedMovie movie;

  const WatchPage({super.key, required this.movie});

  @override
  State<WatchPage> createState() => _WatchPageState();
}

class _WatchPageState extends State<WatchPage> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(
        Uri.parse(
          'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4',
        ),
      )
      ..initialize().then((_) {
        setState(() {});
        _controller.play();
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _markAsWatched(BuildContext context) async {
    final provider = Provider.of<PreferenceProvider>(context, listen: false);
    await provider.removeRentedMovie(widget.movie);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    bool isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.movie.title),
        actions: [
          IconButton(
            icon: Icon(Icons.check),
            onPressed: () => _markAsWatched(context),
          ),
        ],
      ),
      body: Center(
        child:
            _controller.value.isInitialized
                ? SizedBox(
                  width:
                      isLandscape
                          ? MediaQuery.of(context).size.width
                          : MediaQuery.of(context).size.width * 0.9,
                  height:
                      isLandscape ? MediaQuery.of(context).size.height : 200,
                  child: VideoPlayer(_controller),
                )
                : CircularProgressIndicator(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _controller.value.isPlaying
                ? _controller.pause()
                : _controller.play();
          });
        },
        child: Icon(
          _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
        ),
      ),
    );
  }
}
