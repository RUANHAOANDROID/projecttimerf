import 'package:ptf/generated/json/base/json_field.dart';
import 'package:ptf/generated/json/customer_entity.g.dart';
import 'dart:convert';
export 'package:ptf/generated/json/customer_entity.g.dart';

@JsonSerializable()
class Customer {
	int id = 0;
	String? name = '';
	String? phone = '';
	String? address = '';
	@JSONField(name: "use_time")
	int useTime = 0;
	@JSONField(name: "end_time")
	int endTime = 0;
	int purchased = 0;
	String? version = '';
	String? brand = '';
	@JSONField(name: "remark_1")
	String? remark1 = '';
	@JSONField(name: "remark_2")
	String? remark2 = '';

	Customer();

	factory Customer.fromJson(Map<String, dynamic> json) => $CustomerFromJson(json);

	Map<String, dynamic> toJson() => $CustomerToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}