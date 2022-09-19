class PhoneInfo {
  late String id;
  late String areaCode; //区号
  late String number; //电话号码

  PhoneInfo({this.id = "",this.areaCode = "", this.number = ""});

  PhoneInfo.fromMap(Map<String, dynamic> json) {
    this.id = json['id'];
    this.areaCode = json['areaCode'];
    this.number = json['number'];
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['areaCode'] = this.areaCode;
    data['number'] = this.number;
    return data;
  }
}
