class LoginModel {
  bool? success;
  String? status;
  int? statusCode;
  Data? data;
  String? message;
  Null? pagination;
  String? serverTimezone;
  String? serverDateTime;

  LoginModel(
      {this.success,
        this.status,
        this.statusCode,
        this.data,
        this.message,
        this.pagination,
        this.serverTimezone,
        this.serverDateTime});

  LoginModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    status = json['status'];
    statusCode = json['status_code'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    message = json['message'];
    pagination = json['pagination'];
    serverTimezone = json['serverTimezone'];
    serverDateTime = json['serverDateTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['status'] = this.status;
    data['status_code'] = this.statusCode;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = this.message;
    data['pagination'] = this.pagination;
    data['serverTimezone'] = this.serverTimezone;
    data['serverDateTime'] = this.serverDateTime;
    return data;
  }
}

class Data {
  String? token;
  String? name;
  int? type;
  int? id;
  int? driverId;
  String? licenseCopy;
  String? licenseNo;
  String? usertype;
  String? phone;
  String? email;
  String? emailVerifiedAt;
  String? photo;
  String? lastAccessAt;
  int? status;
  String? createdAt;
  List<String>? weightUnits;
  int? routeId;
  int? wastageId;

  Data(
      {this.token,
        this.name,
        this.type,
        this.id,
        this.driverId,
        this.licenseCopy,
        this.licenseNo,
        this.usertype,
        this.phone,
        this.email,
        this.emailVerifiedAt,
        this.photo,
        this.lastAccessAt,
        this.status,
        this.createdAt,
        this.weightUnits,
        this.routeId,
        this.wastageId});

  Data.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    name = json['name'];
    type = json['type'];
    id = json['id'];
    driverId = json['driver_id'];
    licenseCopy = json['license_copy'];
    licenseNo = json['license_no'];
    usertype = json['usertype'];
    phone = json['phone'];
    email = json['email '];
    emailVerifiedAt = json['email_verified_at'];
    photo = json['photo'];
    lastAccessAt = json['last_access_at'];
    status = json['status'];
    createdAt = json['created_at'];
    weightUnits = json['weight_units'].cast<String>();
    routeId = json['route_id'];
    wastageId = json['wastage_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    data['name'] = this.name;
    data['type'] = this.type;
    data['id'] = this.id;
    data['driver_id'] = this.driverId;
    data['license_copy'] = this.licenseCopy;
    data['license_no'] = this.licenseNo;
    data['usertype'] = this.usertype;
    data['phone'] = this.phone;
    data['email '] = this.email;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['photo'] = this.photo;
    data['last_access_at'] = this.lastAccessAt;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['weight_units'] = this.weightUnits;
    data['route_id'] = this.routeId;
    data['wastage_id'] = this.wastageId;
    return data;
  }
}