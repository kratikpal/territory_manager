class NotificationListResponse {
  String? returnMessage;
  List<Notifications>? notifications;

  NotificationListResponse({this.returnMessage, this.notifications});

  NotificationListResponse.fromJson(Map<String, dynamic> json) {
    returnMessage = json['return_message'];
    if (json['notifications'] != null) {
      notifications = <Notifications>[];
      json['notifications'].forEach((v) {
        notifications!.add(new Notifications.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['return_message'] = this.returnMessage;
    if (this.notifications != null) {
      data['notifications'] =
          this.notifications!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Notifications {
  String? sId;
  String? title;
  String? msg;
  String? addedFor;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Notifications(
      {this.sId,
        this.title,
        this.msg,
        this.addedFor,
        this.createdAt,
        this.updatedAt,
        this.iV});

  Notifications.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    msg = json['msg'];
    addedFor = json['added_for'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['title'] = this.title;
    data['msg'] = this.msg;
    data['added_for'] = this.addedFor;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}
