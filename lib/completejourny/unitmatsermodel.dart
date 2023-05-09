class unitmastermodel {
  bool? success;
  String? status;
  int? statusCode;
  List<Data>? data;
  String? message;
  String? serverTimezone;
  String? serverDateTime;

  unitmastermodel(
      {this.success,
        this.status,
        this.statusCode,
        this.data,
        this.message,
        this.serverTimezone,
        this.serverDateTime});

  unitmastermodel.fromJson(Map<String, dynamic> json) {
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
  String? name;
  int? status;
  int? createdBy;
  String? createdAt;

  Data({this.id, this.name, this.status, this.createdBy, this.createdAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    status = json['status'];
    createdBy = json['created_by'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['status'] = this.status;
    data['created_by'] = this.createdBy;
    data['created_at'] = this.createdAt;
    return data;
  }
}
