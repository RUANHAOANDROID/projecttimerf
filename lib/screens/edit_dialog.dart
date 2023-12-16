import 'dart:convert';

import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../responsive.dart';
import '../../../theme/theme.dart';
import '../../../utils/http.dart';
import 'dart:developer' as developer;

import '../models/customer_entity.dart';

class EditDialog extends StatefulWidget {
  final bool isCreate;
  Customer customer;
  var purchased = false;
  final _formKey = GlobalKey<FormState>();

  EditDialog({Key? key, required this.customer, required this.isCreate})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _EditDialog();
}

class _EditDialog extends State<EditDialog> {
  Future<bool> addCustomer() async {
    try {
      var state = widget._formKey.currentState;
      developer.log("addCustomer");
      if (state!.validate()) {
        setCustomer();
        var body = widget.customer;
        HttpUtils.post("/v1/addCustomer", jsonEncode(body));
        setState(() {
          Navigator.of(context).pop(true);
        });
      }
      return true;
    } catch (e) {
      developer.log("_EditDialog", error: e);
      return false;
    }
  }

  Future<bool> updateDevice() async {
    try {
      var state = widget._formKey.currentState;
      developer.log("updateDevice");
      if (state!.validate()) {
        setCustomer();
        var body = widget.customer;
        var response = HttpUtils.post("/v1/updateCustomer", jsonEncode(body));
        setState(() {
          Navigator.of(context).pop(true);
        });
      }
      return true;
    } catch (e) {
      developer.log("err", error: e);
      return false;
    }
  }

  TextEditingController tecName = TextEditingController();
  TextEditingController tecPhone = TextEditingController();
  TextEditingController tecAddress = TextEditingController();
  TextEditingController tecUseTime = TextEditingController();
  TextEditingController tecEndTime = TextEditingController();

  TextEditingController tecVersion = TextEditingController();
  TextEditingController tecBrand = TextEditingController();
  TextEditingController tecRemark1 = TextEditingController();
  TextEditingController tecRemark2 = TextEditingController();

  void checkParameter() {
    var state = widget._formKey.currentState;
    if (state!.validate()) {
    } else {}
  }

  @override
  void initState() {
    if (!widget.isCreate) {
      tecName.text = widget.customer?.name as String;
      tecPhone.text = widget.customer?.phone as String;
      tecAddress.text = widget.customer?.address as String;
      tecVersion.text = widget.customer?.version as String;
      tecBrand.text = widget.customer?.brand as String;
      tecRemark1.text = widget.customer?.remark1 as String;
      tecRemark2.text = widget.customer?.remark2 as String;
      widget.purchased = (widget.customer.purchased == 1);
      if (widget.customer.useTime != 0) {
        var useTime =
            DateTime.fromMillisecondsSinceEpoch(widget.customer.useTime);
        tecUseTime.text = "${useTime.year}-${useTime.month}-${useTime.day}";
      }
      if (widget.customer.endTime != 0) {
        var endTime =
            DateTime.fromMillisecondsSinceEpoch(widget.customer.useTime);
        tecEndTime.text = "${endTime.year}-${endTime.month}-${endTime.day}";
      }
    }
    super.initState();
  }

  void setCustomer() {
    widget.customer.name = tecName.text;
    widget.customer.phone = tecPhone.text;
    widget.customer.address = tecAddress.text;
    widget.customer.version = tecVersion.text;
    widget.customer.brand = tecBrand.text;
    widget.customer.remark1 = tecRemark1.text;
    widget.customer.remark2 = tecRemark2.text;
    widget.customer.purchased = widget.purchased ? 1 : 0;
    developer.log("${widget.customer.useTime}-${widget.customer.endTime}");
    // if (tecUseTime.text.isNotEmpty) {
    //   widget.customer.useTime = tecUseTime.text.trim() as int;
    // }
    // if (tecEndTime.text.isNotEmpty) {
    //   widget.customer.endTime = tecEndTime.text.trim() as int;
    // }
  }

  void _showDatePicker(bool isStart) async {
    await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2022),
            lastDate: DateTime(2025),
            locale: const Locale("zh"))
        .then((value) {
      if (value != null) {
        if (isStart) {
          widget.customer?.useTime = value.millisecondsSinceEpoch;
          tecUseTime.text = "${value.year}-${value.month}-${value.day}";
        } else {
          widget.customer?.endTime = value.millisecondsSinceEpoch;
          tecEndTime.text = "${value.year}-${value.month}-${value.day}";
        }
      }
    });
  }

  @override
  void dispose() {
    tecName.dispose();
    tecPhone.dispose();
    tecAddress.dispose();
    tecUseTime.dispose();
    tecEndTime.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const paddingAll = EdgeInsets.all(defaultPadding / 2);
    const leftRightTop = EdgeInsets.only(
        left: defaultPadding / 2,
        right: defaultPadding / 2,
        top: defaultPadding);

    var nameWidget = Padding(
      padding: leftRightTop,
      child: TextFormField(
        controller: tecName,
        validator: (value) {
          return value!.trim().isNotEmpty ? null : "姓名不能为空";
        },
        decoration: const InputDecoration(
            border: outlineInputBorder,
            // labelStyle: formTextStyle(context),
            // hintStyle: formTextStyle(context),
            labelText: '姓名',
            hintText: '姓名'),
      ),
    );
    var telWidget = Padding(
      padding: leftRightTop,
      child: TextFormField(
        controller: tecPhone,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return '电话为空';
          }
          return null;
        },
        decoration: const InputDecoration(
            border: outlineInputBorder,
            labelText: '电话',
            // labelStyle: formTextStyle(context),
            // hintStyle: formTextStyle(context),
            hintText: '电话'),
      ),
    );

    var addressWidget = Padding(
      padding: EdgeInsets.only(
          left: defaultPadding / 2,
          right: defaultPadding / 2,
          top: defaultPadding / 8),
      child: TextFormField(
        controller: tecAddress,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return '地址为空';
          }
          return null;
        },
        decoration: const InputDecoration(
            border: outlineInputBorder,
            // hintStyle: formTextStyle(context),
            labelText: '地址',
            // labelStyle: formTextStyle(context),
            hintText: '地址'),
      ),
    );
    var brandWidget = Padding(
      padding: EdgeInsets.only(
          left: defaultPadding / 2,
          right: defaultPadding / 2,
          top: defaultPadding),
      child: TextFormField(
        controller: tecBrand,
        validator: (value) {
          return value!.trim().isNotEmpty ? null : "品牌未填写";
        },
        decoration: const InputDecoration(
            border: outlineInputBorder,
            // labelStyle: formTextStyle(context),
            // hintStyle: formTextStyle(context),
            labelText: '品牌',
            hintText: '品牌'),
      ),
    );
    var versionWidget = Padding(
      padding: EdgeInsets.only(
          left: defaultPadding / 2,
          right: defaultPadding / 2,
          top: defaultPadding),
      child: TextFormField(
        controller: tecVersion,
        validator: (value) {
          return value!.trim().isNotEmpty ? null : "版本不能为空";
        },
        decoration: const InputDecoration(
            border: outlineInputBorder,
            // labelStyle: formTextStyle(context),
            // hintStyle: formTextStyle(context),
            labelText: '版本',
            hintText: '版本'),
      ),
    );

    var remark1Widget = Padding(
      padding: paddingAll,
      child: TextFormField(
        controller: tecRemark1,
        decoration: const InputDecoration(
            border: outlineInputBorder,
            // hintStyle: formTextStyle(context),
            labelText: '备注1',
            // labelStyle: formTextStyle(context),
            hintText: '备注1'),
      ),
    );
    var remark2Widget = Padding(
      padding: paddingAll,
      child: TextFormField(
        controller: tecRemark2,
        decoration: const InputDecoration(
            border: outlineInputBorder,
            // hintStyle: formTextStyle(context),
            labelText: '备注2',
            // labelStyle: formTextStyle(context),
            hintText: '备注2'),
      ),
    );

    //事件类型
    var checkboxListTile = CheckboxListTile(
        title: const Text("是否已转正"),
        value: widget.purchased,
        onChanged: (bool? value) {
          setState(() {
            widget.purchased = value!;
          });
        });
    var startTimeWidget = Padding(
      padding: paddingAll,
      child: TextFormField(
        readOnly: true,
        controller: tecUseTime,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return '起始日期为空';
          }
          return null;
        },
        decoration: InputDecoration(
            suffixIcon: TextButton.icon(
              label: const Text("选择日期"),
              icon: Icon(Icons.timer),
              onPressed: () {
                _showDatePicker(true);
              },
            ),
            border: outlineInputBorder,
            labelText: '起始日期',
            // labelStyle: formTextStyle(context),
            // hintStyle: formTextStyle(context),
            hintText: '点小闹钟选起始日期'),
      ),
    );
    var endTimeWidget = Padding(
      padding: paddingAll,
      child: TextFormField(
        readOnly: true,
        controller: tecEndTime,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return '试用期为空';
          }
          return null;
        },
        decoration: InputDecoration(
            suffixIcon: TextButton.icon(
              label: const Text("选择日期"),
              icon: const Icon(Icons.timer),
              onPressed: () {
                _showDatePicker(false);
              },
            ),
            border: outlineInputBorder,
            labelText: '结束日期',
            // labelStyle: formTextStyle(context),
            // hintStyle: formTextStyle(context),
            hintText: '点小闹钟选结束日期'),
      ),
    );
    return AlertDialog(
      title: const Text('完善客户信息'),
      content: Container(
        width: 600,
        child: Form(
          key: widget._formKey,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Row(
                  children: [
                    SizedBox(
                      height: 80,
                      width: 200,
                      child: nameWidget,
                    ),
                    SizedBox(
                      height: 80,
                      width: 400,
                      child: telWidget,
                    )
                  ],
                ),
                addressWidget,
                Row(
                  children: [
                    SizedBox(
                      height: 80,
                      width: 300,
                      child: brandWidget,
                    ),
                    SizedBox(
                      height: 80,
                      width: 300,
                      child: versionWidget,
                    )
                  ],
                ),
                remark1Widget,
                remark2Widget,
                checkboxListTile,
                if (!widget.purchased)
                  Row(
                    children: [
                      SizedBox(
                        height: 80,
                        width: 300,
                        child: startTimeWidget,
                      ),
                      SizedBox(
                        height: 80,
                        width: 300,
                        child: endTimeWidget,
                      )
                    ],
                  ),
              ],
            ),
          ),
        ),
      ),
      actions: <Widget>[
        TextButton(
          style: TextButton.styleFrom(
            padding: EdgeInsets.symmetric(
              horizontal: defaultPadding * 1.5,
              vertical: defaultPadding / (Responsive.isMobile(context) ? 2 : 1),
            ),
          ),
          child: const Text('取消'),
          onPressed: () {
            Navigator.of(context).pop(false);
          },
        ),
        ElevatedButton(
          style: TextButton.styleFrom(
            padding: EdgeInsets.symmetric(
              horizontal: defaultPadding * 1.5,
              vertical: defaultPadding / (Responsive.isMobile(context) ? 2 : 1),
            ),
          ),
          onPressed: () async {
            if (!widget.isCreate) {
              bool isOK = await updateDevice();
              developer.log(isOK.toString());
            } else {
              bool isOK = await addCustomer();
              developer.log(isOK.toString());
            }
          },
          child: const Text("保存"),
        )
      ],
    );
  }
}
