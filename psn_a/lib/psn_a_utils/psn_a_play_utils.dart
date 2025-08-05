import 'package:flutter/material.dart';
import 'package:psn_a/psn_a_bean/psn_a_content_bean.dart';
import 'package:psn_a/psn_a_dialog/psn_a_fail_dialog/psn_a_fail_dialog.dart';
import 'package:psn_a/psn_a_dialog/psn_a_get_more_dialog/psn_a_get_more_dialog.dart';
import 'package:psn_a/psn_a_dialog/psn_a_level_up_dialog/psn_a_level_up_dialog.dart';
import 'package:psn_a/psn_a_dialog/psn_a_win_dialog/psn_a_win_dialog.dart';
import 'package:psn_a/psn_a_utils/pns_a_card_type_enum.dart';
import 'package:psn_a/psn_a_utils/psn_a_user_info_utils.dart';
import 'package:psn_a/psn_a_utils/psn_a_utils.dart';
import 'package:psn_a/psn_a_utils/psn_music_utils.dart';
import 'package:psn_root/psn_root_routers/psn_root_routers.dart';
import 'package:psn_root/psn_root_routers/psn_routers_enum.dart';
import 'package:psn_root/psn_root_scratcher/scratcher.dart';
import 'package:psn_root/psn_root_utils/psn_root_export.dart';


abstract class PlayListener {
  resetPlay();
}

class PsnAPlayUtils {
  PsnACardTypeEnum cardTypeEnum;
  PlayListener playListener;

  var canClick=true,_stopScratchAuto=false;
  double _scratcherWidth=0.0,_scratcherHeight=0.0;
  var scratcherKey = GlobalKey<ScratcherState>();
  List<PsnAContentBean> contentList=[];
  GlobalKey scratchGlobalKey=GlobalKey();

  PsnAPlayUtils({
    required this.cardTypeEnum,
    required this.playListener,
  });

  initScratchWidthHeight(){
    var renderBox = scratchGlobalKey.currentContext!.findRenderObject() as RenderBox;
    _scratcherWidth = renderBox.size.width;
    _scratcherHeight = renderBox.size.height;
  }

  setContentList(List<PsnAContentBean> list){
    contentList.clear();
    contentList.addAll(list);
  }

  onThreshold()async{
    canClick=false;
    _stopScratchAuto=true;
    scratcherKey.currentState?.reveal();
    await Future.delayed(Duration(milliseconds: 1000));
    canClick=true;
    var totalReward=0;
    switch(cardTypeEnum){
      case PsnACardTypeEnum.dogWinning:
        var winNum = contentList.where((item) => item.win).length;
        if(winNum>0){
          var contentBean = contentList.firstWhere((value)=>value.win);
          totalReward=contentBean.reward*_getDogBeishu(winNum);
        }
        break;
      case PsnACardTypeEnum.collectorWin:
        List<PsnAContentBean> winList = contentList.where((e) => e.win).toList();
        final seen = <String>{};
        List<PsnAContentBean> uniqueList = [];
        for (var item in winList) {
          if (seen.add(item.content)) {
            uniqueList.add(item);
          }
        }
        totalReward = uniqueList.where((item) => item.win).fold(0, (sum, item) => sum + item.reward);
        break;
      case PsnACardTypeEnum.kingOfCards:
        totalReward = (contentList.where((item) => item.win).fold(0, (sum, item) => sum + item.reward)/2).toInt();
        break;
      case PsnACardTypeEnum.fruitLineup:
        totalReward = (contentList.where((item) => item.win).fold(0, (sum, item) => sum + item.reward)/3).toInt();
        break;
      default:
        totalReward = contentList.where((item) => item.win).fold(0, (sum, item) => sum + item.reward);
        break;
    }
    var isUpLevel = PsnAUserInfoUtils.instance.updatePlayNum();
    if(isUpLevel){
      PsnRootRouters.instance.router(
        routersEnum: PsnRoutersEnum.dialog,
        content: PsnALevelUpDialog(
          totalReward: totalReward,
          dismissCallback: (){
            resetPlay();
          },
        ),
      );
    }else{
      if(totalReward>0){
        PsnMusicUtils.instance.playVoice(VoiceEnum.play_win);
        PsnRootRouters.instance.router(
          routersEnum: PsnRoutersEnum.dialog,
          content: PsnAWinDialog(
            totalReward: totalReward,
            dismissCall: (){
              resetPlay();
            },
          ),
        );
      }else{
        PsnMusicUtils.instance.playVoice(VoiceEnum.play_fail);
        PsnRootRouters.instance.router(
          routersEnum: PsnRoutersEnum.dialog,
          content: PsnAFailDialog(
            dismissCallback: (){
              resetPlay();
            },
          ),
        );
      }
    }
  }

  startAutoScratch()async{
    try{
      if(!canClick){
        return;
      }
      canClick=false;
      var psnHeng=1,psnCurrentDx=0,psnStartHeight=0.h;
      scratcherKey.currentState?.callStart();
      while(psnHeng*15<_scratcherHeight&&!_stopScratchAuto){
        if(psnHeng%2==0){
          if(psnCurrentDx>0){
            psnCurrentDx-=10;
            var dy=(psnHeng-1)*15+30+psnStartHeight;
            scratcherKey.currentState?.addPoint(Offset(psnCurrentDx.toDouble(), dy));
            // offsetCallback.call(Offset(dx.toDouble(), dy));
          }else{
            psnHeng++;
          }
        }else{
          if(psnCurrentDx<_scratcherWidth){
            psnCurrentDx+=10;
            var dy=(psnHeng==1?15:(psnHeng-1)*15+30)+psnStartHeight;
            scratcherKey.currentState?.addPoint(Offset(psnCurrentDx.toDouble(), dy));
            // offsetCallback.call(Offset(dx.toDouble(), dy));
          }else{
            psnHeng++;
          }
        }
        await Future.delayed(const Duration(milliseconds: 1));
      }
    }catch(e){
      canClick=true;
    }
  }

  resetPlay()async{
    _stopScratchAuto=false;
    scratcherKey.currentState?.reset();
    playListener.resetPlay();
    var cardNum = await PsnAUserInfoUtils.instance.updateCardNum(cardTypeEnum, -1);
    if(cardNum<=0){
      PsnMusicUtils.instance.playVoice(VoiceEnum.no_card);
      var indexWhere = PsnACardTypeEnum.values.indexWhere((value)=>value==cardTypeEnum);
      if(indexWhere>=0){
        if(indexWhere>=5){
          indexWhere=0;
        }else{
          indexWhere+=1;
        }
        var nextCardType = PsnACardTypeEnum.values[indexWhere];
        var nextCard = await PsnAUserInfoUtils.instance.getCardBeanByCardType(nextCardType);
        if(null!=nextCard){
          if(nextCard.unlock==1){
            PsnRootRouters.instance.router(
                routersEnum: PsnRoutersEnum.dialog,
                content: PsnAGetMoreDialog(
                  cardTypeEnum: cardTypeEnum,
                  clickClose: (){
                    PsnRootRouters.instance.router(routersEnum: PsnRoutersEnum.back, content: null);
                  },
                ),
            );
          }else{
            var nextCardTypeEnum = PsnACardTypeEnum.values.byName(nextCard.cardType??"");
            var nextCardNum = await PsnAUserInfoUtils.instance.getCardNumByType(nextCardTypeEnum);
            //下一个没有次数，给当前加次数
            if(nextCardNum<=0){
              PsnRootRouters.instance.router(
                routersEnum: PsnRoutersEnum.dialog,
                content: PsnAGetMoreDialog(
                  cardTypeEnum: cardTypeEnum,
                  clickClose: (){},
                ),
              );
              return;
            }
            var routerName = getRouterNameByCardType(nextCardTypeEnum);
            if(routerName.isEmpty){
              PsnRootRouters.instance.router(routersEnum: PsnRoutersEnum.back, content: null);
            }else{
              PsnRootRouters.instance.router(routersEnum: PsnRoutersEnum.offNamed, content: routerName);
            }
          }
        }
      }else{
        PsnRootRouters.instance.router(routersEnum: PsnRoutersEnum.back, content: null);
      }
    }
  }

  clickBack(){
    if(!canClick){
      return;
    }
    PsnRootRouters.instance.router(routersEnum: PsnRoutersEnum.back, content: null);
  }

  int _getDogBeishu(int winNum){
    switch(winNum){
      case 3: return 1;
      case 4: return 2;
      case 5: return 3;
      case 6: return 5;
      case 7: return 10;
      case 8: return 25;
      case 9: return 50;
      case 10: return 100;
      default: return 1;
    }
  }
}