import 'package:flutter/material.dart';
import 'package:psn_b/psn_b_bean/psn_b_content_bean.dart';
import 'package:psn_b/psn_b_dialog/psn_b_big_win_dialog/psn_b_big_win_dialog.dart';
import 'package:psn_b/psn_b_dialog/psn_b_fail_dialog/psn_b_fail_dialog.dart';
import 'package:psn_b/psn_b_dialog/psn_b_get_more_dialog/psn_b_get_more_dialog.dart';
import 'package:psn_b/psn_b_dialog/psn_b_level_up_dialog/psn_b_level_up_dialog.dart';
import 'package:psn_b/psn_b_dialog/psn_b_normal_win_dialog/psn_b_normal_win_dialog.dart';
import 'package:psn_b/psn_b_utils/pns_b_card_type_enum.dart';
import 'package:psn_b/psn_b_utils/psn_b_user_info_utils.dart';
import 'package:psn_b/psn_b_utils/psn_b_utils.dart';
import 'package:psn_b/psn_b_utils/psn_music_utils.dart';
import 'package:psn_root/psn_root_routers/psn_root_routers.dart';
import 'package:psn_root/psn_root_routers/psn_routers_enum.dart';
import 'package:psn_root/psn_root_scratcher/scratcher.dart';
import 'package:psn_root/psn_root_utils/psn_root_export.dart';


abstract class PlayListener {
  resetPlay();
}

class PsnBPlayUtils {
  PsnBCardTypeEnum cardTypeEnum;
  PlayListener playListener;

  var canClick=true,_stopScratchAuto=false;
  double _scratcherWidth=0.0,_scratcherHeight=0.0;
  var scratcherKey = GlobalKey<ScratcherState>();
  List<PsnBContentBean> contentList=[];
  GlobalKey scratchGlobalKey=GlobalKey();

  PsnBPlayUtils({
    required this.cardTypeEnum,
    required this.playListener,
  });

  initScratchWidthHeight(){
    var renderBox = scratchGlobalKey.currentContext!.findRenderObject() as RenderBox;
    _scratcherWidth = renderBox.size.width;
    _scratcherHeight = renderBox.size.height;
  }

  setContentList(List<PsnBContentBean> list){
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
      case PsnBCardTypeEnum.dogWinning:
        var winNum = contentList.where((item) => item.win).length;
        if(winNum>0){
          var contentBean = contentList.firstWhere((value)=>value.win);
          totalReward=contentBean.reward*_getDogBeishu(winNum);
        }
        break;
      case PsnBCardTypeEnum.collectorWin:
        List<PsnBContentBean> winList = contentList.where((e) => e.win).toList();
        final seen = <String>{};
        List<PsnBContentBean> uniqueList = [];
        for (var item in winList) {
          if (seen.add(item.content)) {
            uniqueList.add(item);
          }
        }
        totalReward = uniqueList.where((item) => item.win).fold(0, (sum, item) => sum + item.reward);
        break;
      case PsnBCardTypeEnum.kingOfCards:
        totalReward = (contentList.where((item) => item.win).fold(0, (sum, item) => sum + item.reward)/2).toInt();
        break;
      case PsnBCardTypeEnum.fruitLineup:
        totalReward = (contentList.where((item) => item.win).fold(0, (sum, item) => sum + item.reward)/3).toInt();
        break;
      default:
        totalReward = contentList.where((item) => item.win).fold(0, (sum, item) => sum + item.reward);
        break;
    }
    var isUpLevel = PsnBUserInfoUtils.instance.updatePlayNum();
    if(isUpLevel){
      PsnRootRouters.instance.router(
        routersEnum: PsnRoutersEnum.dialog,
        content: PsnBLevelUpDialog(
          totalReward: totalReward.toDouble(),
          dismissCallback: (){
            _levelUpResult();
          },
        ),
      );
    }else{
      if(totalReward>0){
        PsnMusicUtils.instance.playVoice(VoiceEnum.play_win);
        if(totalReward>=60){
          PsnRootRouters.instance.router(
            routersEnum: PsnRoutersEnum.dialog,
            content: PsnBBigWinDialog(
              reward: totalReward.toDouble(),
              dismissCallback: (){
                resetPlay();
              },
            ),
          );
        }else{
          PsnRootRouters.instance.router(
            routersEnum: PsnRoutersEnum.dialog,
            content: PsnBNormalWinDialog(
              reward: totalReward.toDouble(),
              dismissCallback: (){
                resetPlay();
              },
            ),
          );
        }
      }else{
        PsnMusicUtils.instance.playVoice(VoiceEnum.play_fail);
        PsnRootRouters.instance.router(
          routersEnum: PsnRoutersEnum.dialog,
          content: PsnBFailDialog(
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

  _levelUpResult()async{
    var resultBean = calculateLevel();
    var psnACardTypeEnum = PsnBCardTypeEnum.values[resultBean.level-1];
    await PsnBUserInfoUtils.instance.unlockCard(psnACardTypeEnum);
    resetPlay();
  }

  resetPlay()async{
    _stopScratchAuto=false;
    scratcherKey.currentState?.reset();
    playListener.resetPlay();
    var cardNum = await PsnBUserInfoUtils.instance.updateCardNum(cardTypeEnum, -1);
    if(cardNum<=0){
      PsnMusicUtils.instance.playVoice(VoiceEnum.no_card);
      var indexWhere = PsnBCardTypeEnum.values.indexWhere((value)=>value==cardTypeEnum);
      if(indexWhere>=0){
        if(indexWhere>=5){
          indexWhere=0;
        }else{
          indexWhere+=1;
        }
        var nextCardType = PsnBCardTypeEnum.values[indexWhere];
        var nextCard = await PsnBUserInfoUtils.instance.getCardBeanByCardType(nextCardType);
        if(null!=nextCard){
          if(nextCard.unlock==1){
            PsnRootRouters.instance.router(
                routersEnum: PsnRoutersEnum.dialog,
                content: PsnBGetMoreDialog(
                  cardTypeEnum: cardTypeEnum,
                  clickClose: (){
                    PsnRootRouters.instance.router(routersEnum: PsnRoutersEnum.back, content: null);
                  },
                ),
            );
          }else{
            var nextCardTypeEnum = PsnBCardTypeEnum.values.byName(nextCard.cardType??"");
            var nextCardNum = await PsnBUserInfoUtils.instance.getCardNumByType(nextCardTypeEnum);
            //下一个没有次数，给当前加次数
            if(nextCardNum<=0){
              PsnRootRouters.instance.router(
                routersEnum: PsnRoutersEnum.dialog,
                content: PsnBGetMoreDialog(
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