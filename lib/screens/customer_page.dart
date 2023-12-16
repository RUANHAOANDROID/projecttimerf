import 'dart:developer';

import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:ptf/models/customer_page_entity.dart';
import 'package:ptf/net/http.dart';

import '../models/customer_entity.dart';
import '../utils/http.dart';

class CustomerPage extends StatefulWidget {
  GlobalKey<PaginatedDataTable2State> pageKey;
  bool childUpdate;
  CustomerPage({super.key, required this.pageKey,required this.childUpdate});
  //final _key = GlobalKey<PaginatedDataTable2State>();

  @override
  State<StatefulWidget> createState() => _PaginatedPageState();
}

class _PaginatedPageState extends State<CustomerPage> {
  
  int _rowsPerPage = 10;
  int _currentIndex = 0;
  CustomerPageData _pageEntity = CustomerPageData();

  //下一页
  _getCustomers({int rowIndex = 0}) async {
    var body = '{"offset":$rowIndex,"limit":$_rowsPerPage}';
    var response = await HttpManager.getCustomers(body);
    var code =response["code"];
    if (code==HttpManager.StatusSuccess){
      setState(() {
        _pageEntity = response["data"];
      });
    }

  }

  _pageChanged(int rowIndex) {
    _currentIndex = rowIndex;
    debugPrint("_pageChanged :$rowIndex");
    _getCustomers();
  }


  void _refresh() {
    if (_currentIndex == 0) {
      _getCustomers();
      return;
    }
    widget.pageKey.currentState?.pageTo(0);
  }

  @override
  void initState() {
    _getCustomers();
    log("initState");
    super.initState();
  }

  @override
  void dispose() {
    //_sourceData.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    log("initState");
    if(widget.childUpdate){
      _refresh();
      widget.childUpdate =false;
    }
    SourceData sourceData = SourceData(context,_pageEntity,_refresh);

    var paginatedDataTable = PaginatedDataTable2(
      key: widget.pageKey,
      source: sourceData,
      // header: Text('事件'),
      headingRowHeight: 50.0,
      dataRowHeight: 60.0,
      rowsPerPage: _rowsPerPage,
      onPageChanged: (rowIndex) {
        debugPrint("onPageChanged:$rowIndex");
        _pageChanged(rowIndex!);
      },
      availableRowsPerPage: const [10, 20, 50],
      onRowsPerPageChanged: (value) {
        debugPrint("onRowsPerPageChanged:$value");
        _rowsPerPage = value!;
      },
      sortAscending: true,
      columns: const [
        DataColumn2(
          label: Text("姓名"),
        ),
        DataColumn2(
            label: Text("电话")),
        DataColumn2(label: Text("地址")),
        DataColumn2(label: Text('到期时间')),
        DataColumn2(label: Text('操作')),
      ],
      empty: const Center(child: Text('暂无数据')),
      showFirstLastButtons: true,
      initialFirstRowIndex: 0,
      showCheckboxColumn: false,
      columnSpacing: 0,
      horizontalMargin: 20,
      //sortColumnIndex: 1,
      //onSelectAll: (state) => setState(() => _sourceData.selectAll(state!)),
    );
    return paginatedDataTable;
  }
}

class SourceData extends DataTableSource {
  final CustomerPageData pageEntity;
  final BuildContext context;
  final Function refresh; // 定义一个回调函数
  SourceData(this.context,this.pageEntity, this.refresh);

  final int _selectCount = 0; //当前选中的行数

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => pageEntity.count; //总行数

  @override
  int get selectedRowCount => _selectCount; //选中的行数

  //数据排序
  void sortData<T>(Comparable<T> Function(Map<String, dynamic> map) getField, bool b) {
    // _sourceData.sort((Map<String, dynamic> map1, Map<String, dynamic> map2) {
    //   if (!b) {
    //     //两个项进行交换
    //     final Map<String, dynamic> temp = map1;
    //     map1 = map2;
    //     map2 = temp;
    //   }
    //   final Comparable<T> s1Value = getField(map1);
    //   final Comparable<T> s2Value = getField(map2);
    //   return Comparable.compare(s1Value, s2Value);
    // });
    // notifyListeners();
  }

  void selectAll(bool checked) {
    // _sourceData.forEach((data) => data["selected"] = checked);
    // _selectCount = checked ? _sourceData.length : 0;
    // notifyListeners(); //通知监听器去刷新
  }

  @override
  DataRow? getRow(int index) {
    Customer? item;
    try {
      item = pageEntity.data?[index % 10];
    } catch (e) {
      print(e);
    }
    if (item == null) return null;
    var useTime = DateTime.fromMillisecondsSinceEpoch(item.endTime);
    return DataRow(cells: [
      DataCell(Text("${item?.name}"), placeholder: true),
      DataCell(Text("${item?.phone}"), placeholder: true),
      DataCell(Text("${item?.address}"), placeholder: true),
      DataCell(Text("${useTime.year}-${useTime.month}-${useTime.day}"), placeholder: true),
      DataCell(Row(children: [
        IconButton(onPressed: (){

        }, icon: const Icon(Icons.edit)),
        IconButton(onPressed: (){
        deleteCustomer("${item?.id}");
        }, icon: const Icon(Icons.delete)),
      ],), placeholder: true)
    ]);
  }
  void deleteCustomer(String id)async{
     var response =await HttpUtils.get("/v1/deleteCustomer?id=$id",null);
     refresh();
  }
}
