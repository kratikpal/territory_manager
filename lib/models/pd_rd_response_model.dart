class PdRdResponseModel {
  String? id;
  String? uniqueId;
  String? name;
  String? tradeName;
  String? address;
  String? state;
  String? city;
  String? district;
  String? pincode;
  String? mobileNumber;
  String? principalDistributer;
  String? panNumber;
  ImageModel? panImg;
  String? aadharNumber;
  ImageModel? aadharImg;
  String? gstNumber;
  ImageModel? gstImg;
  ImageModel? pesticideLicenseImg;
  ImageModel? selfieEntranceImg;
  String? status;
  String? addedBy;
  String? userType;
  List<Note>? notes;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  PdRdResponseModel({
    this.id,
    this.uniqueId,
    this.name,
    this.tradeName,
    this.address,
    this.state,
    this.city,
    this.district,
    this.pincode,
    this.mobileNumber,
    this.principalDistributer,
    this.panNumber,
    this.panImg,
    this.aadharNumber,
    this.aadharImg,
    this.gstNumber,
    this.gstImg,
    this.pesticideLicenseImg,
    this.selfieEntranceImg,
    this.status,
    this.addedBy,
    this.userType,
    this.notes,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory PdRdResponseModel.fromJson(Map<String, dynamic> json) =>
      PdRdResponseModel(
        id: json["_id"],
        name: json["name"],
        uniqueId: json["uniqueId"],
        // tradeName: json["trade_name"],
        // address: json["address"],
        // state: json["state"],
        // city: json["city"],
        // district: json["district"],
        // pincode: json["pincode"],
        // mobileNumber: json["mobile_number"],
        // principalDistributer: json["principal_distributer"],
        // panNumber: json["pan_number"],
        // panImg: ImageModel.fromJson(json["pan_img"]),
        // aadharNumber: json["aadhar_number"],
        // aadharImg: ImageModel.fromJson(json["aadhar_img"]),
        // gstNumber: json["gst_number"],
        // gstImg: ImageModel.fromJson(json["gst_img"]),
        // pesticideLicenseImg: ImageModel.fromJson(json["pesticide_license_img"]),
        // selfieEntranceImg: ImageModel.fromJson(json["selfie_entrance_img"]),
        // status: json["status"],
        // addedBy: json["addedBy"],
        // userType: json["userType"],
        // notes: List<Note>.from(json["notes"].map((x) => Note.fromJson(x))),
        // createdAt: DateTime.parse(json["createdAt"]),
        // updatedAt: DateTime.parse(json["updatedAt"]),
        // v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "uniqueId": uniqueId,
        // "trade_name": tradeName,
        // "address": address,
        // "state": state,
        // "city": city,
        // "district": district,
        // "pincode": pincode,
        // "mobile_number": mobileNumber,
        // "principal_distributer": principalDistributer,
        // "pan_number": panNumber,
        // "pan_img": panImg.toJson(),
        // "aadhar_number": aadharNumber,
        // "aadhar_img": aadharImg.toJson(),
        // "gst_number": gstNumber,
        // "gst_img": gstImg.toJson(),
        // "pesticide_license_img": pesticideLicenseImg.toJson(),
        // "selfie_entrance_img": selfieEntranceImg.toJson(),
        // "status": status,
        // "addedBy": addedBy,
        // "userType": userType,
        // "notes": List<dynamic>.from(notes.map((x) => x.toJson())),
        // "createdAt": createdAt.toIso8601String(),
        // "updatedAt": updatedAt.toIso8601String(),
        // "__v": v,
      };
}

class ImageModel {
  String? publicId;
  String? url;

  ImageModel({
    this.publicId,
    this.url,
  });

  factory ImageModel.fromJson(Map<String, dynamic> json) => ImageModel(
        publicId: json["public_id"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "public_id": publicId,
        "url": url,
      };
}

class Note {
  String? message;
  DateTime? replyDate;
  String? id;

  Note({
    this.message,
    this.replyDate,
    this.id,
  });

  factory Note.fromJson(Map<String, dynamic> json) => Note(
        message: json["message"],
        replyDate: DateTime.parse(json["replyDate"]),
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        // "replyDate": replyDate.toIso8601String(),
        "_id": id,
      };
}
