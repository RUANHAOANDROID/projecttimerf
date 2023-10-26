import 'package:ptf/generated/json/base/json_convert_content.dart';
import 'package:ptf/models/customer_page_entity.dart';

CustomerPageEntity $CustomerPageEntityFromJson(Map<String, dynamic> json) {
  final CustomerPageEntity customerPageEntity = CustomerPageEntity();
  final int? code = jsonConvert.convert<int>(json['code']);
  if (code != null) {
    customerPageEntity.code = code;
  }
  final String? msg = jsonConvert.convert<String>(json['msg']);
  if (msg != null) {
    customerPageEntity.msg = msg;
  }
  final CustomerPageData? data = jsonConvert.convert<CustomerPageData>(
      json['data']);
  if (data != null) {
    customerPageEntity.data = data;
  }
  return customerPageEntity;
}

Map<String, dynamic> $CustomerPageEntityToJson(CustomerPageEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['code'] = entity.code;
  data['msg'] = entity.msg;
  data['data'] = entity.data?.toJson();
  return data;
}

extension CustomerPageEntityExtension on CustomerPageEntity {
  CustomerPageEntity copyWith({
    int? code,
    String? msg,
    CustomerPageData? data,
  }) {
    return CustomerPageEntity()
      ..code = code ?? this.code
      ..msg = msg ?? this.msg
      ..data = data ?? this.data;
  }
}

CustomerPageData $CustomerPageDataFromJson(Map<String, dynamic> json) {
  final CustomerPageData customerPageData = CustomerPageData();
  final int? count = jsonConvert.convert<int>(json['count']);
  if (count != null) {
    customerPageData.count = count;
  }
  final List<Customer>? data = (json['data'] as List<dynamic>?)?.map(
          (e) => jsonConvert.convert<Customer>(e) as Customer).toList();
  if (data != null) {
    customerPageData.data = data;
  }
  return customerPageData;
}

Map<String, dynamic> $CustomerPageDataToJson(CustomerPageData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['count'] = entity.count;
  data['data'] = entity.data?.map((v) => v.toJson()).toList();
  return data;
}

extension CustomerPageDataExtension on CustomerPageData {
  CustomerPageData copyWith({
    int? count,
    List<Customer>? data,
  }) {
    return CustomerPageData()
      ..count = count ?? this.count
      ..data = data ?? this.data;
  }
}

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
  }) {
    return Customer()
      ..id = id ?? this.id
      ..name = name ?? this.name
      ..phone = phone ?? this.phone
      ..address = address ?? this.address
      ..useTime = useTime ?? this.useTime
      ..endTime = endTime ?? this.endTime;
  }
}