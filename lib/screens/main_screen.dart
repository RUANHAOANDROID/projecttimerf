import 'dart:ui';

import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ptf/screens/customer_page.dart';

import '../constants.dart';
import '../models/customer_page_entity.dart';
import 'edit_dialog.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key, required this.title});
  final String title;

  @override
  State<MainScreen> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MainScreen> {
  final _key = GlobalKey<PaginatedDataTable2State>();
  onRefresh() {
    setState(() {
      _key.currentState?.pageTo(0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child:
            SizedBox(
            height: window.physicalSize.height*1,
                width: double.infinity,
                child:CustomerPage(pageKey: _key,)),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          customerDialog(context,Customer(),true).then((value) => onRefresh());
        },
        tooltip: '添加一个',
        child: const Padding(padding: defaultPaddingAll,child: Icon(Icons.add),),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Future<bool?> customerDialog(BuildContext context,Customer customer,bool isCreate) {
    return showDialog<bool>(
          context: context,
          //barrierDismissible: false, // user must tap button!
          builder: (BuildContext context) {
            return EditDialog(
              customer: customer,isCreate: isCreate,
            );
          },
        );
  }
}