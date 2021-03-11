class Project {
  int id;
  int wid;
  String name;
  bool billable;
  bool isPrivate;
  bool active;
  bool template;
  String at;
  String createdAt;
  String color;
  bool autoEstimates;
  String hexColor;

  Project(
      {this.id,
        this.wid,
        this.name,
        this.billable,
        this.isPrivate,
        this.active,
        this.template,
        this.at,
        this.createdAt,
        this.color,
        this.autoEstimates,
        this.hexColor});

  Project.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    wid = json['wid'];
    name = json['name'];
    billable = json['billable'];
    isPrivate = json['is_private'];
    active = json['active'];
    template = json['template'];
    at = json['at'];
    createdAt = json['created_at'];
    color = json['color'];
    autoEstimates = json['auto_estimates'];
    hexColor = json['hex_color'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['wid'] = this.wid;
    data['name'] = this.name;
    data['billable'] = this.billable;
    data['is_private'] = this.isPrivate;
    data['active'] = this.active;
    data['template'] = this.template;
    data['at'] = this.at;
    data['created_at'] = this.createdAt;
    data['color'] = this.color;
    data['auto_estimates'] = this.autoEstimates;
    data['hex_color'] = this.hexColor;
    return data;
  }
}
