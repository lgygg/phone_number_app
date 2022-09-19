
class AreaCodeInfo {
  late Map<String, dynamic> info;

  AreaCodeInfo({this.info = const {}});

  AreaCodeInfo.fromMap(Map<String, dynamic> json) {
    this.info = json;
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['info'] = this.info;
    return data;
  }
}
