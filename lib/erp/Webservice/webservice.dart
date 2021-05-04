import 'dart:async';
import 'dart:convert';

import 'package:authentication_with_bloc/erp/DataModels/HiveModels/InventoryItems/InvetoryItemDataModel.dart';
import 'package:authentication_with_bloc/erp/DataModels/HiveModels/TransactionItem/TransactionitemHelperModel.dart';
import 'package:intl/intl.dart';

import 'package:dio/dio.dart';
import 'package:authentication_with_bloc/erp/DataModels/Search/ItemSearchModel.dart';
import 'package:authentication_with_bloc/erp/DataModels/Transactions/GeneralVoucherDataModel.dart';
import 'package:authentication_with_bloc/erp/Database/DatabaseHelper.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;

class WebServiceHelper {
  //  String ipAddress = "192.168.1.40";

  //  String ipAddress = "192.168.1.13";

  static final WebServiceHelper _instance = new WebServiceHelper.internal('');
  factory WebServiceHelper() => _instance;
  // static WebServiceHelper _webservice;
  WebServiceHelper.internal(this.ip);

  String link = "http://31.220.109.198/test_app/ReportsWS1.php?action=";

  final String ip;
  WebServiceHelper.withURL({this.ip});
  //static String ip = "http://31.220.109.198/test_app";

  Map<String, String> actionList;

  Future<http.Response> webio(String url,
      [Map argsList, dynamic bodyMap]) async {
    if (bodyMap == null) bodyMap = {};
    if (argsList == null) argsList = {};
    String args = '';
    argsList.forEach((key, value) {
      args = '$args&$key=$value';
    });
    url = url + args;
    print('Url : $url');
    var body = json.encode(bodyMap);
    var response;
    response = await http.post(url,
        headers: {"Content-type": "application/json"},
        body: body,
        encoding: Encoding.getByName("utf-8"));
    return response;
  }

  Future<dynamic> getWebresponse(String url,
      [Map argsList, dynamic bodyMap]) async {
    var response = await webio(url, argsList, bodyMap);
    Map decoded = jsonDecode(response.body);
    return decoded['Result'];
  }

  Future<Map> getJSON(String report, String d1, String d2) async {
    d1 = d1.split(' ')[0];
    d2 = d2.split(' ')[0];
    print('start : $d1');
    String Date = "&from_Date=$d1&to_Date=$d2";
    String fullURl = '${link}${report}${Date}';
    print('Url : $fullURl');

    http.Response response = await http.get(
      Uri.encodeFull(fullURl),
      headers: {"Accept": "application/json"},
    );

    Map decoded = json.decode(response.body);
    List<dynamic> jsonStrings = decoded['Sales'];

    print(response.body);
    print('Decoded[Sales]');
    print(decoded['Sales']);
    return decoded;
  }

  Future<Map> getTestjson() async {
    String link =
        "http://3.19.206.7/trans/sales_voucher_webservice.php?action=getvoucherbyvoucherno&voucher_no=96&voucher_prefix=A";
    String fullURl = '$link';
    print('Url : $fullURl');

    http.Response response = await http.get(
      Uri.encodeFull(fullURl),
      headers: {"Accept": "application/json"},
    );

    print(response.body);

    Map decoded = json.decode(response.body);
    GeneralVoucherDataModel data1 =
        new GeneralVoucherDataModel.fromMapOLD(decoded);

    print("voucher : ");
    print(data1.voucherNumber);

    return decoded;
  }

  Future<void> getAllCreatejson() async {
    String link =
        "http://3.19.206.7/webservicegrill.php?action=show_create_all_tables";
    String fullURl = '$link';
    print('Url : $fullURl');

    http.Response response = await http.get(
      Uri.encodeFull(fullURl),
      headers: {"Accept": "application/json"},
    );

    // print(response.body);

    List<dynamic> list = json.decode(response.body);

    int i = 0;
    // DatabaseHelper.get().startTransaction();
    list.forEach((element) {
      print('$i :  ${element['Query']}');
      i++;
      String str = element['Query'];
      String tablename = element['TableName'];
      // if (tablename.endsWith('time_details'))
      DatabaseHelper.get().runTableCreateQuerywithDrop(str, tablename);
    });
    // DatabaseHelper.get().commitTransaction();
    //  DatabaseHelper.get().printTables();
  }

  Future<void> getAllTablesJson() async {
    String link = "http://3.19.206.7/webservicegrill.php?action=show_tables";
    String fullURl = '$link';
    print('Url : $fullURl');

    http.Response response = await http.get(
      Uri.encodeFull(fullURl),
      headers: {"Accept": "application/json"},
    );

    // print(response.body);

    Map decoded = json.decode(response.body);

    List list = decoded['item'];
    // print("List : $list");

    print("Called");

    DatabaseHelper.get().startTransaction();

    print("#################");

    list.forEach((element) {
      String tablname = element['Tables_in_test_branch'];
      if (tablname.endsWith('sales_inventory_items')) getDataDump(tablname);
    });

    for (int i = 0; i < list.length; i++) {
      await doDump(list[i]);
    }

    await DatabaseHelper.get().commitTransaction();

    print('Completed Dump');
  }

  Future<void> doDump(dynamic element) async {
    String tablname = element['Tables_in_test_branch'];
    if (tablname.endsWith('sales_inventory_items')) await getDataDump(tablname);
  }

  Future<bool> getDataDump(String tablename) async {
    String link =
        "http://3.19.206.7/webservicegrill.php?action=select_table&tablename=$tablename";
    String fullURl = '$link';
    // print('Url : $fullURl');

    http.Response response = await http.get(
      Uri.encodeFull(fullURl),
      headers: {"Accept": "application/json"},
    );

    Map decoded = json.decode(response.body);
    List list = decoded['item'];
    List<Map> mapList = new List<Map>();

    if (decoded['success'] == 1) {
      print("Dumping Table : $tablename");
      list.forEach((element) {
        String record = json.encode(element);
        Map map = json.decode(record);
        // print("ID : ${map['_id']}");
        mapList.add(map);

        // print (record);
      });
      await DatabaseHelper.get().insertRecordsTest(mapList, tablename);
    }

    return true;
  }

  Future<bool> sendVoucher(GeneralVoucherDataModel voucher, String link) async {
    String url = "${ip}$link";

    print("url : $url");
    print('BODY : ${voucher.toJson()}');
    http.Response response;
    try {
      response = await http.post(url, body: voucher.toJson());
    } catch (e) {
      print(e.toString());
      return false;
    }
    print(response.body);
    return true;
  }

  Future<GeneralVoucherDataModel> getVoucher(
      {String voucherID, String voucherPrefix, String link}) async {
    Dio dio = Dio();
    String url = "$ip/$link";
    url = '$url&voucher_no=$voucherID&voucher_prefix=$voucherPrefix';
    print("url : $url");

    GeneralVoucherDataModel voucher;
    try {
      Response response = await dio.get(url);

      Map data = response.data['data'];
      voucher = GeneralVoucherDataModel.fromMapForTransTest(data);
    } catch (e) {
      print(e.toString());
      return GeneralVoucherDataModel();
    }
    print('V no : ${voucher.voucherNumber}');
    print('itemCount = ${voucher.InventoryItems.length}');
    print('First item : ${voucher.InventoryItems[0].BaseItem.itemID}');
    return voucher;
  }

  Future<List> getVoucherList(
      {DateTime dateFrom,
      DateTime dateTo,
      int offset,
      int limit = 50,
      String link}) async {
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    String dateF = formatter.format(dateFrom);
    String dateT = formatter.format(dateTo);

    String url = "$ip/$link&fromdate=$dateF&todate=$dateT&limit=1000&offset=0";
    print("url : $url");

    Dio dio = Dio();
    List data = [];
    Response response;
    try {
      response = await dio.get(url);
      print(response.data);
      data = response.data['data'];
    } catch (e) {
      print(e.toString());
      return [];
    }

    print('Data : $data');
    return data;
  }

  Future<bool> loadAllItems(final Box hive) async {
    print('Loading All Items...');
    String url =
        "$ip/inventory_webservice.php?action=getAllItems&offset=0&limit=1000";

    print(url);
    // Dio dio = Dio();
    Dio dio = Dio();
    // var hive;
    // print('Checking Hive');
    // if (await Hive.boxExists('items')) Hive.close();

    // hive = Hive.box('items');
    try {
      Response response = await dio.get(url);
      List items = response.data['data'];
      items.forEach((e) {
        // print('Item : ${e['Item_ID']}');
        hive.put(e['Item_ID'], ItemSearchModel.fromMap(e));
      });
    } catch (e) {
      print('Error : ${e.toString()}');
      return false;
    }

    // for (int i = 0; i < hive.length; i++) {
    //   print('Item [$i]: ${((hive.getAt(i)) as ItemSearchModel).itemName}');
    // }

    return true;
  }

  Future<void> syncClosingStock(final Box hive) async {
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    String dateF = formatter.format(DateTime.now());
    String dateT = formatter.format(DateTime.now());
    String url = "$ip/$link&fromDate=$dateF&toDate=$dateT&limit=1000&offset=0";
    print("url : $url");

    Dio dio = Dio();
    List data = [];
    Response response;
    try {
      response = await dio.get(url);
      print(response.data);
      data = response.data['data'];
    } catch (e) {
      print(e.toString());
      return;
    }

    for (int i = 0; i < data.length; i++) {
      dynamic item = hive.get(data[i]['Id']);
      item[''] = '';

      print(item);
    }
  }

  Future<List> getReportList(
      {String link,
      DateTime dateFrom,
      DateTime dateTo,
      int offset,
      int limit = 50}) async {
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    String dateF = formatter.format(dateFrom);
    String dateT = formatter.format(dateTo);

    String url = "$ip/$link&fromDate=$dateF&toDate=$dateT&limit=1000&offset=0";
    print("url : $url");

    Dio dio = Dio();
    List data = [];
    Response response;
    try {
      response = await dio.get(url);
      print(response.data);
      data = response.data['data'];
    } catch (e) {
      print(e.toString());
      return [];
    }

    print('Data : $data');
    return data;
  }

  Future<dynamic> getAllGroups() async {
    String invLink = "$ip/inventory_webservice.php?action=";
    String fullURl = '${invLink}getAllGroups';
    print('Url : $fullURl');

    dynamic data;
    try {
      http.Client cli;

      // await cli.get(fullURl);
      final http.Response response = await http.get(
        Uri.encodeFull(fullURl),
        headers: {"Accept": "application/json"},
      ).timeout(const Duration(
        seconds: 5,
      ));
      data = json.decode(response.body);
    } catch (ex) {
      print(ex);
      return ex.toString() + fullURl + ' is the link';
    }

    return data['data'];
  }

  Future<dynamic> getItemsUnderGroup(
      {String groupID, int start = 0, int offset = 0}) async {
    String invLink = "$ip/inventory_webservice.php?action=";
    String fullURl = '${invLink}getItemByGroup&group_id=$groupID';
    print('Url : $fullURl');

    dynamic data;
    try {
      // http.Client cli;
      // await cli.get(fullURl);
      final http.Response response = await http.get(
        Uri.encodeFull(fullURl),
        headers: {"Accept": "application/json"},
      );
      data = json.decode(response.body);
    } catch (ex) {
      return false;
    }

    return data['data'];
  }

  Future<Map> getDashboardData() async {
    String fullURl = '${ip}/reports_webservice.php?action=get_shift_details';
    print('Url : $fullURl');

    Map data;
    try {
      // http.Client cli;
      // await cli.get(fullURl);
      final http.Response response = await http.get(
        Uri.encodeFull(fullURl),
        headers: {"Accept": "application/json"},
      );

      data = json.decode(response.body);
    } catch (ex) {}

    return data['data'];
  }

  Future<void> downloadTransItems() async {
    Dio dio = Dio();
    String qry;
    qry = 'SELECT * FROM TRANSACTION_ITEM_HELPER ';
    String fullURl = '${ip}/ReportsWS1.php?action=runQuery&query=$qry';
    print('Url : $fullURl');
    Map data;

    var hive = await Hive.openBox<TransactionItemModel>("transitems");
    try {
      // http.Client cli;
      // await cli.get(fullURl);
      print('In try');
      Response response = await dio.get(fullURl);
      print('fetch begin');
      dynamic rr = jsonDecode(response.data);

      List items = rr['data'];

      // print(items);
      print('Items Length = ${items.length}');
      items.forEach((e) {
        print('Item : ${e['_id']}');
        TransactionItemModel item = TransactionItemModel.fromMap(e);
        print(item.fromLedger);
        int x = hive.length;
        hive.put('${e['_id']}_$x', TransactionItemModel.fromMap(e));
      });

      // print(data['data']);
    } catch (ex) {
      print('Exception ${ex.toString()}');
    }
  }

  Future<void> downloadInvItems() async {
    Dio dio = Dio();
    String qry;
    qry = 'SELECT * FROM SALES_INVENTORY_ITEMS ';
    String fullURl = '${ip}/ReportsWS1.php?action=runQuery&query=$qry';
    print('Url : $fullURl');
    Map data;

    var hive = await Hive.openBox<InventoryItemHive>("InvItems");
    try {
      // http.Client cli;
      // await cli.get(fullURl);
      print('In try');
      Response response = await dio.get(fullURl);
      print('fetch begin');
      dynamic rr = jsonDecode(response.data);

      List items = rr['data'];

      // print(items);
      print('Items Length = ${items.length}');
      items.forEach((e) {
        print('Item : ${e['Item_Name']}');
        print("type ${e['Item_Name'].runtimeType}");
        InventoryItemHive item = InventoryItemHive.fromMap(e);
        print(item.Item_Name);
        int x = hive.length;
        hive.put('{${e['Item_ID']} : ${e['Item_Name']}}',
            InventoryItemHive.fromMap(e));
      });

      var map = items[0];

      print('Item_ID is ${map['Item_ID'].runtimeType}');
      print('Item_Name is ${map['Item_Name'].runtimeType}');
      print('Item_Alias is ${map['Item_Alias'].runtimeType}');
      print('Item_Code is ${map['Item_Code'].runtimeType}');
      print('Group_Id is ${map['Group_Id'].runtimeType}');
      print('Part_Number is ${map['Part_Number'].runtimeType}');
      print('Price is ${map['Price'].runtimeType}');
      print('Opening_Stock is ${map['Opening_Stock'].runtimeType}');
      print('Opening_Balance is ${map['Opening_Balance'].runtimeType}');
      print(
          'Opening_Balance_Date is ${map['Opening_Balance_Date'].runtimeType}');
      print('Last_Modified_By is ${map['Last_Modified_By'].runtimeType}');
      print('Opening_Rate is ${map['Opening_Rate'].runtimeType}');
      print('Opening_Value is ${map['Opening_Value'].runtimeType}');
      print('Narration is ${map['Narration'].runtimeType}');
      print('Serial_Number is ${map['Serial_Number'].runtimeType}');
      print('Closing_Stock is ${map['Closing_Stock'].runtimeType}');
      print('Reorder_Level is ${map['Reorder_Level'].runtimeType}');
      print('Std_Cost is ${map['Std_Cost'].runtimeType}');
      print('Vat_Rate is ${map['Vat_Rate'].runtimeType}');
      print('Default_UOM_ID is ${map['Default_UOM_ID'].runtimeType}');
      print('Last_Modified is ${map['Last_Modified'].runtimeType}');
      print('Date_Created is ${map['Date_Created'].runtimeType}');
      print('Timestamp is ${map['Timestamp'].runtimeType}');
      print('Warranty_Days is ${map['Warranty_Days'].runtimeType}');
      print('Shelf_Life is ${map['Shelf_Life'].runtimeType}');
      print('Brand_Id is ${map['Brand_Id'].runtimeType}');
      print('Item_Description is ${map['Item_Description'].runtimeType}');
      print('isCustomItem is ${map['isCustomItem'].runtimeType}');
      print('Dimension is ${map['Dimension'].runtimeType}');
      print('isPurchaseItem is ${map['isPurchaseItem'].runtimeType}');
      print('isSalesItem is ${map['isSalesItem'].runtimeType}');
      print('KOT_Printer is ${map['KOT_Printer'].runtimeType}');
      print('Item_Name_Arabic is ${map['Item_Name_Arabic'].runtimeType}');
      print('Favourite is ${map['Favourite'].runtimeType}');
      print('IsStockItem is ${map['IsStockItem'].runtimeType}');
      print('From_Time is ${map['From_Time'].runtimeType}');
      print('To_Time is ${map['To_Time'].runtimeType}');
      print('Price_2 is ${map['Price_2'].runtimeType}');
      print('HSN_CODE is ${map['HSN_CODE'].runtimeType}');
      print('Section is ${map['Section'].runtimeType}');
      print('Flags is ${map['Flags'].runtimeType}');
      print('Category is ${map['Category'].runtimeType}');
      print('DefaultLedgerID is ${map['DefaultLedgerID'].runtimeType}');

      // print(data['data']);
    } catch (ex) {
      print('Exception ${ex.toString()}');
    }
  }
}
