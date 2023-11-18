import 'package:flutter/material.dart';
import 'package:flutter_intro/ui_views/sound_player.dart';

class Calm extends StatelessWidget {
  List<SoundList> soundList = getSounds();

  static List<SoundList> getSounds() {
    const data = [
      {
        "title": "Rain",
        "image": "images/calm_nature_rain.png",
        "sound": "sounds/sound_nature_rain.mp3",
      },
      {
        "title": "Peaceful River",
        "image": "images/calm_nature_stream.png",
        "sound": "sounds/sound_nature_waterstream.mp3",
      },
      {
        "title": "Ocean Waves",
        "image": "images/calm_nature_ocean.png",
        "sound": "sounds/sound_nature_oceanwavebirds.mp3",
      },
      {
        "title": "Crickets",
        "image": "images/calm_nature_cricket.png",
        "sound": "sounds/sound_nature_cricket.mp3",
      },
    ];
    return data.map<SoundList>(SoundList.fromJson).toList();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraint) {
      double appBarHeight = 60;
      double mainBodyHeight = constraint.maxHeight - appBarHeight;
      double mainBodyWidth = constraint.maxWidth;
      double natureHeight = mainBodyHeight / 3;
      return Scaffold(
        appBar: AppBar(
          toolbarHeight: appBarHeight,
          automaticallyImplyLeading: false,
          leading: SizedBox(
            width: 20,
            height: 20,
            child: Padding(
              padding: EdgeInsets.only(bottom: 3.0, left: 11.0),
              child: IconButton(
                icon: const Icon(
                  Icons.arrow_back,
                  size: 30,
                  color: Colors.black87,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ),
        ),
        body: Container(
          width: mainBodyWidth,
          height: mainBodyHeight,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                child: SizedBox(
                    width: mainBodyWidth,
                    child: Text(
                      "Meditation",
                      style: TextStyle(
                          color: Colors.teal,
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                    )),
              ),
              Divider(),
              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                child: SizedBox(
                    width: mainBodyWidth,
                    child: Text(
                      "Browse through our list of curated mediation music to help you relax",
                      style: TextStyle(
                          color: Colors.black54,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    )),
              ),
              //Container(width: mainBodyWidth, height: natureHeight, child),
              SizedBox(height: 20),
              Container(
                width: mainBodyWidth,
                height: natureHeight,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                      child: SizedBox(
                          width: constraint.maxWidth,
                          child: Text(
                            "Nature Sounds",
                            style: TextStyle(fontSize: 20),
                          )),
                    ),
                    Divider(),
                    Container(
                        width: mainBodyWidth - 20,
                        height: (natureHeight / 4) * 3,
                        child: buildNatureList(soundList)),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget buildNatureList(List<SoundList> natureList) => ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: natureList.length,
        itemBuilder: (context, index) {
          final nature = natureList[index];
          return LayoutBuilder(builder: (context, constraint) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 150,
                  height: 150,
                  child: SoundCard(
                    title: nature.title,
                    imgFile: nature.imgFile,
                    soundFile: nature.soundFile,
                  ),
                ),
              ],
            );
          });
        },
      );
}

class SoundCard extends StatelessWidget {
  final String title;
  final String imgFile;
  final String soundFile;

  const SoundCard(
      {required this.title, required this.imgFile, required this.soundFile});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraint) {
      double imgHeight = (constraint.maxHeight / 4) * 3;
      return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: ((context) => SoundPlayer(soundFile: soundFile))));
        },
        child: Container(
          width: constraint.maxWidth,
          height: constraint.maxHeight,
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 2.0),
                  child: SizedBox(
                    width: constraint.maxWidth,
                    height: imgHeight,
                    child: Image.asset(
                      imgFile,
                      width: constraint.maxWidth,
                      height: imgHeight,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                Text(title),
              ],
            ),
          ),
        ),
      );
    });
  }
}

class SoundList {
  final String title;
  final String imgFile;
  final String soundFile;

  const SoundList({
    required this.title,
    required this.imgFile,
    required this.soundFile,
  });

  factory SoundList.fromJson(Map<String, dynamic> json) {
    String def_title;
    String def_imgFile;
    String def_soundFile;

    def_title = json['title'] ?? '';
    def_imgFile = json['image'] ?? '';
    def_soundFile = json['sound'] ?? '';

    return SoundList(
      title: def_title as String,
      imgFile: def_imgFile as String,
      soundFile: def_soundFile as String,
    );
  }
}
