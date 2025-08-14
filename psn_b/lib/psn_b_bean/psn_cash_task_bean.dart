class PsnCashTaskBean {
  PsnCashTaskBean({
      this.cashType, 
      this.cashMoney, 
      this.completed, 
      this.cashTaskId, 
      this.currentProgress, 
      this.totalProgress,});

  PsnCashTaskBean.fromJson(dynamic json) {
    cashType = json['cashType'];
    cashMoney = json['cashMoney'];
    completed = json['completed'];
    cashTaskId = json['cashTaskId'];
    currentProgress = json['currentProgress'];
    totalProgress = json['totalProgress'];
  }
  String? cashType;
  int? cashMoney;
  int? completed;
  int? cashTaskId;
  int? currentProgress;
  int? totalProgress;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['cashType'] = cashType;
    map['cashMoney'] = cashMoney;
    map['completed'] = completed;
    map['cashTaskId'] = cashTaskId;
    map['currentProgress'] = currentProgress;
    map['totalProgress'] = totalProgress;
    return map;
  }

}