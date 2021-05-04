import 'package:authentication_with_bloc/erp/Database/DatabaseHelper.dart';
import 'package:authentication_with_bloc/erp/Database/Finance/Masters/LedgerMasterDatabaseHelper.dart';
import 'package:authentication_with_bloc/erp/Database/Inventory/Masters/InventoryGroupsMasterDatabaseHelper.dart';
import 'package:authentication_with_bloc/erp/Database/Inventory/Masters/InventoryItemsDatabaseHelper.dart';
import 'package:authentication_with_bloc/erp/Database/UOM/UOMDatabaseHelper.dart';
import 'package:flutter/material.dart';
import 'package:json_table/json_table.dart';
import 'package:authentication_with_bloc/erp/Webservice/webservice.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';

class jsontableWidget extends StatefulWidget {
  @override
  _jsontableWidgetState createState() => _jsontableWidgetState();
}

class _jsontableWidgetState extends State<jsontableWidget> {
  String ReportName = 'Choose From List';

  bool loaded = false;

  WebServiceHelper _web;
  TextEditingController dfrom1;
  TextEditingController dfrom2;

  String _fromDateGlobal;
  String _toDateGlobal;

  var containerHeight = 0.0;

  Map reportList;

  var json;

  double _drawerWidth;

  @override
  void initState() {
    // TODO: implement initState

    _web = new WebServiceHelper();
    dfrom1 = new TextEditingController();
    dfrom2 = new TextEditingController();

    _fromDateGlobal = DateTime.now().toString().split(' ')[0];
    _toDateGlobal = DateTime.now().toString().split(' ')[0];

    print("Init : $_fromDateGlobal");

    dfrom1.text = _fromDateGlobal;
    dfrom2.text = _toDateGlobal;

    reportList = new Map();
    reportList['billwise'] = 'billwise_sales';
    reportList['itemwise'] = 'itemwise_sales';
    reportList['datewise'] = 'datewise_sales';
    reportList['groupwise'] = 'groupwise_sales';
    reportList['waiterwise'] = 'waiterwise_sales';
    reportList['servicewise'] = 'servicewise_sales';
    reportList['shiftwise'] = 'shiftwise_report';
    reportList['clstk'] = 'closing_stock';

    super.initState();
  }

  Widget getWidget() {
    print(json);

    return loaded && json != null
        ? JsonTable(
            json,
            tableHeaderBuilder: (String header) {
              return Container(
                padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                decoration: BoxDecoration(
                    border: Border.all(width: 0.5), color: Colors.grey[300]),
                child: Text(
                  header,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.display1.copyWith(
                      fontWeight: FontWeight.w700,
                      fontSize: 14.0,
                      color: Colors.white),
                ),
              );
            },
            tableCellBuilder: (value) {
              return Container(
                padding: EdgeInsets.symmetric(horizontal: 4.0, vertical: 2.0),
                decoration: BoxDecoration(
                    border: Border.all(
                        width: 0.5, color: Colors.grey.withOpacity(0.5))),
                child: Text(
                  value,
                  textAlign:
                      isNumeric(value) ? TextAlign.right : TextAlign.left,
                  style: Theme.of(context)
                      .textTheme
                      .display1
                      .copyWith(fontSize: 14.0, color: Colors.green[900]),
                ),
              );
            },
          )
        : getChart();
  }

  bool isNumeric(String s) {
    if (s == null) {
      return false;
    }
    return double.parse(s, (e) => null) != null;
  }

  Widget getChart() {
    return new Text("Loading");
  }

  void filterDate() {
    String df = dfrom1.text;
//    List<String> dstr = df.split("-");
//    df = '${dstr[2]}-${dstr[1]}-${dstr[0]}';
    var parsedDate = DateTime.parse(df);

    _fromDateGlobal = parsedDate.toString();

    df = dfrom2.text;
//    dstr = df.split("-");
//    df = '${dstr[2]}-${dstr[1]}-${dstr[0]}';
    parsedDate = DateTime.parse(df);
    print(parsedDate);
    _toDateGlobal = parsedDate.toString();
    setState(() {
      containerHeight = 0.0;
    });
  }

  Widget getDateWidget() {
    return new ListView(children: <Widget>[
      DateTimeField(
        controller: dfrom1,
        decoration: new InputDecoration(hintText: "From Date"),
        format: format,
        onShowPicker: (context, currentValue) {
          return showDatePicker(
              context: context,
              firstDate: DateTime(1900),
              initialDate: currentValue ?? DateTime.now(),
              lastDate: DateTime(2100));
        },
      ),
      DateTimeField(
        controller: dfrom2,
        decoration: new InputDecoration(hintText: "To Date"),
        format: format,
        onShowPicker: (context, currentValue) {
          return showDatePicker(
              context: context,
              firstDate: DateTime(1900),
              initialDate: currentValue ?? DateTime.now(),
              lastDate: DateTime(2100));
        },
      ),
      new FlatButton(
          onPressed: () {
            filterDate();
          },
          child: Text('Filter')),
    ]);
  }

  void filterDatePressed() {
    setState(() {
      containerHeight = 160.0;
    });
  }

  void refreshTable(String report) {
    String action = reportList[report];
    loaded = false;
    print('from date : $_fromDateGlobal');
    _web.getJSON(action, _fromDateGlobal, _toDateGlobal).then((value) {
      Navigator.pop(context);
      if (value != null)
        setState(() {
          loaded = true;
          json = value['Sales'];
        });
    });
  }

  final format = DateFormat("yyyy-MM-dd");

  void testDB() async {
    await InventoryGroupDBHelper().getAllGroups();
  }

  @override
  Widget build(BuildContext context) {
    _drawerWidth = MediaQuery.of(context).size.width * 0.65;

    // testDB();
    return Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.blueGrey,
        title: new Text('My Dashboard2'),
        actions: <Widget>[
          IconButton(
            icon: new Icon(Icons.check),
            onPressed: _web.getTestjson,
          ),
          IconButton(
            icon: new Icon(Icons.create_new_folder),
            onPressed: _web.getAllCreatejson,
          ),
          IconButton(
            icon: new Icon(Icons.get_app),
            onPressed: _web.getAllTablesJson,
          ),
          IconButton(
            icon: new Icon(Icons.print),
            onPressed: DatabaseHelper.get().printTables,
          ),
          IconButton(
            icon: new Icon(Icons.panorama_horizontal),
            onPressed: () {
              print('Button Pressed ');
              InventoryItemsDBHelper().getAllItems();
            },
          )
        ],
      ),
      body: Visibility(
          child: new SafeArea(
              child: new Column(
        children: <Widget>[
          new AnimatedContainer(
            duration: Duration(milliseconds: 100),
            child: getDateWidget(),
            height: containerHeight,
          ),
          Center(child: new Text(ReportName)),
          Flexible(
            child: getWidget(),
          )
        ],
      ))),
      drawer: new Drawer(
        elevation: 1.0,
        child: new SizedBox(
            width: _drawerWidth,
            child: new ListView(
              children: <Widget>[
                getDrawerHead(),
                new ListTile(
                    leading: Icon(Icons.insert_drive_file),
                    onTap: () {
                      refreshTable('itemwise');
                      ReportName = 'Itemwise Sales';
                    },
                    title: Text('Itemwise Sales')),
                new ListTile(
                    leading: Icon(Icons.insert_drive_file),
                    onTap: () {
                      refreshTable('billwise');
                      ReportName = 'Billwise Sales';
                    },
                    title: Text('Billwise Sales')),
                new ListTile(
                    leading: Icon(Icons.insert_drive_file),
                    onTap: () {
                      refreshTable('datewise');
                      ReportName = 'Datewise';
                    },
                    title: Text('Datewise')),
                new ListTile(
                    leading: Icon(Icons.insert_drive_file),
                    onTap: () {
                      refreshTable('groupwise');
                      ReportName = 'Groupwise Sales';
                    },
                    title: Text('Groupwise')),
                new ListTile(
                    leading: Icon(Icons.insert_drive_file),
                    onTap: () {
                      refreshTable('waiterwise');
                      ReportName = 'Waiter wise';
                    },
                    title: Text('Waiter wise')),
                new ListTile(
                    leading: Icon(Icons.insert_drive_file),
                    onTap: () {
                      refreshTable('servicewise');
                      ReportName = 'Service based';
                    },
                    title: Text('Service based')),
                new ListTile(
                    leading: Icon(Icons.insert_drive_file),
                    onTap: () {
                      refreshTable('shiftwise');
                      ReportName = 'Shift wise';
                    },
                    title: Text('Shift wise')),
                new ListTile(
                    leading: Icon(Icons.insert_drive_file),
                    onTap: () {
                      refreshTable('clstk');
                      ReportName = 'Closing Stock';
                    },
                    title: Text('Closing Stock')),
              ],
            )),
      ),
    );
  }

  Widget getDrawerHead() {
    DrawerHeader cont = new DrawerHeader(
        child: Center(child: new Text("Grillax Restaurant")),
        decoration: new BoxDecoration(
          color: Colors.green,
//        image: new DecorationImage(image : Image.asset('assets/images/lake.jpg'),
        )
//      ),
        );

    return cont;
  }
}
