import 'package:ptf/generated/json/base/json_convert_content.dart';
import 'package:ptf/models/customer_page_entity.dart';

import '../../models/customer_entity.dart';


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