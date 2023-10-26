import 'package:ptf/generated/json/base/json_field.dart';
import 'package:ptf/generated/json/customer_page_entity.g.dart';
import 'dart:convert';
export 'package:ptf/generated/json/customer_page_entity.g.dart';

@JsonSerializable()
class CustomerPageEntity {
	int? code = 0;
	String? msg = '';
	CustomerPageData? data;

	CustomerPageEntity();

	factory CustomerPageEntity.fromJson(Map<String, dynamic> json) => $CustomerPageEntityFromJson(json);

	Map<String, dynamic> toJson() => $CustomerPageEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

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

@JsonSerializable()
class Customer {
	int? id = 0;
	String? name = '';
	String? phone = '';
	String? address = '';
	@JSONField(name: "use_time")
	int useTime = 0;
	@JSONField(name: "end_time")
	int endTime = 0;

	Customer();
	factory Customer.fromJson(Map<String, dynamic> json) => $CustomerFromJson(json);

	Map<String, dynamic> toJson() => $CustomerToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}