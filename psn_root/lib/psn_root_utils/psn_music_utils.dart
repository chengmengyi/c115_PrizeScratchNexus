import 'package:psn_root/psn_root_utils/psn_root_export.dart';

StorageData<bool> bBackMusicSwitch=StorageData<bool>(key: "bBackMusicSwitch", defaultValue: true);
StorageData<bool> bVoiceMusicSwitch=StorageData<bool>(key: "bVoiceMusicSwitch", defaultValue: true);

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
      if(bBackMusicSwitch.getData()){
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
    if(bBackMusicSwitch.getData()){
      _backPlayer.setReleaseMode(ReleaseMode.loop);
      _backPlayer.play(AssetSource("bg.MP3"));
    }
  }

  pauseBackMp3(){
    if(_backPlayer.state==PlayerState.playing){
      _backPlayer.pause();
    }
  }

  clickBackBtn(){
    if(bBackMusicSwitch.getData()){
      bBackMusicSwitch.saveData(false);
      _backPlayer.pause();
    }else{
      bBackMusicSwitch.saveData(true);
      playBackMp3();
    }
  }

  clickVoiceBtn(){
    bVoiceMusicSwitch.saveData(!bVoiceMusicSwitch.getData());
  }

  playVoice(VoiceEnum voice){
    if(bVoiceMusicSwitch.getData()){
      _voicePlayer.play(AssetSource("${voice.name}.MP3"));
    }
  }
}