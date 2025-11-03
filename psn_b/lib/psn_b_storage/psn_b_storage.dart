import 'package:psn_b/psn_b_storage/psn_b_storage_name.dart';
import 'package:psn_root/psn_root_utils/psn_root_export.dart';

StorageData<double> bUserCoins=StorageData<double>(key: PsnBStorageName.bUserCoins, defaultValue: 0.0);
StorageData<int> bUserPlayNum=StorageData<int>(key: PsnBStorageName.bUserPlayNum, defaultValue: 0);
StorageData<int> bLastBoxTimer=StorageData<int>(key: PsnBStorageName.bLastBoxTimer, defaultValue: 0);
StorageData<int> bLastCoinsLevel=StorageData<int>(key: PsnBStorageName.bLastCoinsLevel, defaultValue: 0);
StorageData<int> bCardProgress=StorageData<int>(key: PsnBStorageName.bCardProgress, defaultValue: 0);

StorageData<bool> bShowOpenAd=StorageData<bool>(key: PsnBStorageName.bShowOpenAd, defaultValue: false);
StorageData<bool> bShowNewUserGuide=StorageData<bool>(key: PsnBStorageName.bShowNewUserGuide, defaultValue: true);
StorageData<bool> bAlreadyShowCashTipsDialog=StorageData<bool>(key: PsnBStorageName.bAlreadyShowCashTipsDialog, defaultValue: false);

StorageData<String> bLastShowBoxGuideTimer=StorageData<String>(key: PsnBStorageName.bLastShowBoxGuideTimer, defaultValue: "");

