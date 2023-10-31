class NotificationResponse {
  List<Notifications>? notifications;

  NotificationResponse({this.notifications});

  NotificationResponse.fromJson(Map<String, dynamic> json) {
    if (json['notifications'] != null) {
      notifications = <Notifications>[];
      json['notifications'].forEach((v) {
        notifications!.add(new Notifications.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.notifications != null) {
      data['notifications'] =
          this.notifications!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Notifications {
  String? id;
  String? userId;
  String? subject;
  String? content;
  int? notificationType;
  int? notificationStatus;
  String? dateCreated;
  String? dateOpened;

  Notifications(
      {this.id,
      this.userId,
      this.subject,
      this.content,
      this.notificationType,
      this.notificationStatus,
      this.dateCreated,
      this.dateOpened});

  Notifications.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    subject = json['subject'];
    content = json['content'];
    notificationType = json['notificationType'];
    notificationStatus = json['notificationStatus'];
    dateCreated = json['dateCreated'];
    dateOpened = json['dateOpened'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userId'] = this.userId;
    data['subject'] = this.subject;
    data['content'] = this.content;
    data['notificationType'] = this.notificationType;
    data['notificationStatus'] = this.notificationStatus;
    data['dateCreated'] = this.dateCreated;
    data['dateOpened'] = this.dateOpened;
    return data;
  }
}
