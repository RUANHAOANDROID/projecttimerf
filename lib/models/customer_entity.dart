import 'package:ptf/generated/json/base/json_field.dart';
import 'dart:convert';

import '../generated/json/customer_entity.g.dart';

@JsonSerializable()
class Customer {
	int  id = 0;
	String  name = '';
	String  brand = '';
	String  version = '';
	int  pos = 0;
	int  server = 0;
	@JSONField(name: "pos_droid")
	int  posDroid = 0;
	int  other = 0;
	// String  phone = '';
	// String  address = '';
	@JSONField(name: "use_time")
	int useTime = 0;
	@JSONField(name: "end_time")
	int endTime = 0;
	int purchased = 0;
	String remark = '';
	String salesman   ='';
	String technician   ='';
	String customize1 = '';
	String customize2 = '';

	Customer();

	factory Customer.fromJson(Map<String, dynamic> json) => $CustomerFromJson(json);

	Map<String, dynamic> toJson() => $CustomerToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}