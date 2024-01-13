import 'package:ptf/generated/json/base/json_convert_content.dart';
import 'package:ptf/models/customer_entity.dart';

Customer $CustomerFromJson(Map<String, dynamic> json) {
  final Customer customer = Customer();
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    customer.id = id;
  }
  final String? name = jsonConvert.convert<String>(json['name']);
  if (name != null) {
    customer.name = name;
  }
  final String? brand = jsonConvert.convert<String>(json['brand']);
  if (brand != null) {
    customer.brand = brand;
  }
  final String? version = jsonConvert.convert<String>(json['version']);
  if (version != null) {
    customer.version = version;
  }
  final int? pos = jsonConvert.convert<int>(json['pos']);
  if (pos != null) {
    customer.pos = pos;
  }
  final int? server = jsonConvert.convert<int>(json['server']);
  if (server != null) {
    customer.server = server;
  }
  final int? posDroid = jsonConvert.convert<int>(json['pos_droid']);
  if (posDroid != null) {
    customer.posDroid = posDroid;
  }
  final int? other = jsonConvert.convert<int>(json['other']);
  if (other != null) {
    customer.other = other;
  }
  final int? useTime = jsonConvert.convert<int>(json['use_time']);
  if (useTime != null) {
    customer.useTime = useTime;
  }
  final int? endTime = jsonConvert.convert<int>(json['end_time']);
  if (endTime != null) {
    customer.endTime = endTime;
  }
  final int? purchased = jsonConvert.convert<int>(json['purchased']);
  if (purchased != null) {
    customer.purchased = purchased;
  }
  final String? remark = jsonConvert.convert<String>(json['remark']);
  if (remark != null) {
    customer.remark = remark;
  }
  final String? salesman = jsonConvert.convert<String>(json['salesman']);
  if (salesman != null) {
    customer.salesman = salesman;
  }
  final String? technician = jsonConvert.convert<String>(json['technician']);
  if (technician != null) {
    customer.technician = technician;
  }
  final String? customize1 = jsonConvert.convert<String>(json['customize1']);
  if (customize1 != null) {
    customer.customize1 = customize1;
  }
  final String? customize2 = jsonConvert.convert<String>(json['customize2']);
  if (customize2 != null) {
    customer.customize2 = customize2;
  }
  return customer;
}

Map<String, dynamic> $CustomerToJson(Customer entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['name'] = entity.name;
  data['brand'] = entity.brand;
  data['version'] = entity.version;
  data['pos'] = entity.pos;
  data['server'] = entity.server;
  data['pos_droid'] = entity.posDroid;
  data['other'] = entity.other;
  data['use_time'] = entity.useTime;
  data['end_time'] = entity.endTime;
  data['purchased'] = entity.purchased;
  data['remark'] = entity.remark;
  data['salesman'] = entity.salesman;
  data['technician'] = entity.technician;
  data['customize1'] = entity.customize1;
  data['customize2'] = entity.customize2;
  return data;
}

extension CustomerExtension on Customer {
  Customer copyWith({
    int? id,
    String? name,
    String? brand,
    String? version,
    int? pos,
    int? server,
    int? posDroid,
    int? other,
    int? useTime,
    int? endTime,
    int? purchased,
    String? remark,
    String? salesman,
    String? technician,
    String? customize1,
    String? customize2,
  }) {
    return Customer()
      ..id = id ?? this.id
      ..name = name ?? this.name
      ..brand = brand ?? this.brand
      ..version = version ?? this.version
      ..pos = pos ?? this.pos
      ..server = server ?? this.server
      ..posDroid = posDroid ?? this.posDroid
      ..other = other ?? this.other
      ..useTime = useTime ?? this.useTime
      ..endTime = endTime ?? this.endTime
      ..purchased = purchased ?? this.purchased
      ..remark = remark ?? this.remark
      ..salesman = salesman ?? this.salesman
      ..technician = technician ?? this.technician
      ..customize1 = customize1 ?? this.customize1
      ..customize2 = customize2 ?? this.customize2;
  }
}