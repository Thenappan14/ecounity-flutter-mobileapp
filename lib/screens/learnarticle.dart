import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter_tts/flutter_tts.dart';

class LearnArticleScreen extends StatefulWidget {
  static String routeName = '/learnarticle';

  @override
  _LearnArticleScreenState createState() => _LearnArticleScreenState();
}

class _LearnArticleScreenState extends State<LearnArticleScreen> {
  late VideoPlayerController _controller;
  bool _isPlaying = true;
  FlutterTts flutterTts = FlutterTts();

  final String articleText =
      "With so much focus on sustainability, it can be a challenge to weave through the maze. Our Sustainability Gameplan Series breaks it down simply so you can make the right moves. Capturing opportunities in the multi-billion-dollar green economy can feel like having to dribble though a wall of obstacles. From product innovation to commercialisation, businesses and startups with a sustainability solution often face a host of hurdles including raising funds and resources for R&D, establishing a track record, and gaining traction. But here’s one thing that some successful businesses have in common: partnerships. It’s a key strategy to accelerate your solutions by allowing you to pool expertise and ideas and expand your network. Last year, SC Auto unveiled its first electric bus to be built in Singapore, making the leap from private transport operator to manufacturer – thanks to a strategic partnership with Volvo Buses, which enabled both companies to leverage complementary strengths.";

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset('images/learn.mp4')
      ..initialize().then((_) {
        setState(() {});
        _controller.play();
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    flutterTts.stop(); // Stop TTS when disposing
    super.dispose();
  }

  void _togglePlayPause() {
    setState(() {
      if (_controller.value.isPlaying) {
        _controller.pause();
        _isPlaying = false;
      } else {
        _controller.play();
        _isPlaying = true;
      }
    });
  }

  void _speak() async {
    await flutterTts.speak(articleText);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Sustainability',
          style: TextStyle(color: Colors.white), // Set the text color to white
        ),
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      backgroundColor: Colors.black,
      body: ListView(
        padding: EdgeInsets.all(8.0),
        children: [
          Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    _controller.value.isInitialized
                        ? AspectRatio(
                            aspectRatio: _controller.value.aspectRatio,
                            child: VideoPlayer(_controller),
                          )
                        : Container(
                            height: 200,
                            width: 250,
                            color: Colors.black,
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          ),
                    Positioned(
                      bottom: 10,
                      right: 10,
                      child: FloatingActionButton(
                        onPressed: _togglePlayPause,
                        child: Icon(
                          _isPlaying ? Icons.pause : Icons.play_arrow,
                        ),
                        backgroundColor: Colors.blue,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Text(
                        "Sustainability is a team sport\nhere's why!",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: IconButton(
                        icon: Icon(Icons.volume_up, color: Colors.white),
                        onPressed: _speak,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    articleText,
                    style: TextStyle(color: Colors.white),
                    textAlign: TextAlign.left,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
