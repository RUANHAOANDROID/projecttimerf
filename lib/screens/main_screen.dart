import 'dart:ui';

import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:ptf/screens/customer_page.dart';

import '../constants.dart';
import '../models/customer_entity.dart';
import 'edit_dialog.dart';
import 'dart:developer';

class MainScreen extends StatefulWidget {
  bool childUpdate= false;//通过该值改变子控件状态
  MainScreen({super.key, required this.title});
  final String title;
  @override
  State<MainScreen> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MainScreen> {
  final _key = GlobalKey<PaginatedDataTable2State>();
  onRefresh() {
    setState(() {
      log("on refresh");
      _key.currentState?.pageTo(0);
      widget.childUpdate=true;
    });
  }
  @override
  Widget build(BuildContext context) {
    log("main_screen on build");
    var customerPage = CustomerPage(pageKey: _key,childUpdate: widget.childUpdate);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: SizedBox(
            height: window.physicalSize.height * 1,
            width: double.infinity,
            child: customerPage),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          addCustomerDialog(context, Customer(), true)
              .then((value) => onRefresh());
        },
        tooltip: '添加一个',
        child: const Padding(
          padding: defaultPaddingAll,
          child: Icon(Icons.add),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Future<bool?> addCustomerDialog(
      BuildContext context, Customer customer, bool isCreate) {
    return showDialog<bool>(
      context: context,
      //barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return EditDialog(
          customer: customer,
          isCreate: isCreate,
        );
      },
    );
  }
}
