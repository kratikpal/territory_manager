class NotificationListResponse {
  String? returnMessage;
  List<Notifications>? notifications;

  NotificationListResponse({this.returnMessage, this.notifications});

  NotificationListResponse.fromJson(Map<String, dynamic> json) {
    returnMessage = json['return_message'];
    if (json['notifications'] != null) {
      notifications = <Notifications>[];
      json['notifications'].forEach((v) {
        notifications!.add(Notifications.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['return_message'] = returnMessage;
    if (notifications != null) {
      data['notifications'] =
          notifications!.map((v) => v.toJson()).toList();
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['title'] = title;
    data['msg'] = msg;
    data['added_for'] = addedFor;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}
