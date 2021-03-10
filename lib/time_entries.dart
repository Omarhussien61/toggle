class Time_Entries {
  int id;
  String guid;
  int wid;
  bool billable;
  String start;
  String stop;
  int duration;
  String description;
  bool duronly;
  String at;
  int uid;

  Time_Entries(
      {this.id,
        this.guid,
        this.wid,
        this.billable,
        this.start,
        this.stop,
        this.duration,
        this.description,
        this.duronly,
        this.at,
        this.uid});

  Time_Entries.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    guid = json['guid'];
    wid = json['wid'];
    billable = json['billable'];
    start = json['start'];
    stop = json['stop'];
    duration = json['duration'];
    description = json['description'];
    duronly = json['duronly'];
    at = json['at'];
    uid = json['uid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['guid'] = this.guid;
    data['wid'] = this.wid;
    data['billable'] = this.billable;
    data['start'] = this.start;
    data['stop'] = this.stop;
    data['duration'] = this.duration;
    data['description'] = this.description;
    data['duronly'] = this.duronly;
    data['at'] = this.at;
    data['uid'] = this.uid;
    return data;
  }
}
