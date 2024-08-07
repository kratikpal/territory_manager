class RejectedApplicationResponse {
  String? sId;
  String? name;
  String? tradeName;
  String? address;
  String? state;
  String? city;
  String? district;
  String? pincode;
  String? mobileNumber;
  PrincipalDistributer? principalDistributer;
  String? panNumber;
  PanImg? panImg;
  String? aadharNumber;
  PanImg? aadharImg;
  String? gstNumber;
  PanImg? gstImg;
  PanImg? pesticideLicenseImg;
  PanImg? fertilizerLicenseImg;
  PanImg? selfieEntranceImg;
  String? status;
  String? addedBy;
  List<Notes>? notes;
  String? createdAt;
  String? updatedAt;
  int? iV;

  RejectedApplicationResponse(
      {this.sId,
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
        this.fertilizerLicenseImg,
        this.selfieEntranceImg,
        this.status,
        this.addedBy,
        this.notes,
        this.createdAt,
        this.updatedAt,
        this.iV});

  RejectedApplicationResponse.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    tradeName = json['trade_name'];
    address = json['address'];
    state = json['state'];
    city = json['city'];
    district = json['district'];
    pincode = json['pincode'];
    mobileNumber = json['mobile_number'];
    principalDistributer = json['principal_distributer'] != null
        ? PrincipalDistributer.fromJson(json['principal_distributer'])
        : null;
    panNumber = json['pan_number'];
    panImg =
    json['pan_img'] != null ? PanImg.fromJson(json['pan_img']) : null;
    aadharNumber = json['aadhar_number'];
    aadharImg = json['aadhar_img'] != null
        ? PanImg.fromJson(json['aadhar_img'])
        : null;
    gstNumber = json['gst_number'];
    gstImg =
    json['gst_img'] != null ? PanImg.fromJson(json['gst_img']) : null;
    pesticideLicenseImg = json['pesticide_license_img'] != null
        ? PanImg.fromJson(json['pesticide_license_img'])
        : null;
    fertilizerLicenseImg = json['fertilizer_license_img'] != null
        ? PanImg.fromJson(json['fertilizer_license_img'])
        : null;
    selfieEntranceImg = json['selfie_entrance_img'] != null
        ? PanImg.fromJson(json['selfie_entrance_img'])
        : null;
    status = json['status'];
   // addedBy = json['addedBy'];
    if (json['notes'] != null) {
      notes = <Notes>[];
      json['notes'].forEach((v) {
        notes!.add(Notes.fromJson(v));
      });
    }
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['name'] = name;
    data['trade_name'] = tradeName;
    data['address'] = address;
    data['state'] = state;
    data['city'] = city;
    data['district'] = district;
    data['pincode'] = pincode;
    data['mobile_number'] = mobileNumber;
    if (principalDistributer != null) {
      data['principal_distributer'] = principalDistributer!.toJson();
    }
    data['pan_number'] = panNumber;
    if (panImg != null) {
      data['pan_img'] = panImg!.toJson();
    }
    data['aadhar_number'] = aadharNumber;
    if (aadharImg != null) {
      data['aadhar_img'] = aadharImg!.toJson();
    }
    data['gst_number'] = gstNumber;
    if (gstImg != null) {
      data['gst_img'] = gstImg!.toJson();
    }
    if (pesticideLicenseImg != null) {
      data['pesticide_license_img'] = pesticideLicenseImg!.toJson();
    }
    if (fertilizerLicenseImg != null) {
      data['fertilizer_license_img'] = fertilizerLicenseImg!.toJson();
    }
    if (selfieEntranceImg != null) {
      data['selfie_entrance_img'] = selfieEntranceImg!.toJson();
    }
    data['status'] = status;
    data['addedBy'] = addedBy;
    if (notes != null) {
      data['notes'] = notes!.map((v) => v.toJson()).toList();
    }
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}

class PrincipalDistributer {
  String? sId;
  String? name;

  PrincipalDistributer({this.sId, this.name});

  PrincipalDistributer.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['name'] = name;
    return data;
  }
}

class PanImg {
  String? publicId;
  String? url;

  PanImg({this.publicId, this.url});

  PanImg.fromJson(Map<String, dynamic> json) {
    publicId = json['public_id'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['public_id'] = publicId;
    data['url'] = url;
    return data;
  }
}

class Notes {
  String? message;
  String? user;
  String? replyDate;
  String? sId;

  Notes({this.message, this.user, this.replyDate, this.sId});

  Notes.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    user = json['user'];
    replyDate = json['replyDate'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['user'] = user;
    data['replyDate'] = replyDate;
    data['_id'] = sId;
    return data;
  }
}
