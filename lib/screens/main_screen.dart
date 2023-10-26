import 'dart:ffi';
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
  List<Customer> customers =List.empty(growable: true);
  onRefresh() {

  }

  @override
  Widget build(BuildContext context) {

    var tabTitles = DataTable2(
              columnSpacing: defaultPadding,
              columns: const [
                DataColumn(
                  label: Text("姓名"),
                ),
                DataColumn(
                  label: Text("电话"),
                ),
                DataColumn(
                  label: Text("地址"),
                ),
                DataColumn(
                  label: Text("到期时间"),
                ),
                DataColumn(
                  label: Text("操作"),
                ),
              ],
              rows: List.generate(
               customers.length,
                    (index) => devicesDataRow(customers[index]),
              ),
            );
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child:
            SizedBox(
            height: window.physicalSize.height*1,
                width: double.infinity,
                child:CustomerPage()),
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
  DataRow devicesDataRow(Customer customer) {
    return DataRow(
      cells: [
        DataCell(Text("${customer.name}"), placeholder: true),
        DataCell(Text("${customer.phone}"), placeholder: true),
        DataCell(Text("${customer.address}"), placeholder: true),
        DataCell(Text("${customer.endTime}"), placeholder: true),
        DataCell(IconButton(onPressed: (){
          customerDialog(context,customer,false);
        }, icon: const Icon(Icons.edit)), placeholder: true),
      ],
    );
  }

}