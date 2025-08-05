class PsnACardBean {
  PsnACardBean({
      this.cardType, 
      this.cardNum, 
      this.unlock,});

  PsnACardBean.fromJson(dynamic json) {
    cardType = json['cardType'];
    cardNum = json['cardNum'];
    unlock = json['unlock'];
  }
  String? cardType;
  int? cardNum;
  int? unlock;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['cardType'] = cardType;
    map['cardNum'] = cardNum;
    map['unlock'] = unlock;
    return map;
  }

}