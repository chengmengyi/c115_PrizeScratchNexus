import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:psn_b/psn_b_bean/psn_rank_bean.dart';
import 'package:psn_b/psn_b_bean/psn_rank_list_bean.dart';
import 'package:psn_b/psn_b_utils/psn_b_cash_utils.dart';
import 'package:psn_b/psn_b_utils/psn_b_value_utils.dart';
import 'package:psn_root/psn_root_page/psn_root_con.dart';
import 'package:psn_root/psn_root_routers/psn_root_routers.dart';
import 'package:psn_root/psn_root_routers/psn_routers_enum.dart';
import 'package:psn_root/psn_root_utils/psn_ad_event_enum.dart';
import 'package:psn_root/psn_root_utils/psn_ad_utils.dart';
import 'package:psn_root/psn_root_utils/psn_root_export.dart';
import 'package:psn_root/psn_root_utils/psn_root_utils.dart';
import 'package:psn_root/psn_root_utils/psn_tba/psn_b_tba_utils.dart';
import 'package:psn_root/psn_root_utils/psn_tba_point_enum.dart';

class PsnRankDialogCon extends PsnRootCon{
  PsnRankBean? rankBean;
  Function()? successCallback;
  List<PsnRankListBean> ranList=[];
  ScrollController scrollController=ScrollController();

  @override
  void onInit() {
    super.onInit();
    PsnBTbaUtils.instance.pointEvent(pointEnum: PsnTbaPointEnum.queue_page);
  }

  @override
  void onReady() {
    super.onReady();
    _initList();
  }

  clickSkip(){
    if(kDebugMode){
      _reduceRank();
      return;
    }
    PsnBTbaUtils.instance.pointEvent(pointEnum: PsnTbaPointEnum.queue_c);
    PsnAdUtils.instance.showAdBBBBBB(
      adType: AdType.reward,
      evnetEnum: PsnAdEventEnum.apwxi_rank_rv,
      showAd: true,
      closeCallback: (){
        _reduceRank();
      },
      closeDialogNotGiveMoney: (){},
    );
  }

  _reduceRank()async{
    rankBean=await PsnBCashUtils.instance.updateRankProgress(rankBean);
    _initList();
  }

  _initList()async{
    ranList.clear();
    var totalRank = rankBean?.totalRank??0;
    if(totalRank<=0){
      update(["list"]);
      return;
    }
    while(ranList.length<totalRank-1){
      var bean = PsnRankListBean(
        account: "${randomTwoLetters()}****.com",
        amount: PsnBValueUtils.instance.getCashList().random(),
        isMe: false,
      );
      ranList.add(bean);
    }
    var currentRank = rankBean?.currentRank??0;
    var account = await PsnBCashUtils.instance.queryAccount(rankBean?.cashMoney??0, rankBean?.cashType??"");
    if(account.isEmpty){
      account="${randomTwoLetters()}****.com";
    }
    if(currentRank==0){
      ranList.insert(0, PsnRankListBean(account: account, amount: rankBean?.cashMoney??0,isMe: true,));
    }else{
      ranList.insert(currentRank-1, PsnRankListBean(account: account, amount: rankBean?.cashMoney??0,isMe: true));
    }
    update(["list","rank_text"]);
    var indexWhere = ranList.indexWhere((value)=>value.isMe);
    if(indexWhere==0){
      PsnRootRouters.instance.router(routersEnum: PsnRoutersEnum.back, content: null);
      successCallback?.call();
    }else if(indexWhere>8){
      scrollController.animateTo(
        (50.h)*(indexWhere-4),
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }else if(indexWhere<=8){
      scrollController.animateTo(
        0,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  String randomTwoLetters() {
    const letters = 'abcdefghijklmnopqrstuvwxyz';
    final random = Random();
    return String.fromCharCodes(List.generate(
      2,
          (_) => letters.codeUnitAt(random.nextInt(letters.length)),
    ));
  }

  clickClose(){
    PsnRootRouters.instance.router(routersEnum: PsnRoutersEnum.back, content: null);
  }

  String getUserId(int index){
    if(index<10){
      return "00$index";
    }else if(index<100){
      return "0$index";
    }else{
      return "$index";
    }
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }
}