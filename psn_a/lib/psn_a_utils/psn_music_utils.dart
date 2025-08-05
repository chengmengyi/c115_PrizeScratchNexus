import 'package:psn_a/psn_a_storage/psn_a_storage.dart';
import 'package:psn_root/psn_root_utils/psn_root_export.dart';

enum VoiceEnum{
  no_card,play_fail,play_win
}

class PsnMusicUtils {
  static final PsnMusicUtils _utils = PsnMusicUtils();
  static PsnMusicUtils get instance => _utils;

  final AudioPlayer _backPlayer=AudioPlayer();
  final AudioPlayer _voicePlayer=AudioPlayer();

  initPlayer(){
    _voicePlayer.onPlayerStateChanged.listen((event) {
      if(aBackMusicSwitch.getData()){
        if(event==PlayerState.playing){
          _backPlayer.pause();
        }else if(event==PlayerState.completed){
          _backPlayer.resume();
        }
      }
    });
    playBackMp3();
  }

  playBackMp3(){
    if(aBackMusicSwitch.getData()){
      _backPlayer.setReleaseMode(ReleaseMode.loop);
      _backPlayer.play(AssetSource("bg.MP3"));
    }
  }

  clickBackBtn(){
    if(aBackMusicSwitch.getData()){
      aBackMusicSwitch.saveData(false);
      _backPlayer.pause();
    }else{
      aBackMusicSwitch.saveData(true);
      playBackMp3();
    }
  }

  clickVoiceBtn(){
    aVoiceMusicSwitch.saveData(!aVoiceMusicSwitch.getData());
  }

  playVoice(VoiceEnum voice){
    if(aVoiceMusicSwitch.getData()){
      _voicePlayer.play(AssetSource("${voice.name}.MP3"));
    }
  }
}