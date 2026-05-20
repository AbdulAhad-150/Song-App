import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:songweb/models/song.dart';

class PlaylistProvider extends ChangeNotifier {
  // Playlist of songs
  final List<Song> _playlist = [
    Song(
      songName: '4AM in Karachi',
      artistName: 'Talha Anjum',
      albumArtImagePath: 'assets/images/4_am_in_karachi.jpg',
      audioPath: 'audio/4AM_in_Karachi.mp3',
    ),
    Song(
      songName: 'HUMSAFAR',
      artistName: "AUR",
      albumArtImagePath: 'assets/images/aur_Hamsafar.jpg',
      audioPath: 'audio/aur_Hamsafar.mp3',
    ),
    Song(
      songName: 'Guzaarishein',
      artistName: "Samar Jafri",
      albumArtImagePath: 'assets/images/guzaarishein.jpg',
      audioPath: 'audio/guzaarishein.mp3',
    ),
    Song(
      songName: 'Main Rahun',
      artistName: "Samar Jafri",
      albumArtImagePath: 'assets/images/main_rahun.jpg',
      audioPath: 'audio/main_rahun.mp3',
    ),
    Song(
      songName: 'PAL PAL ( Talwiinder ) ',
      artistName: "AFUSIC",
      albumArtImagePath: 'assets/images/palpal.jpg',
      audioPath: 'audio/Afusic_Pal_Pal_with_@Talwiinder.mp3',
    ),
    Song(
      songName: 'Sapphire',
      artistName: "Ed Sheeran",
      albumArtImagePath: 'assets/images/sapphire.jpg',
      audioPath: 'audio/Ed_Sheeran_Sapphire.mp3',
    ),
    Song(
      songName: 'Shikayat',
      artistName: "AUR",
      albumArtImagePath: 'assets/images/shikayat.jpg',
      audioPath: 'audio/aur_shikayat.mp3',
    ),
    Song(
      songName: 'Sometimes',
      artistName: "AUR",
      albumArtImagePath: 'assets/images/sometimes.jpg',
      audioPath: 'audio/aur_sometimes.mp3',
    ),
    Song(
      songName: 'TU HAI KAHAN',
      artistName: "AUR",
      albumArtImagePath: 'assets/images/tu_hai_kahan.jpg',
      audioPath: 'audio/aur_tu_hai_kahan.mp3',
    ),
    // repeat some songs to make the playlist longer
    Song(
      songName: '4AM in Karachi',
      artistName: 'Talha Anjum',
      albumArtImagePath: 'assets/images/4_am_in_karachi.jpg',
      audioPath: 'audio/4AM_in_Karachi.mp3',
    ),
    Song(
      songName: 'HUMSAFAR',
      artistName: "AUR",
      albumArtImagePath: 'assets/images/aur_Hamsafar.jpg',
      audioPath: 'audio/aur_Hamsafar.mp3',
    ),
    Song(
      songName: 'Guzaarishein',
      artistName: "Samar Jafri",
      albumArtImagePath: 'assets/images/guzaarishein.jpg',
      audioPath: 'audio/guzaarishein.mp3',
    ),
    Song(
      songName: 'Main Rahun',
      artistName: "Samar Jafri",
      albumArtImagePath: 'assets/images/main_rahun.jpg',
      audioPath: 'audio/main_rahun.mp3',
    ),
    Song(
      songName: 'PAL PAL ( Talwiinder ) ',
      artistName: "AFUSIC",
      albumArtImagePath: 'assets/images/palpal.jpg',
      audioPath: 'audio/Afusic_Pal_Pal_with_@Talwiinder.mp3',
    ),
    Song(
      songName: 'Sapphire',
      artistName: "Ed Sheeran",
      albumArtImagePath: 'assets/images/sapphire.jpg',
      audioPath: 'audio/Ed_Sheeran_Sapphire.mp3',
    ),
    Song(
      songName: 'Shikayat',
      artistName: "AUR",
      albumArtImagePath: 'assets/images/shikayat.jpg',
      audioPath: 'audio/aur_shikayat.mp3',
    ),
    Song(
      songName: 'Sometimes',
      artistName: "AUR",
      albumArtImagePath: 'assets/images/sometimes.jpg',
      audioPath: 'audio/aur_sometimes.mp3',
    ),
    Song(
      songName: 'TU HAI KAHAN',
      artistName: "AUR",
      albumArtImagePath: 'assets/images/tu_hai_kahan.jpg',
      audioPath: 'audio/aur_tu_hai_kahan.mp3',
    ),
    // Add more songs if needed
  ];

  // Current state
  int? _currentSongIndex;
  final AudioPlayer _audioPlayer = AudioPlayer();
  Duration _currentDuration = Duration.zero;
  Duration _totalDuration = Duration.zero;
  bool _isPlaying = false;
  double _volume = 1.0; // default full volume

  // Constructor
  PlaylistProvider() {
    _listenToDuration();
  }

  // Start listening to duration updates
  void _listenToDuration() {
    _audioPlayer.onDurationChanged.listen((newDuration) {
      _totalDuration = newDuration;
      notifyListeners();
    });

    _audioPlayer.onPositionChanged.listen((newPosition) {
      _currentDuration = newPosition;
      notifyListeners();
    });

    _audioPlayer.onPlayerComplete.listen((event) {
      playNextSong();
    });
  }

  // Play song
  void play() async {
    if (_currentSongIndex == null) return;

    playSong();
  }

  // Central method to play a song
  void playSong() async {
    if (_currentSongIndex == null) return;

    final song = _playlist[_currentSongIndex!];

    await _audioPlayer.stop();
    await _audioPlayer.setVolume(_volume);
    await _audioPlayer.play(AssetSource(song.audioPath));

    _isPlaying = true;
    notifyListeners();
  }

  // Pause
  void pause() async {
    await _audioPlayer.pause();
    _isPlaying = false;
    notifyListeners();
  }

  // Resume
  void resume() async {
    await _audioPlayer.resume();
    _isPlaying = true;
    notifyListeners();
  }

  // Pause or Resume toggle
  void pauseOrResume() {
    _isPlaying ? pause() : resume();
  }

  // Seek to position
  void seek(Duration position) async {
    await _audioPlayer.seek(position);
  }

  // Set volume
  void setVolume(double newVolume) {
    _volume = newVolume;
    _audioPlayer.setVolume(_volume);
    notifyListeners();
  }

  // Next song
  void playNextSong() {
    if (_currentSongIndex == null) return;

    if (_currentSongIndex! < _playlist.length - 1) {
      currentSongIndex = _currentSongIndex! + 1;
    } else {
      currentSongIndex = 0;
    }
  }

  // Previous song
  void playPreviousSong() {
    if (_currentSongIndex == null) return;

    if (_currentDuration.inSeconds > 2) {
      seek(Duration.zero);
    } else {
      if (_currentSongIndex! > 0) {
        currentSongIndex = _currentSongIndex! - 1;
      } else {
        currentSongIndex = _playlist.length - 1;
      }
    }
  }

  // Getters
  List<Song> get playlist => _playlist;
  int? get currentSongIndex => _currentSongIndex;
  bool get isPlaying => _isPlaying;
  Duration get currentDuration => _currentDuration;
  Duration get totalDuration => _totalDuration;
  double get volume => _volume;

  // Setter for currentSongIndex
  set currentSongIndex(int? newIndex) {
    _currentSongIndex = newIndex;

    if (newIndex != null) {
      play();
    }

    notifyListeners();
  }

  // Clean up
  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }
}
