import 'dart:convert';

import 'package:flutter/material.dart';

import '../../../../constants.dart';
import '../../../../responsive.dart';
import '../../../../theme/theme.dart';
import '../../../../utils/http.dart';
import 'dart:developer' as developer;

import '../../models/customer_entity.dart';

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

  TextEditingController tecName = TextEditingController();//项目名称
  TextEditingController tecBrand = TextEditingController();//品牌
  TextEditingController tecVersion = TextEditingController();//版本

  TextEditingController tecPosCount = TextEditingController();//Pos数
  TextEditingController tecServerCount = TextEditingController();//服务数
  TextEditingController tecPosDroidCount = TextEditingController();//自助数
  TextEditingController tecOtherDroidCount = TextEditingController();//其他设备数

  TextEditingController tecUseTime = TextEditingController();//开始时间
  TextEditingController tecEndTime = TextEditingController();//结束时间

  TextEditingController tecSalesman = TextEditingController();//业务员
  TextEditingController tecTechnician = TextEditingController();//技术员

  TextEditingController tecC1 = TextEditingController();//自定义列1
  TextEditingController tecC2 = TextEditingController();//自定义列2

  TextEditingController tecRemark = TextEditingController();//备注
  void checkParameter() {
    var state = widget._formKey.currentState;
    if (state!.validate()) {
    } else {}
  }

  @override
  void initState() {
    if (!widget.isCreate) {
      tecName.text = widget.customer?.name as String;
      tecBrand.text = widget.customer?.brand as String;
      tecVersion.text = widget.customer?.version as String;
      tecPosCount.text =widget.customer.pos as String;
      tecServerCount.text =widget.customer.server as String;
      tecPosDroidCount.text =widget.customer.posDroid as String;
      tecOtherDroidCount.text =widget.customer.other as String;

      tecSalesman.text =widget.customer.salesman;
      tecTechnician.text =widget.customer.technician;

      tecC1.text =widget.customer.customize1;
      tecC2.text =widget.customer.customize2;

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
    widget.customer.brand = tecBrand.text;
    widget.customer.version = tecVersion.text;
    widget.customer.pos = int.parse(tecPosCount.text);
    widget.customer.server = int.parse(tecServerCount.text);
    widget.customer.posDroid = int.parse(tecPosDroidCount.text);
    widget.customer.other = int.parse(tecOtherDroidCount.text);
    widget.customer.salesman = tecSalesman.text;
    widget.customer.technician = tecTechnician.text;
    widget.customer.customize1 = tecC1.text;
    widget.customer.customize2 = tecC2.text;
    widget.customer.purchased = widget.purchased ? 1 : 0;

    developer.log("是否已经转正=${widget.purchased},${widget.customer.purchased}");
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
    tecBrand.dispose();
    tecVersion.dispose();
    tecPosCount.dispose();
    tecServerCount.dispose();
    tecPosDroidCount.dispose();
    tecOtherDroidCount.dispose();
    tecSalesman.dispose();
    tecTechnician.dispose();
    tecC1.dispose();
    tecC2.dispose();
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
          return value!.trim().isNotEmpty ? null : "项目名称";
        },
        decoration: const InputDecoration(
            border: outlineInputBorder,
            // labelStyle: formTextStyle(context),
            // hintStyle: formTextStyle(context),
            labelText: '项目名称',
            hintText: '项目名称'),
      ),
    );
    var posCountWidget = Padding(
      padding: leftRightTop,
      child: TextFormField(
        controller: tecPosCount,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Pos数量未填写';
          }
          return null;
        },
        decoration: const InputDecoration(
            border: outlineInputBorder,
            labelText: 'POS数量',
            // labelStyle: formTextStyle(context),
            // hintStyle: formTextStyle(context),
            hintText: 'POS数量'),
      ),
    );

    var posDroidCountWidget = Padding(
      padding: leftRightTop,
      child: TextFormField(
        controller: tecPosDroidCount,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return '自助机数量为空';
          }
          return null;
        },
        decoration: const InputDecoration(
            border: outlineInputBorder,
            // hintStyle: formTextStyle(context),
            labelText: '自助机数量',
            // labelStyle: formTextStyle(context),
            hintText: '自助机数量'),
      ),
    );
    var brandWidget = Padding(
      padding: const EdgeInsets.only(
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
      padding: const EdgeInsets.only(
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

    var c1Widget = Padding(
      padding: paddingAll,
      child: TextFormField(
        controller: tecC1,
        decoration: const InputDecoration(
            border: outlineInputBorder,
            // hintStyle: formTextStyle(context),
            labelText: '备注1',
            // labelStyle: formTextStyle(context),
            hintText: '备注1'),
      ),
    );
    var c2Widget = Padding(
      padding: paddingAll,
      child: TextFormField(
        controller: tecC2,
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
              label: const Text(""),
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
              label: const Text(""),
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
        width: 700,
        child: Form(
          key: widget._formKey,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Row(
                  children: [
                    SizedBox(
                      width: 200,
                      child: nameWidget,
                    ),
                    SizedBox(
                      width: 200,
                      child: brandWidget,
                    ),
                    SizedBox(
                      width: 200,
                      child: versionWidget,
                    )
                  ],
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 120,
                      child: brandWidget,
                    ),
                    SizedBox(
                      width: 120,
                      child: versionWidget,
                    )
                  ],
                ),
                c1Widget,
                c2Widget,
                Row(children: [
                  SizedBox(width: 200,child: checkboxListTile,),
                  if (!widget.purchased)
                    Row(
                      children: [
                        SizedBox(
                          width: 200,
                          child: startTimeWidget,
                        ),
                        SizedBox(
                          width: 200,
                          child: endTimeWidget,
                        )
                      ],
                    ),
                ],),

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
