class StartJournyModel {
  bool? success;
  String? status;
  int? statusCode;
  List<Data>? data;
  String? message;
  Null? pagination;
  String? serverTimezone;
  String? serverDateTime;


  StartJournyModel(
      {this.success,
        this.status,
        this.statusCode,
        this.data,
        this.message,
        this.pagination,
        this.serverTimezone,
        this.serverDateTime});

  StartJournyModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    status = json['status'];
    statusCode = json['status_code'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
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
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    data['pagination'] = this.pagination;
    data['serverTimezone'] = this.serverTimezone;
    data['serverDateTime'] = this.serverDateTime;
    return data;
  }
}

class Data {
  int? id;
  int? status;
  Null? createdBy;
  Null? modifiedBy;
  String? createdAt;
  String? updatedAt;
  String? name;
  String? address;
  String? area;
  String? email;
  String? lat;
  String? lng;
  String? contact;
  String? whatsapp;

  Data(
      {this.id,
        this.status,
        this.createdBy,
        this.modifiedBy,
        this.createdAt,
        this.updatedAt,
        this.name,
        this.address,
        this.area,
        this.email,
        this.lat,
        this.lng,
        this.contact,
        this.whatsapp});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    status = json['status'];
    createdBy = json['created_by'];
    modifiedBy = json['modified_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    name = json['name'];
    address = json['address'];
    area = json['area'];
    email = json['email'];
    lat = json['lat'];
    lng = json['lng'];
    contact = json['contact'];
    whatsapp = json['whatsapp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['status'] = this.status;
    data['created_by'] = this.createdBy;
    data['modified_by'] = this.modifiedBy;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['name'] = this.name;
    data['address'] = this.address;
    data['area'] = this.area;
    data['email'] = this.email;
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    data['contact'] = this.contact;
    data['whatsapp'] = this.whatsapp;
    return data;
  }
}
