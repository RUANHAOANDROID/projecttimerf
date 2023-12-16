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
  final String? phone = jsonConvert.convert<String>(json['phone']);
  if (phone != null) {
    customer.phone = phone;
  }
  final String? address = jsonConvert.convert<String>(json['address']);
  if (address != null) {
    customer.address = address;
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
  final String? version = jsonConvert.convert<String>(json['version']);
  if (version != null) {
    customer.version = version;
  }
  final String? brand = jsonConvert.convert<String>(json['brand']);
  if (brand != null) {
    customer.brand = brand;
  }
  final String? remark1 = jsonConvert.convert<String>(json['remark_1']);
  if (remark1 != null) {
    customer.remark1 = remark1;
  }
  final String? remark2 = jsonConvert.convert<String>(json['remark_2']);
  if (remark2 != null) {
    customer.remark2 = remark2;
  }
  return customer;
}

Map<String, dynamic> $CustomerToJson(Customer entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['name'] = entity.name;
  data['phone'] = entity.phone;
  data['address'] = entity.address;
  data['use_time'] = entity.useTime;
  data['end_time'] = entity.endTime;
  data['purchased'] = entity.purchased;
  data['version'] = entity.version;
  data['brand'] = entity.brand;
  data['remark_1'] = entity.remark1;
  data['remark_2'] = entity.remark2;
  return data;
}

extension CustomerExtension on Customer {
  Customer copyWith({
    int? id,
    String? name,
    String? phone,
    String? address,
    int? useTime,
    int? endTime,
    int? purchased,
    String? version,
    String? brand,
    String? remark1,
    String? remark2,
  }) {
    return Customer()
      ..id = id ?? this.id
      ..name = name ?? this.name
      ..phone = phone ?? this.phone
      ..address = address ?? this.address
      ..useTime = useTime ?? this.useTime
      ..endTime = endTime ?? this.endTime
      ..purchased = purchased ?? this.purchased
      ..version = version ?? this.version
      ..brand = brand ?? this.brand
      ..remark1 = remark1 ?? this.remark1
      ..remark2 = remark2 ?? this.remark2;
  }
}