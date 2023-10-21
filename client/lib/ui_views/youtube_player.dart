// Copyright 2020 Sarbagya Dhaubanjar. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class YoutubeApp extends StatefulWidget {
  final String videoId;

  const YoutubeApp({
    super.key,
    required this.videoId,
  });

  @override
  _YoutubeAppState createState() => _YoutubeAppState(videoId: videoId);
}

class _YoutubeAppState extends State<YoutubeApp> {
  final String videoId;
  late YoutubePlayerController _controller;

  _YoutubeAppState({required this.videoId});

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      params: const YoutubePlayerParams(
        showControls: true,
        mute: false,
        showFullscreenButton: false,
        loop: false,
      ),
    );

    _controller.setFullScreenListener(
      (isFullScreen) {
        log('${isFullScreen ? 'Entered' : 'Exited'} Fullscreen.');
      },
    );

    _controller.cueVideoById(videoId: videoId);
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerScaffold(
      controller: _controller,
      builder: (context, player) {
        return LayoutBuilder(
          builder: (context, constraints) {
            if (kIsWeb && constraints.maxWidth > 750) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 3,
                    child: Column(
                      children: [
                        player,
                        const VideoPositionIndicator(),
                      ],
                    ),
                  ),
                  // const Expanded(
                  //   flex: 2,
                  //   child: SingleChildScrollView(
                  //     child: Controls(),
                  //   ),
                  // ),
                ],
              );
            }

            return Column(
              children: [
                player,
                const VideoPositionIndicator(),
                //const Controls(),
              ],
            );
          },
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.close();
    super.dispose();
  }
}

///
// class Controls extends StatelessWidget {
//   ///
//   const Controls();

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(16),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           MetaDataSection(),
//           _space,
//           SourceInputSection(),
//           _space,
//           PlayPauseButtonBar(),
//           _space,
//           const VideoPositionSeeker(),
//           _space,
//           PlayerStateSection(),
//         ],
//       ),
//     );
//   }

//   Widget get _space => const SizedBox(height: 10);
// }

///
// class VideoPlaylistIconButton extends StatelessWidget {
//   ///
//   const VideoPlaylistIconButton({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final controller = context.ytController;

//     return IconButton(
//       onPressed: () async {
//         controller.pauseVideo();
//         await Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => const VideoListPage(),
//           ),
//         );
//         controller.playVideo();
//       },
//       icon: const Icon(Icons.playlist_play_sharp),
//     );
//   }
// }

class VideoPositionIndicator extends StatelessWidget {
  ///
  const VideoPositionIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.ytController;

    return StreamBuilder<YoutubeVideoState>(
      stream: controller.videoStateStream,
      initialData: const YoutubeVideoState(),
      builder: (context, snapshot) {
        final position = snapshot.data?.position.inMilliseconds ?? 0;
        final duration = controller.metadata.duration.inMilliseconds;

        return LinearProgressIndicator(
          value: duration == 0 ? 0 : position / duration,
          minHeight: 1,
        );
      },
    );
  }
}

///
// class VideoPositionSeeker extends StatelessWidget {
//   ///
//   const VideoPositionSeeker({super.key});

//   @override
//   Widget build(BuildContext context) {
//     var value = 0.0;

//     return Row(
//       children: [
//         const Text(
//           'Seek',
//           style: TextStyle(fontWeight: FontWeight.w300),
//         ),
//         const SizedBox(width: 14),
//         Expanded(
//           child: StreamBuilder<YoutubeVideoState>(
//             stream: context.ytController.videoStateStream,
//             initialData: const YoutubeVideoState(),
//             builder: (context, snapshot) {
//               final position = snapshot.data?.position.inSeconds ?? 0;
//               final duration = context.ytController.metadata.duration.inSeconds;

//               value = position == 0 || duration == 0 ? 0 : position / duration;

//               return StatefulBuilder(
//                 builder: (context, setState) {
//                   return Slider(
//                     value: value,
//                     onChanged: (positionFraction) {
//                       value = positionFraction;
//                       setState(() {});

//                       context.ytController.seekTo(
//                         seconds: (value * duration).toDouble(),
//                         allowSeekAhead: true,
//                       );
//                     },
//                     min: 0,
//                     max: 1,
//                   );
//                 },
//               );
//             },
//           ),
//         ),
//       ],
//     );
//   }
// }
