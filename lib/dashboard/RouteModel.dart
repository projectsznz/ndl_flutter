class RouteModel {
  bool? success;
  String? status;
  int? statusCode;
  List<Data>? data;
  String? message;
  Null? pagination;
  String? serverTimezone;
  String? serverDateTime;

  RouteModel(
      {this.success,
        this.status,
        this.statusCode,
        this.data,
        this.message,
        this.pagination,
        this.serverTimezone,
        this.serverDateTime});

  RouteModel.fromJson(Map<String, dynamic> json) {
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
  int? routeId;
  int? apartmentId;
  Null? remarks;
  String? apratmentsName;
  String? apratmentsAddress;
  String? apratmentsArea;
  String? apratmentsEmail;
  String? apratmentsLat;
  String? apratmentsLng;
  String? apratmentsContact;
  String? apratmentsWhatsapp;
  Null? wastageName;
  Null? wastageId;

  Data(
      {this.id,
        this.status,
        this.createdBy,
        this.modifiedBy,
        this.createdAt,
        this.updatedAt,
        this.routeId,
        this.apartmentId,
        this.remarks,
        this.apratmentsName,
        this.apratmentsAddress,
        this.apratmentsArea,
        this.apratmentsEmail,
        this.apratmentsLat,
        this.apratmentsLng,
        this.apratmentsContact,
        this.apratmentsWhatsapp,
        this.wastageName,
        this.wastageId});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    status = json['status'];
    createdBy = json['created_by'];
    modifiedBy = json['modified_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    routeId = json['route_id'];
    apartmentId = json['apartment_id'];
    remarks = json['remarks'];
    apratmentsName = json['apratments_name'];
    apratmentsAddress = json['apratments_address'];
    apratmentsArea = json['apratments_area'];
    apratmentsEmail = json['apratments_email'];
    apratmentsLat = json['apratments_lat'];
    apratmentsLng = json['apratments_lng'];
    apratmentsContact = json['apratments_contact'];
    apratmentsWhatsapp = json['apratments_whatsapp'];
    wastageName = json['wastage_name'];
    wastageId = json['wastage_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['status'] = this.status;
    data['created_by'] = this.createdBy;
    data['modified_by'] = this.modifiedBy;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['route_id'] = this.routeId;
    data['apartment_id'] = this.apartmentId;
    data['remarks'] = this.remarks;
    data['apratments_name'] = this.apratmentsName;
    data['apratments_address'] = this.apratmentsAddress;
    data['apratments_area'] = this.apratmentsArea;
    data['apratments_email'] = this.apratmentsEmail;
    data['apratments_lat'] = this.apratmentsLat;
    data['apratments_lng'] = this.apratmentsLng;
    data['apratments_contact'] = this.apratmentsContact;
    data['apratments_whatsapp'] = this.apratmentsWhatsapp;
    data['wastage_name'] = this.wastageName;
    data['wastage_id'] = this.wastageId;
    return data;
  }
}
