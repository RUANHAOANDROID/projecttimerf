import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ptf/screens/Customer.dart';


import '../../../constants.dart';
import '../../../responsive.dart';
import '../../../theme/theme.dart';
import '../../../utils/IpInputFormatter.dart';
import '../../../utils/http.dart';
import 'dart:developer' as developer;
class EditDialog extends StatefulWidget {
  final Customer? customer;
  final _formKey = GlobalKey<FormState>();

  EditDialog({Key? key, this.customer}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _EditDialog();
}

class _EditDialog extends State<EditDialog> {
  Future<bool> addDevice() async {
    try {
      var state = widget._formKey.currentState;
      if (state!.validate()) {
        var body = Customer.empty();

        HttpUtils.post("/customer/add", body);
        setState(() {
          Navigator.of(context).pop(true);
        });
      }
      return true;
    } catch (e) {
      developer.log("_EditDialog",error: e);
      return false;
    }
  }

  Future<bool> updateDevice() async {
    try {
      var state = widget._formKey.currentState;
      if (state!.validate()) {
        var body = Customer.empty();

        var response = HttpUtils.post("/devices/update", body);
        setState(() {
          Navigator.of(context).pop(true);
        });
      }
      return true;
    } catch (e) {
      developer.log("updateDevice",error: e);
      return false;
    }
  }

  TextEditingController tecName = TextEditingController();
  TextEditingController tecPhone = TextEditingController();
  TextEditingController tecAddress = TextEditingController();
  TextEditingController tecEmail = TextEditingController();
  TextEditingController tecUseTime = TextEditingController();
  TextEditingController tecEndTime = TextEditingController();

  void checkParameter() {
    var state = widget._formKey.currentState;
    if (state!.validate()) {
    } else {}
  }

  @override
  void initState() {
    super.initState();
    if (widget.customer != null) {
      // numberC.text = widget.customer?.number as String;
      // ipC.text = widget.customer?.ip as String;
      // versionC.text = widget.customer?.version as String;
      // snC.text = widget.customer?.sn as String;
      // pointC.text = widget.customer?.tag as String;
    }
  }
  void _showDatePicker(bool isStart) async {
    await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2022),
        lastDate: DateTime(2025),
        locale: Locale("zh"))
        .then((value) {
      if (value != null) {
        if(isStart){
          widget.customer?.use_time=value.millisecondsSinceEpoch;
          tecUseTime.text="${value.year}-${value.month}-${value.day}";
        }else{
          widget.customer?.end_time=value.millisecondsSinceEpoch;
          tecEndTime.text="${value.year}-${value.month}-${value.day}";
        }
      }
    });
  }
  @override
  void dispose() {
    tecName.dispose();
    tecPhone.dispose();
    tecAddress.dispose();
    tecEmail.dispose();
    tecUseTime.dispose();
    tecEndTime.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const paddingAll = EdgeInsets.all(defaultPadding / 2);
    var singleChildScrollView = SingleChildScrollView(
      child: ListBody(
        children: <Widget>[
          Padding(
            padding: paddingAll,
            child: TextFormField(
              controller: tecName,
              validator: (value) {
                return value!.trim().isNotEmpty ? null : "姓名不能为空";
              },
              decoration: InputDecoration(
                  border: outlineInputBorder,
                  // labelStyle: formTextStyle(context),
                  // hintStyle: formTextStyle(context),
                  labelText: '姓名',
                  hintText: '姓名'),
            ),
          ),
          Padding(
            padding: paddingAll,
            child: TextFormField(
              controller: tecPhone,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return '电话为空';
                }
                return null;
              },
              decoration: InputDecoration(
                  border: outlineInputBorder,
                  labelText: '电话',
                  // labelStyle: formTextStyle(context),
                  // hintStyle: formTextStyle(context),
                  hintText: '电话'),
            ),
          ),
          Padding(
            padding: paddingAll,
            child: TextFormField(
              controller: tecAddress,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return '地址为空';
                }
                return null;
              },
              decoration: InputDecoration(
                  border: outlineInputBorder,
                  // hintStyle: formTextStyle(context),
                  labelText: '地址',
                  // labelStyle: formTextStyle(context),
                  hintText: '地址'),
            ),
          ),
          Padding(
            padding: paddingAll,
            child: TextFormField(
              controller: tecEmail,
              decoration: InputDecoration(
                  border: outlineInputBorder,
                  labelText: '邮箱',
                  // labelStyle: formTextStyle(context),
                  // hintStyle: formTextStyle(context),
                  hintText: '邮箱'),
            ),
          ),
          Padding(
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
                  suffixIcon: TextButton.icon(label: const Text("选择日期"),icon: Icon(Icons.timer),onPressed: (){
                    _showDatePicker(false);
                  },),

                  border: outlineInputBorder,
                  labelText: '起始日期',
                  // labelStyle: formTextStyle(context),
                  // hintStyle: formTextStyle(context),
                  hintText: '点小闹钟选起始日期'),
            ),
          ),
          Padding(
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
                  suffixIcon: TextButton.icon(label: const Text("选择日期"),icon: Icon(Icons.timer),onPressed: (){
                    _showDatePicker(false);
                  },),

                  border: outlineInputBorder,
                  labelText: '结束日期',
                  // labelStyle: formTextStyle(context),
                  // hintStyle: formTextStyle(context),
                  hintText: '点小闹钟选结束日期'),
            ),
          ),
        ],
      ),
    );
    return AlertDialog(
      title: const Text('完善客户信息'),
      content: Container(
        width: 450,
        child: Form(
          key: widget._formKey,
          child: singleChildScrollView,
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
            if (widget.customer?.id != null && widget.customer?.id!="") {
              bool isOK = await updateDevice();
              developer.log(isOK.toString());
            } else {
              bool isOK = await addDevice();
              developer.log(isOK.toString());
            }
          },
          child: const Text("保存"),
        )
      ],
    );
  }
}
