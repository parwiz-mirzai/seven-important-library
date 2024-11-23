import 'package:flutter/material.dart';

import 'package:video_player/video_player.dart';

class VideoPlayersList extends StatelessWidget {
  const VideoPlayersList({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> paths = [
      "assets/1.mp4",
      "assets/2.mp4",
    ];
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(children: [
          ListView.builder(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            itemCount: paths.length,
            itemBuilder: (BuildContext context, int index) {
              return VideoPlay(
                pathh: paths[index],
              );
            },
          ),
        ]),
      ),
    );
  }
}

// ignore: must_be_immutable
class VideoPlay extends StatefulWidget {
  String? pathh;

  @override
  _VideoPlayState createState() => _VideoPlayState();

  VideoPlay({
    Key? key,
    this.pathh,
  }) : super(key: key);
}

class _VideoPlayState extends State<VideoPlay> {
  ValueNotifier<VideoPlayerValue?> currentPosition = ValueNotifier(null);
  VideoPlayerController? controller;
  late Future<void> futureController;

  initVideo() {
    controller = VideoPlayerController.asset(widget.pathh!);

    futureController = controller!.initialize();
  }

  @override
  void initState() {
    initVideo();
    controller!.addListener(() {
      if (controller!.value.isInitialized) {
        currentPosition.value = controller!.value;
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    controller!.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return FutureBuilder(
      future: futureController,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator.adaptive();
        } else {
          return Padding(
            padding: const EdgeInsets.only(),
            child: SizedBox(
              height: controller!.value.size.height,
              child: AspectRatio(
                  aspectRatio: controller!.value.aspectRatio,
                  child: Stack(children: [
                    Positioned.fill(
                        child: Center(
                      child: Padding(
                        padding: EdgeInsets.only(
                            top: size.height * 0.2,
                            left: size.width * 0.1,
                            right: size.width * 0.1),
                        child: Container(
                            decoration: const BoxDecoration(color: Colors.blue),
                            child: VideoPlayer(controller!)),
                      ),
                    )),
                    Positioned.fill(
                      child: Column(
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                Expanded(
                                  child: GestureDetector(
                                    onDoubleTap: () async {
                                      Duration? position =
                                          await controller!.position;
                                      setState(() {
                                        controller!.seekTo(Duration(
                                            seconds: position!.inSeconds - 10));
                                      });
                                    },
                                    child: const Icon(
                                      Icons.fast_rewind_rounded,
                                      color: Colors.black,
                                      size: 40,
                                    ),
                                  ),
                                ),
                                Expanded(
                                    child: IconButton(
                                  icon: Icon(
                                    controller!.value.isPlaying
                                        ? Icons.pause
                                        : Icons.play_arrow,
                                    color: Colors.black,
                                    size: 40,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      if (controller!.value.isPlaying) {
                                        controller!.pause();
                                      } else {
                                        controller!.play();
                                      }
                                    });
                                  },
                                )),
                                Expanded(
                                  child: GestureDetector(
                                    onDoubleTap: () async {
                                      Duration? position =
                                          await controller!.position;
                                      setState(() {
                                        controller!.seekTo(Duration(
                                            seconds: position!.inSeconds + 10));
                                      });
                                    },
                                    child: const Icon(
                                      Icons.fast_forward_rounded,
                                      color: Colors.black,
                                      size: 40,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                              child: Align(
                            alignment: Alignment.bottomCenter,
                            child: ValueListenableBuilder(
                                valueListenable: currentPosition,
                                builder: (context,
                                    VideoPlayerValue? videoPlayerValue, w) {
                                  return Padding(
                                    padding: const EdgeInsets.only(),
                                    child: Row(
                                      children: [
                                        Text(
                                          videoPlayerValue!.position
                                              .toString()
                                              .substring(
                                                  videoPlayerValue.position
                                                          .toString()
                                                          .indexOf(':') +
                                                      1,
                                                  videoPlayerValue.position
                                                      .toString()
                                                      .indexOf('.')),
                                          style: const TextStyle(
                                              color: Color.fromARGB(
                                                  255, 226, 127, 127),
                                              fontSize: 22),
                                        ),
                                      ],
                                    ),
                                  );
                                }),
                          ))
                        ],
                      ),
                    ),
                  ])),
            ),
          );
        }
      },
    );
  }
}
