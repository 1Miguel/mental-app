import 'package:flutter/material.dart';
import 'package:flutter_intro/controllers/mood_controller.dart';
import 'package:flutter_intro/utils/colors_scheme.dart';
import 'package:timeline_tile/timeline_tile.dart';

// Local import
import 'package:flutter_intro/model/mood.dart';

// Third-party import
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';

class MoodTimeline extends StatelessWidget {
  int dominantMood = 0;
  int percentage = 0;
  MoodController moodController = Get.put(MoodController());
  late Future<List<Mood>> futureMoodHistory;

  MoodTimeline({
    super.key,
    required this.dominantMood,
    required this.percentage,
  });

  Future<List<Mood>> getMoodHistory() async {
    futureMoodHistory = moodController.fetchMoodHistory(DateTime.now());
    print(futureMoodHistory);
    return futureMoodHistory;
  }

  IconData getDominantMoodIcon() {
    if (dominantMood == 0) {
      return Icons.sentiment_very_satisfied;
    }
    if (dominantMood == 1) {
      return Icons.sentiment_satisfied;
    }
    if (dominantMood == 2) {
      return Icons.sentiment_neutral;
    }
    if (dominantMood == 3) {
      return Icons.sentiment_dissatisfied;
    }
    return Icons.sentiment_very_dissatisfied;
  }

  Color getPrimaryColor() {
    if (dominantMood == 0) {
      return Colors.yellow;
    }
    if (dominantMood == 1) {
      return mainBlue;
    }
    if (dominantMood == 2) {
      return peachMainBg;
    }
    if (dominantMood == 3) {
      return Colors.blueGrey;
    }
    return Colors.red;
  }

  Color getSecondaryColor() {
    if (dominantMood == 0) {
      return Colors.orange;
    }
    if (dominantMood == 1) {
      return solidPurple;
    }
    if (dominantMood == 2) {
      return pastelPink;
    }
    if (dominantMood == 3) {
      return Colors.blueGrey;
    }
    return Colors.red;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomLeft,
          colors: [
            getPrimaryColor(),
            getSecondaryColor(),
          ],
        ),
      ),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          extendBodyBehindAppBar: true,
          appBar: _buildAppBar(),
          body: ListView(
            children: <Widget>[
              //SizedBox(height: 30),
              TimelineTile(
                alignment: TimelineAlign.manual,
                lineXY: 0.3,
                isFirst: true,
                indicatorStyle: IndicatorStyle(
                  width: 70,
                  height: 70,
                  indicator: _Sun(icon: getDominantMoodIcon()),
                ),
                beforeLineStyle:
                    LineStyle(color: Colors.white.withOpacity(0.7)),
                endChild: _ContainerHeader(
                    dominantMood: dominantMood, percentage: percentage),
              ),
              Expanded(
                child: SizedBox(
                    height: MediaQuery.sizeOf(context).height - 100,
                    child: FutureBuilder<List<Mood>>(
                        future: getMoodHistory(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            final moods = snapshot.data!;
                            return buildThreads(moods);
                          } else {
                            return const Text("No Mood Data");
                          }
                        })),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildThreads(List<Mood> moods) => ListView.builder(
        itemCount: moods.length,
        itemBuilder: (context, index) {
          print(moods);
          print('buildThreads');
          print(moods[index].mood);
          print(moods[index].date);
          print(moods[index].note);
          bool last = false;
          final thread = moods[index];
          IconData moodIcon = Icons.sentiment_very_satisfied;
          String moodName = "HAPPY";
          if (moods[index].mood == 2) {
            moodIcon = Icons.sentiment_satisfied;
            moodName = "SAD";
          } else if (moods[index].mood == 3) {
            moodIcon = Icons.sentiment_neutral;
            moodName = "CONFUSED";
          } else if (moods[index].mood == 4) {
            moodIcon = Icons.sentiment_dissatisfied;
            moodName = "SCARED";
          } else if (moods[index].mood == 5) {
            moodIcon = Icons.sentiment_very_dissatisfied;
            moodName = "ANGRY";
          }

          return _buildTimelineTile(
            indicator: _IconIndicator(
              iconData: moodIcon,
              size: 20,
            ),
            date: moods[index].date,
            mood: moodName,
            phrase: moods[index].note,
            isLast: last,
          );
        },
      );

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      title: Text(
        'Mood Log',
        style: TextStyle(
          color: Colors.black87,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  TimelineTile _buildTimelineTile({
    required _IconIndicator indicator,
    required String date,
    required String mood,
    required String phrase,
    bool isLast = false,
  }) {
    return TimelineTile(
      alignment: TimelineAlign.manual,
      lineXY: 0.3,
      beforeLineStyle: LineStyle(color: Colors.white.withOpacity(0.7)),
      indicatorStyle: IndicatorStyle(
        indicatorXY: 0.3,
        drawGap: true,
        width: 30,
        height: 30,
        indicator: indicator,
      ),
      isLast: isLast,
      startChild: Center(
        child: Container(
          alignment: const Alignment(0.0, -0.50),
          child: Text(
            date,
            style: TextStyle(
              fontSize: 14,
              color: Colors.white.withOpacity(0.6),
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
      ),
      endChild: Padding(
        padding:
            const EdgeInsets.only(left: 16, right: 10, top: 10, bottom: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              mood,
              style: TextStyle(
                fontSize: 18,
                color: Colors.black87,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            const SizedBox(height: 4),
            Text(
              phrase,
              style: TextStyle(
                fontSize: 14,
                color: Colors.black87,
                fontWeight: FontWeight.normal,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _IconIndicator extends StatelessWidget {
  const _IconIndicator({
    super.key,
    required this.iconData,
    required this.size,
  });

  final IconData iconData;
  final double size;

  Color getIconColor() {
    if (iconData == Icons.sentiment_very_satisfied) {
      return Colors.orange;
    }
    if (iconData == Icons.sentiment_satisfied) {
      return Colors.blue;
    }
    if (iconData == Icons.sentiment_neutral) {
      return Colors.pink;
    }
    if (iconData == Icons.sentiment_dissatisfied) {
      return Colors.blueGrey;
    }

    return Colors.red;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white.withOpacity(0.7),
          ),
        ),
        Positioned.fill(
          child: Align(
            alignment: Alignment.center,
            child: SizedBox(
              height: 30,
              width: 30,
              child: Icon(
                iconData,
                size: size,
                color: getIconColor(),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _ContainerHeader extends StatelessWidget {
  int dominantMood = 0;
  int percentage = 0;

  _ContainerHeader({
    super.key,
    required this.dominantMood,
    required this.percentage,
  });

  String getMoodString() {
    if (percentage == 0) {
      return "Unknown";
    } else if (dominantMood == 0) {
      return "HAPPY";
    } else if (dominantMood == 1) {
      return "SAD";
    } else if (dominantMood == 2) {
      return "CONFUSED";
    } else if (dominantMood == 3) {
      return "SCARED";
    } else if (dominantMood == 4) {
      return "ANGRY";
    }
    return "Unknown";
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minHeight: 120),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Text(
              'Dominant Mood',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey.shade800,
              ),
            ),
            Text(
              getMoodString(),
              style: TextStyle(
                fontSize: 30,
                color: Colors.white,
                fontWeight: FontWeight.w800,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Expanded(
                  child: Text(
                    '${percentage.toString()}% mood',
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      fontSize: 14,
                      color: const Color(0xFF4A448F).withOpacity(0.8),
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class _Sun extends StatelessWidget {
  IconData icon;

  _Sun({required this.icon});

  Color getIconColor() {
    if (icon == Icons.sentiment_very_satisfied) {
      return Colors.orange;
    }
    if (icon == Icons.sentiment_satisfied) {
      return Colors.blue.shade500;
    }
    if (icon == Icons.sentiment_neutral) {
      return Colors.pink;
    }
    if (icon == Icons.sentiment_dissatisfied) {
      return Colors.blueGrey.shade500;
    }

    return Colors.red;
  }

  @override
  Widget build(BuildContext context) {
    print("Debug Dominant Mood Icon: $icon");
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: pastelBlue,
            blurRadius: 25,
            spreadRadius: 2,
          ),
        ],
        shape: BoxShape.circle,
        color: unselectedGray,
      ),
      child: SizedBox(
        height: 30,
        width: 30,
        child: Center(
          child: Icon(
            icon,
            size: 50,
            color: getIconColor(),
          ),
        ),
      ),
    );
  }
}
