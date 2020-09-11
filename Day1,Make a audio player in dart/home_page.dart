import 'package:audioplayers/audioplayers.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  AudioPlayer _audioPlayer = AudioPlayer();
  bool isplaying = false;
  String currtime = "00:00";
  String comtime = "00:00";
  void initState() {
    super.initState();
    _audioPlayer.onAudioPositionChanged.listen((Duration duration) {
      setState(() {
        currtime = duration.toString().split(".")[0];
      });
    });
    _audioPlayer.onDurationChanged.listen((Duration duration) {
      setState(() {
        comtime = duration.toString().split(".")[0];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(),
            )
          ],
        ),
      ),
      appBar: AppBar(
        title: Text(
          "Music Player",
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
            iconSize: 20,
          )
        ],
      ),
      backgroundColor: Colors.black26,
      body: Stack(
        children: <Widget>[
          Image.asset(
            "assets/music.jpg",
            width: 400,
            height: 700,
          ),
          Container(
            width: MediaQuery.of(context).size.width * 2,
            height: 100,
            margin: EdgeInsets.only(
                top: MediaQuery.of(context).size.width * 1.3,
                right: MediaQuery.of(context).size.width * 0.02),
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(50),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                IconButton(
                  icon: Icon(
                    Icons.skip_previous,
                    color: Colors.white,
                  ),
                  onPressed: () {},
                ),
                IconButton(
                  icon: Icon(
                    isplaying ? Icons.pause : Icons.play_arrow,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    if (isplaying) {
                      _audioPlayer.pause();
                      setState(() {
                        isplaying = false;
                      });
                    } else {
                      _audioPlayer.resume();
                      setState(() {
                        isplaying = true;
                      });
                    }
                  },
                ),
                Text(
                  currtime,
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
                Text("|"),
                Text(
                  comtime,
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
                IconButton(
                  icon: Icon(
                    Icons.stop,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    _audioPlayer.stop();
                    setState(() {
                      isplaying = false;
                    });
                  },
                ),
                IconButton(
                  icon: Icon(
                    Icons.skip_next,
                    color: Colors.white,
                  ),
                  onPressed: () {},
                ),
              ],
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.audiotrack),
        onPressed: () async {
          String filepath = await FilePicker.getFilePath();
          int status = await _audioPlayer.play(filepath, isLocal: true);
          if (status == 1) {
            setState(() {
              isplaying = true;
            });
          }
        },
      ),
    );
  }
}
