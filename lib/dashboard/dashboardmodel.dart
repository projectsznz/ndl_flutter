class DashboardModel {
  bool? success;
  String? status;
  int? statusCode;
  List<Data>? data;
  String? message;
  String? serverTimezone;
  String? serverDateTime;

  DashboardModel(
      {this.success,
        this.status,
        this.statusCode,
        this.data,
        this.message,
        this.serverTimezone,
        this.serverDateTime});

  DashboardModel.fromJson(Map<String, dynamic> json) {
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
    data['serverTimezone'] = this.serverTimezone;
    data['serverDateTime'] = this.serverDateTime;
    return data;
  }
}

class Data {
  int? id;
  int? status;
  int? createdBy;
  var modifiedBy;
  String? createdAt;
  String? updatedAt;
  String? mode;
  int? routeMasterId;
  int? driverId;
  int? vehicleId;
  String? date;
  String? routeMasterName;
  String? routeMasterUnloadPoint;
  int? usertype;
  String? driverName;
  String? driverEmail;
  String? driverPhoto;
  String? vehicleName;
  String? vehicleNumber;
  String? fuelType;
  String? vehicleType;
  List<Apartment>? apartment;

  Data(
      {this.id,
        this.status,
        this.createdBy,
        this.modifiedBy,
        this.createdAt,
        this.updatedAt,
        this.mode,
        this.routeMasterId,
        this.driverId,
        this.vehicleId,
        this.date,
        this.routeMasterName,
        this.routeMasterUnloadPoint,
        this.usertype,
        this.driverName,
        this.driverEmail,
        this.driverPhoto,
        this.vehicleName,
        this.vehicleNumber,
        this.fuelType,
        this.vehicleType,
        this.apartment});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    status = json['status'];
    createdBy = json['created_by'];
    modifiedBy = json['modified_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    mode = json['mode'];
    routeMasterId = json['route_master_id'];
    driverId = json['driver_id'];
    vehicleId = json['vehicle_id'];
    date = json['date'];
    routeMasterName = json['route_master_name'];
    routeMasterUnloadPoint = json['route_master_unload_point'];
    usertype = json['usertype'];
    driverName = json['driver_name'];
    driverEmail = json['driver_email'];
    driverPhoto = json['driver_photo'];
    vehicleName = json['vehicle_name'];
    vehicleNumber = json['vehicle_number'];
    fuelType = json['fuel_type'];
    vehicleType = json['vehicle_type'];
    if (json['apartment'] != null) {
      apartment = <Apartment>[];
      json['apartment'].forEach((v) {
        apartment!.add(new Apartment.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['status'] = this.status;
    data['created_by'] = this.createdBy;
    data['modified_by'] = this.modifiedBy;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['mode'] = this.mode;
    data['route_master_id'] = this.routeMasterId;
    data['driver_id'] = this.driverId;
    data['vehicle_id'] = this.vehicleId;
    data['date'] = this.date;
    data['route_master_name'] = this.routeMasterName;
    data['route_master_unload_point'] = this.routeMasterUnloadPoint;
    data['usertype'] = this.usertype;
    data['driver_name'] = this.driverName;
    data['driver_email'] = this.driverEmail;
    data['driver_photo'] = this.driverPhoto;
    data['vehicle_name'] = this.vehicleName;
    data['vehicle_number'] = this.vehicleNumber;
    data['fuel_type'] = this.fuelType;
    data['vehicle_type'] = this.vehicleType;
    if (this.apartment != null) {
      data['apartment'] = this.apartment!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Apartment {
  int? id;
  int? status;
  var createdBy;
  var modifiedBy;
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

  Apartment(
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

  Apartment.fromJson(Map<String, dynamic> json) {
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
