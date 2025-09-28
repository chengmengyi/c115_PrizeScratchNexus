class PsnRankBean {
  PsnRankBean({
      this.cashType, 
      this.cashMoney, 
      this.currentRank, 
      this.totalRank,});

  PsnRankBean.fromJson(dynamic json) {
    cashType = json['cashType'];
    cashMoney = json['cashMoney'];
    currentRank = json['currentRank'];
    totalRank = json['totalRank'];
  }
  String? cashType;
  int? cashMoney;
  int? currentRank;
  int? totalRank;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['cashType'] = cashType;
    map['cashMoney'] = cashMoney;
    map['currentRank'] = currentRank;
    map['totalRank'] = totalRank;
    return map;
  }

}