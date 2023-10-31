class UpdateNotification {
  String? id;
  bool? read;

  UpdateNotification({this.id, this.read});

  UpdateNotification.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    read = json['read'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['read'] = this.read;
    return data;
  }
}
