import 'package:psn_root/psn_root_utils/psn_tba/psn_b_base_tba_bean.dart';
import 'package:psn_root/psn_root_utils/psn_tba_point_enum.dart';

class PsnBPointTbaBean{
  Future<Map<String,dynamic>> getPointMap(PsnTbaPointEnum pointEnum,Map<String,dynamic>? map)async{
    var baseMap = await PsnBBaseTbaBean().getBaseMap();
    baseMap["oneill"]=pointEnum.name;
    if(null!=map){
      baseMap[pointEnum.name]=map;
    }
    return baseMap;
  }
}