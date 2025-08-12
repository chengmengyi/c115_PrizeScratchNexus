import 'package:psn_b/psn_b_storage/psn_b_storage_name.dart';
import 'package:psn_root/psn_root_utils/psn_root_export.dart';

StorageData<double> bUserCoins=StorageData<double>(key: PsnBStorageName.bUserCoins, defaultValue: 0.0);
StorageData<int> bUserPlayNum=StorageData<int>(key: PsnBStorageName.bUserPlayNum, defaultValue: 0);
StorageData<int> bLastBoxTimer=StorageData<int>(key: PsnBStorageName.bLastBoxTimer, defaultValue: 0);


StorageData<bool> bBackMusicSwitch=StorageData<bool>(key: PsnBStorageName.bBackMusicSwitch, defaultValue: true);
StorageData<bool> bVoiceMusicSwitch=StorageData<bool>(key: PsnBStorageName.bVoiceMusicSwitch, defaultValue: true);

