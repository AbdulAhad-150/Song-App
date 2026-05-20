import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:songweb/components/my_drawer.dart';
import 'package:songweb/components/neu_box.dart';
import 'package:songweb/models/playlist_provider.dart';

class SongPage extends StatelessWidget {
  const SongPage({super.key});

  //  convert duration into min:sec
  String formatTime(Duration duration) {
    String twoDigitSeconds = duration.inSeconds
        .remainder(60)
        .toString()
        .padLeft(2, '0');
    String twoDigitMinutes = duration.inMinutes
        .remainder(60)
        .toString()
        .padLeft(2, '0');
    String formattedTime = "$twoDigitMinutes:$twoDigitSeconds";
    return formattedTime;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PlaylistProvider>(
      builder: (context, value, child) {
        //  get playlist
        final playlist = value.playlist;

        //  get current song index
        final currentSong = playlist[value.currentSongIndex ?? 0];

        //  return scaffold UI
        return Scaffold(
          drawer: MyDrawer(),
          backgroundColor: Theme.of(context).colorScheme.surface,
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(left: 25, bottom: 25, right: 25),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // app bar
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // back button
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(Icons.arrow_back),
                      ),

                      // title
                      const Text('P L A Y L I S T'),
                      // menu button
                      Builder(
                        builder: (context) => IconButton(
                          onPressed: () {
                            Scaffold.of(context).openDrawer();
                          },
                          icon: const Icon(Icons.menu),
                        ),
                      ),
                      // IconButton(
                      //   onPressed: () {
                      //     MyDrawer();
                      //   },
                      //   icon: const Icon(Icons.menu),
                      // ),
                    ],
                  ),

                  SizedBox(height: 10),
                  //album artwork
                  NeuBox(
                    child: Column(
                      children: [
                        //  image
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.asset(
                            currentSong.albumArtImagePath,
                            height: 240,
                            width: 300,
                          ),
                        ),

                        //  song and artist name and icon
                        Row(
                          children: [
                            // song and artist name
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    currentSong.songName,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    currentSong.artistName,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),

                            SizedBox(width: 10),

                            // volume controller
                            SizedBox(
                              width: 120,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 20),
                                  const Text(
                                    "Volume",
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),

                                  Slider(
                                    min: 0,
                                    max: 1,
                                    value: value.volume,
                                    activeColor: Colors.green,
                                    onChanged: (double newVolume) {
                                      value.setVolume(newVolume);
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  //song duration progress
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 23.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            //  start time
                            Text(formatTime(value.currentDuration)),

                            //  shuffle icon
                            const Icon(Icons.shuffle),

                            //  repeat icon
                            const Icon(Icons.repeat),

                            //  end time
                            Text(formatTime(value.totalDuration)),
                          ],
                        ),
                      ),

                      // song duration progress
                      SliderTheme(
                        data: SliderTheme.of(context).copyWith(
                          thumbShape: const RoundSliderThumbShape(
                            enabledThumbRadius: 0,
                          ),
                        ),
                        child: Slider(
                          min: 0,
                          max: value.totalDuration.inSeconds.toDouble(),
                          value: value.currentDuration.inSeconds.toDouble(),
                          activeColor: Colors.green,
                          onChanged: (double double) {
                            // during when the user is sliding around
                          },
                          onChangeEnd: (double double) {
                            //  sliding has finished ,go to that position in song duration
                            value.seek(Duration(seconds: double.toInt()));
                          },
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  //palyback controls
                  Row(
                    children: [
                      //  skip previous
                      Expanded(
                        child: GestureDetector(
                          onTap: value.playPreviousSong,
                          child: const NeuBox(child: Icon(Icons.skip_previous)),
                        ),
                      ),

                      SizedBox(width: 10),

                      //  play or pause
                      Expanded(
                        flex: 2,
                        child: GestureDetector(
                          onTap: value.pauseOrResume,
                          child: NeuBox(
                            child: Icon(
                              value.isPlaying ? Icons.pause : Icons.play_arrow,
                            ),
                          ),
                        ),
                      ),

                      SizedBox(width: 10),

                      //  skip forward
                      Expanded(
                        child: GestureDetector(
                          onTap: value.playNextSong,
                          child: const NeuBox(child: Icon(Icons.skip_next)),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
