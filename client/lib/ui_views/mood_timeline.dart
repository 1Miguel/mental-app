import 'package:flutter/material.dart';
import 'package:flutter_intro/utils/colors_scheme.dart';
import 'package:timeline_tile/timeline_tile.dart';

class MoodTimeline extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomLeft,
          colors: [
            mainBlue,
            solidPurple,
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
              TimelineTile(
                alignment: TimelineAlign.manual,
                lineXY: 0.3,
                isFirst: true,
                indicatorStyle: IndicatorStyle(
                  width: 70,
                  height: 70,
                  indicator: _Sun(),
                ),
                beforeLineStyle:
                    LineStyle(color: Colors.white.withOpacity(0.7)),
                endChild: _ContainerHeader(),
              ),
              _buildTimelineTile(
                indicator: _IconIndicator(
                  iconData: Icons.sentiment_dissatisfied,
                  size: 20,
                ),
                date: 'Oct 01',
                mood: 'Sad',
                phrase:
                    "It's quite a bit sad day today. It's quite a bit sad day today.",
              ),
              _buildTimelineTile(
                indicator: _IconIndicator(
                  iconData: Icons.sentiment_dissatisfied,
                  size: 20,
                ),
                date: 'Oct 02',
                mood: 'Happy',
                //temperature: 'quite a pleasant day',
                phrase:
                    "It's quite a bit happy day today. It's quite a bit happy day today.",
              ),
              _buildTimelineTile(
                indicator: _IconIndicator(
                  iconData: Icons.sentiment_satisfied,
                  size: 20,
                ),
                date: 'Oct 03',
                mood: 'Sad',
                phrase:
                    "It's quite a bit sad day today. It's quite a bit sad day today.",
              ),
              _buildTimelineTile(
                indicator: _IconIndicator(
                  iconData: Icons.sentiment_neutral,
                  size: 20,
                ),
                date: 'Oct 04',
                mood: 'Sad',
                phrase:
                    "It's quite a bit sad day today. It's quite a bit sad day today.",
              ),
              _buildTimelineTile(
                indicator: _IconIndicator(
                  iconData: Icons.sentiment_neutral,
                  size: 20,
                ),
                date: 'Oct 05',
                mood: 'Sad',
                phrase:
                    "It's quite a bit sad day today. It's quite a bit sad day today.",
              ),
              _buildTimelineTile(
                indicator: _IconIndicator(
                  iconData: Icons.sentiment_neutral,
                  size: 20,
                ),
                date: 'Oct 06',
                mood: 'Sad',
                phrase:
                    "It's quite a bit sad day today. It's quite a bit sad day today.",
              ),
              _buildTimelineTile(
                indicator: _IconIndicator(
                  iconData: Icons.sentiment_neutral,
                  size: 20,
                ),
                date: 'Oct 07',
                mood: 'Sad',
                phrase:
                    "It's quite a bit sad day today. It's quite a bit sad day today.",
                isLast: true,
              ),
            ],
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      title: Text(
        'Mood Log',
        style: TextStyle(
          color: unselectedGray,
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
              fontSize: 18,
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
                color: Colors.white.withOpacity(0.8),
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            const SizedBox(height: 4),
            Text(
              phrase,
              style: TextStyle(
                fontSize: 14,
                color: Colors.white.withOpacity(0.6),
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
                color: const Color(0xFF9E3773).withOpacity(0.7),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _ContainerHeader extends StatelessWidget {
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
                color: const Color(0xFFF4A5CD),
              ),
            ),
            Text(
              'Sad',
              style: TextStyle(
                fontSize: 30,
                color: Colors.white.withOpacity(0.8),
                fontWeight: FontWeight.w800,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Expanded(
                  child: Text(
                    '40% mood',
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      fontSize: 14,
                      color: const Color(0xFF4A448F).withOpacity(0.8),
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                //const SizedBox(width: 20),
                // Text(
                //   '30°C',
                //   style: TextStyle(
                //     fontSize: 14,
                //     color: const Color(0xFF4A448F).withOpacity(0.8),
                //     fontWeight: FontWeight.w800,
                //   ),
                // )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class _Sun extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
        color: pastelBlue,
      ),
      child: SizedBox(
        height: 30,
        width: 30,
        child: Center(
          child: Icon(
            Icons.sentiment_dissatisfied,
            size: 50,
            color: mainBlue,
          ),
        ),
      ),
    );
  }
}
