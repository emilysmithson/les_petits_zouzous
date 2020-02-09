
import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';

class MusicPlayer {
  final cache = AudioCache();
  AudioPlayer player = AudioPlayer();

    playFile(String fileName) async {
    player = await cache.play(fileName);

  }

   loopFile(String fileName) async {

    player = await cache.loop(fileName);
  }

   stopFile() {
    player.stop();
    print('should definitely be stopping');
  }
}
