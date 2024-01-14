import 'dart:developer';

import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ptf/models/customer_page_entity.dart';
import 'package:ptf/models/response.dart';
import 'package:ptf/net/http.dart';

import '../../main.dart';
import '../../models/customer_entity.dart';
import '../../utils/http.dart';
import '../../wiidget/mytoast.dart';
import 'edit_dialog.dart';

class CustomerPage extends StatefulWidget {
  GlobalKey<PaginatedDataTable2State> pageKey;

  bool childUpdate; //父控件根据该值改变子控件状态

  CustomerPage({super.key, required this.pageKey, required this.childUpdate});

  //final _key = GlobalKey<PaginatedDataTable2State>();
  final List<String> brandItems = List.empty(growable: true);
  final String brandSelected = "品牌";

  @override
  State<StatefulWidget> createState() => _PaginatedPageState();
}

class _PaginatedPageState extends State<CustomerPage> {
  int _rowsPerPage = 10;
  int _currentIndex = 0;
  String _brand ="ALL";
  CustomerPageData _pageEntity = CustomerPageData();

  //下一页
  getCustomers({int rowIndex = 0}) async {
    var requestBody = {
      'brand': _brand,
      'pageNo': rowIndex,
      'limit': _rowsPerPage,
    };
    var response = await HttpManager.getCustomers(requestBody);
    var respBody = BasicResponse.fromJson(response);
    if (respBody.code == HttpManager.StatusSuccess) {
      setState(() {
        _pageEntity = CustomerPageData.fromJson(respBody.data);
      });
    }
  }

  _pageChanged(int rowIndex) {
    _currentIndex = rowIndex;
    debugPrint("_pageChanged :$rowIndex");
    getCustomers();
  }

  @override
  void initState() {
    getCustomers();
    //logger.d("customer initState");
    // widget.brandItems.add("海信");
    // widget.brandItems.add("海石");
    super.initState();
  }

  @override
  void dispose() {
    //_sourceData.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isDark = false;
    //logger.d("customer_page initState");
    if (widget.childUpdate) {
      getCustomers();
      widget.childUpdate = false;
    }
    _resetFilter() {
      FToast()
          .init(context)
          .showToast(child: const MyToast(tip: "已重置过滤条件", ok: true));
    }

    SourceData sourceData = SourceData(context, _pageEntity, getCustomers);
    var searchAnchor = SearchAnchor(
        builder: (BuildContext context, SearchController controller) {
      return SearchBar(
        controller: controller,
        padding: const MaterialStatePropertyAll<EdgeInsets>(
            EdgeInsets.symmetric(horizontal: 16.0)),
        onTap: () {
          controller.openView();
        },
        onChanged: (_) {
          controller.openView();
        },
        leading: const Icon(Icons.search),
        trailing: <Widget>[
          Tooltip(
            message: 'Change brightness mode',
            child: IconButton(
              isSelected: isDark,
              onPressed: () {
                setState(() {
                  isDark = !isDark;
                });
              },
              icon: const Icon(Icons.wb_sunny_outlined),
              selectedIcon: const Icon(Icons.brightness_2_outlined),
            ),
          )
        ],
      );
    }, suggestionsBuilder: (BuildContext context, SearchController controller) {
      return List<ListTile>.generate(5, (int index) {
        final String item = 'item $index';
        return ListTile(
          title: Text(item),
          onTap: () {
            setState(() {
              controller.closeView(item);
            });
          },
        );
      });
    });
    var titleActions = [
      searchAnchor,
      TextButton.icon(
        icon: Icon(Icons.refresh),
        label: Text("重置过滤条件"),
        onPressed: () {
          _resetFilter();
        },
      ),

      TextButton.icon(
        icon: Icon(Icons.notifications),
        label: Text("消息（${3}）"),
        onPressed: () {
          // Navigator.of(context);
        },
      ),
    ];

    Widget brandDropdownMenu() {
      if (widget.brandItems.isEmpty) {
        return TextButton(
          child: Text("品牌"),
          onPressed: () async {
            FToast()
                .init(context)
                .showToast(child: const MyToast(tip: "没有更多品牌", ok: false));
          },
        );
      }
      return DropdownButton<String>(
        value: widget.brandSelected,
        icon: const Icon(
          Icons.arrow_drop_down,
          color: Colors.blue,
        ),
        //elevation: 16,
        style: const TextStyle(color: Colors.blue),
        underline: Container(
          height: 0,
          color: Colors.white12,
        ),
        onChanged: (String? value) {
          setState(() {
            // widget.brandSelected = "$value";
          });
        },
        items: widget.brandItems.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      );
    }

    var titles = [
      DataColumn2(label: Text("序号"), fixedWidth: 50),
      DataColumn2(label: Text("项目")),
      DataColumn2(label: brandDropdownMenu()),
      DataColumn2(label: Text("版本"), fixedWidth: 100),
      DataColumn2(label: Text("注册数量"), fixedWidth: 80),
      // DataColumn2(label: Text("POS")),
      // DataColumn2(label: Text("后台")),
      // DataColumn2(label: Text("自助")),
      // DataColumn2(label: Text("其他")),
      DataColumn2(
          label: Text("到期时间"),
          onSort: (columnIndex, ascending) {},
          fixedWidth: 100),
      DataColumn2(label: Text('业务员'), fixedWidth: 100),
      DataColumn2(label: Text('技术员'), fixedWidth: 100),
      DataColumn2(label: Text('备注')),
      DataColumn2(label: Text('备用1')),
      DataColumn2(label: Text('备用2')),
      DataColumn2(label: Text('操作')),
    ];
    var paginatedDataTable = PaginatedDataTable2(
      key: widget.pageKey,
      source: sourceData,
      header: Text('项目周期管理'),
      actions: titleActions,
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
      sortColumnIndex: 1,
      sortAscending: true,
      columns: titles,
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
  SourceData(this.context, this.pageEntity, this.refresh);

  final int _selectCount = 0; //当前选中的行数

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => pageEntity.count; //总行数

  @override
  int get selectedRowCount => _selectCount; //选中的行数

  //数据排序
  void sortData<T>(
      Comparable<T> Function(Map<String, dynamic> map) getField, bool b) {
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
    var useTime;
    if (item.purchased == 0) {
      useTime = DateTime.fromMillisecondsSinceEpoch(item.endTime);
      useTime = "${useTime.year}-${useTime.month}-${useTime.day}";
    } else {
      useTime = "已转正";
    }

    //logger.d("UseTime=${item.endTime}");
    return DataRow(cells: [
      DataCell(Text("${item?.id}"), placeholder: true),
      // DataCell(Text("${item?.name}\n${item?.brand}\n${item?.version}"), placeholder: true),
      DataCell(Text("${item?.name}"), placeholder: true),
      DataCell(Text("${item?.brand}"), placeholder: true),
      DataCell(Text("${item?.version}"), placeholder: true),
      DataCell(Text("共${item.pos + item.server + item.posDroid + item.other}"),
          placeholder: true),

      // DataCell(Text("${item?.pos}"), placeholder: true),
      // DataCell(Text("${item?.server}"), placeholder: true),
      // DataCell(Text("${item?.posDroid}"), placeholder: true),
      // DataCell(Text("${item?.other}"), placeholder: true),
      DataCell(Text(useTime), placeholder: true),
      DataCell(Text("${item?.salesman}"), placeholder: true),
      DataCell(Text("${item?.technician}"), placeholder: true),
      DataCell(Text("${item?.remark}"), placeholder: true),
      DataCell(Text("${item?.customize1}"), placeholder: true),
      DataCell(Text("${item?.customize2}"), placeholder: true),
      DataCell(
          Row(
            children: [
              IconButton(
                  onPressed: () {
                    updateCustomerDialog(context, item!, false)
                        .then((value) => {updateRefresh()});
                  },
                  icon: const Icon(Icons.edit)),
              IconButton(
                  onPressed: () {
                    deleteCustomer("${item?.id}");
                  },
                  icon: const Icon(Icons.delete)),
            ],
          ),
          placeholder: true)
    ]);
  }

  void updateRefresh() async {
    await refresh();
  }

  void deleteCustomer(String id) async {
    var response = await HttpUtils.get("/v1/deleteCustomer?id=$id", null);
    refresh();
  }

  Future<bool?> updateCustomerDialog(
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
