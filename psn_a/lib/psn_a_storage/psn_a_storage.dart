import 'package:psn_a/psn_a_storage/psn_a_storage_name.dart';
import 'package:psn_root/psn_root_utils/psn_root_export.dart';

StorageData<int> aUserCoins=StorageData<int>(key: PsnAStorageName.aUserCoins, defaultValue: 0);
StorageData<int> aUserPlayNum=StorageData<int>(key: PsnAStorageName.aUserPlayNum, defaultValue: 0);


StorageData<bool> aBackMusicSwitch=StorageData<bool>(key: PsnAStorageName.aBackMusicSwitch, defaultValue: true);
StorageData<bool> aVoiceMusicSwitch=StorageData<bool>(key: PsnAStorageName.aVoiceMusicSwitch, defaultValue: true);

