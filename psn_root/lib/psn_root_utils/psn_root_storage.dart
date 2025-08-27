import 'package:psn_root/psn_root_utils/psn_root_export.dart';

StorageData<String> psnAlreadyFengKSource=StorageData<String>(key: "psnAlreadyFengKSource", defaultValue: "");
StorageData<String> psnFacebookConfig=StorageData<String>(key: "psnFacebookConfig", defaultValue: "");
StorageData<int> psnLastAdLevel=StorageData<int>(key: "psnLastAdLevel", defaultValue: 0);
StorageData<int> psnAdWatchNum=StorageData<int>(key: "psnAdWatchNum", defaultValue: 0);

StorageData<String> psnAdConfigStr=StorageData<String>(key: "psnAdConfigStr", defaultValue: "");
StorageData<String> psnValueConfigStr=StorageData<String>(key: "psnValueConfigStr", defaultValue: "");
StorageData<String> psnFengKConfigStr=StorageData<String>(key: "psnFengKConfigStr", defaultValue: "");

//上次显示激励广告时间
StorageData<int> psnLastShowRewardAdTime=StorageData<int>(key: "psnLastShowRewardAdTime", defaultValue: 0);
//两次激励广告的时间很小的次数统计
StorageData<int> psnTwoRewardAdTimeNum=StorageData<int>(key: "psnTwoRewardAdTimeNum", defaultValue: 0);

//开始显示激励广告的时间
StorageData<int> psnShowRewardAdTime=StorageData<int>(key: "psnShowRewardAdTime", defaultValue: 0);
//播放到关闭激励广告的时间小的次数统计
StorageData<int> psnCloseRewardAdTimeNum=StorageData<int>(key: "psnCloseRewardAdTimeNum", defaultValue: 0);

//获取激励广告奖励次数
StorageData<int> psnRewardRevenuePaidNum=StorageData<int>(key: "psnRewardRevenuePaidNum", defaultValue: 0);

//达到提现门槛，视频次数小于3次，被风控
StorageData<bool> psnDeemAdLess=StorageData<bool>(key: "psnDeemAdLess", defaultValue: false);
//视频次数大于90次，没有达到提现门槛，被风控
StorageData<bool> psnDeemAdMore=StorageData<bool>(key: "psnDeemAdMore", defaultValue: false);