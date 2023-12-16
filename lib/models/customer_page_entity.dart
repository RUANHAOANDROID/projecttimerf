import 'package:ptf/generated/json/base/json_field.dart';
import 'package:ptf/generated/json/customer_page_entity.g.dart';
import 'dart:convert';

import 'customer_entity.dart';
export 'package:ptf/generated/json/customer_page_entity.g.dart';
@JsonSerializable()
class CustomerPageData {
	int count = 0;
	List<Customer>? data = [];

	CustomerPageData();

	factory CustomerPageData.fromJson(Map<String, dynamic> json) => $CustomerPageDataFromJson(json);

	Map<String, dynamic> toJson() => $CustomerPageDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}