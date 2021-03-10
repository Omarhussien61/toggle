class Client {
  int id;
  int wid;
  String name;
  String at;

  Client({this.id, this.wid, this.name, this.at});

  Client.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    wid = json['wid'];
    name = json['name'];
    at = json['at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['wid'] = this.wid;
    data['name'] = this.name;
    data['at'] = this.at;
    return data;
  }
}
