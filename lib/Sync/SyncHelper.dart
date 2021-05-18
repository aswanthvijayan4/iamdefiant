// import 'dart:async';
// import 'dart:convert';

// import 'package:authentication_with_bloc/erp/Database/DatabaseHelper.dart';
// import 'package:authentication_with_bloc/erp/webservice/webservice.dart';
// import 'package:http/http.dart' as http;
// import 'package:sqflite/sqlite_api.dart';

// // import 'package:authentication_with_bloc/erp/webservice/webservice.dart';

// class SyncHelper {
//   //  String ipAddress = "192.168.1.40";

//   //  String ipAddress = "192.168.1.13";
//   String baseUrl = "http://3.19.206.7/sync_server/radwa/server.php?action=";
//   String myID = "C";

//   WebServiceHelper _web;
//   SyncHelper() {
//     _web = WebServiceHelper.internal();
//   }

//   final String myIDtag = 'my_client_id';

//   void test() async {
//     String baseUrl = "http://3.19.206.7/sync_server/radwa/server.php?action=";
//     var url = baseUrl + 'get_server_data_of_client';
//     Map args = Map();
//     args['other_client_id'] = 'A';
//     dynamic last_time = '0000-00-00 00:00:00.000000';
//     var l = await WebServiceHelper().webio(url, args, last_time);
//     Map decoded = jsonDecode(l.body);
//     print('Respose: ${decoded['Result']}');
//   }

//   Future<Null> startSyncOperation() async {
//     // 1  Get  My last Time Stamp from Server
//     String lastSync = await getMyLastTimeStamp();

//     //2  Read Data from Log(DB)
//     List<Map> logData = await getLogData(lastSync);

//     print(logData);

//     //3 Store Obtained Data to DB
//     if (logData.length > 0)
//       await sendMyData(logData);
//     else
//       print('No Data To Send');

//     //4 Get Client List from Server
//     var list = await getOtherClientList();

//     //5 For each client id get Data from server and insert to Table;

//     for (int i = 0; i < list.length; i++) {
//       List data = await getRestOfDataOfClient(list[i]);
//       if (data.length > 0)
//         await insertToDataTables(data);
//       else
//         print('No Data from ${list[i]}');
//     }

//     return;
//     //6  Send Updated Timestamps to server
//     await sendAckTimeStamps();
//   }

//   Future<String> getMyLastTimeStamp() async {
//     // action :  'my_last_timestamp'

//     var url = baseUrl + 'my_last_timestamp';
//     Map args = Map();
//     args[myIDtag] = myID;
//     String timeStamp = await WebServiceHelper().getWebresponse(url, args);
//     return timeStamp;
//   }

//   Future<List<Map>> getLogData(String timeStamp) async {
//     String qStr =
//         "SELECT  * FROM log where `client_id` = ? AND `timeStamp` > '$timeStamp' order by `timestamp` Limit 10";
//     return DatabaseHelper.get().getqueryResult(qStr);
//   }

//   Future<void> sendMyData(List<Map> logData) async {}

//   Future<List<String>> getOtherClientList() async {
//     var url = baseUrl + 'get_clients';
//     Map args = Map();
//     args[myIDtag] = myID;
//     List mmap = await WebServiceHelper().getWebresponse(url, args);
//     List<String> clients = [];

//     mmap.forEach((element) {
//       clients.add(element['client_id']);
//     });
//     print('Clients : $clients');
//     return clients;
//   }

//   Future<List> getRestOfDataOfClient(String clientID) async {
//     var url = baseUrl + 'get_server_data_of_client';

//     Map args = Map();
//     args['other_client_id'] = clientID;
//     String lastTime = '0000-00-00 00:00:00.000000';
//     String qStr =
//         "SELECT $clientID from time_details where `client_id` = '$myID'";
//     List<Map> data = await DatabaseHelper.get().getqueryResult(qStr);

//     if (data.length > 0) lastTime = data[0][clientID];

//     var dataList = await WebServiceHelper().getWebresponse(url, args, lastTime);

//     return dataList;
//   }

//   Future<bool> insertToDataTables(List dataList) async {
//     // this function is run with all Data
//     print('dataList size : ${dataList.length}');

//     dataList.forEach((data) {
//       String timestamp = data['timestamp'];
//       List singleTransaction = jsonDecode(data['data']);

//       singleTransaction.forEach((element) {
//         print('Element : $element');
//         String action = element['Action'];
//         String tableName = element['TableName'];
//         print('Data: ${element['Data']}');
//         Map data = Map();
//         Map clause = Map();
//         if (element['Data'] != null)
//           data = element['Data'] ?? json.decode(element['Data']);
//         print('Clause: ${element['Clause']}');
//         if (element['Clause'] != null)
//           clause = element['Clause'] ?? json.decode(element['Clause']);
//         print('Action:$action');
//         print('Data : $data');
//         print('Clause : $clause');

//         // switch (action) {
//         //   case '1001':
//         //     DatabaseHelper()
//         //         .insertRecords(data: data, tablename: tableName, withLog: false)
//         //         .then((value) async {
//         //       await updateTimeStamp(timestamp);
//         //     });
//         //     break;
//         //   case '1002':
//         //     DatabaseHelper()
//         //         .updateRecords(
//         //             clause: clause,
//         //             data: data,
//         //             tablename: tableName,
//         //             withLog: false)
//         //         .then((value) async {
//         //       await updateTimeStamp(timestamp);
//         //     });
//         //     break;
//         //   case '1003':
//         //     DatabaseHelper()
//         //         .deleteRecords(
//         //             clause: clause, tablename: tableName, withLog: false)
//         //         .then((value) async {
//         //       await updateTimeStamp(timestamp);
//         //     });
//         //     break;
//         // }

//         print('$tableName : $action');
//       });

//       // DatabaseHelper()
//       //     .insertRecords(data: singlerow, tablename: tableName, withLog: false)
//       //     .then((value) async {
//       //   await updateTimeStamp(timestamp);
//       // });
//     });
//   }

//   Future<bool> updateTimeStamp(String clinetID) async {
//     Map data = new Map();
//     data['client_id'] = myID;

//     Map clause;
//     String tableName;
//     await DatabaseHelper()
//         .updateRecords(data: data, clause: clause, tablename: tableName);
//   }

//   Future<void> sendAckTimeStamps() async {
//     //1 GET NEW TIMETABLE;

//     //2 SEND MAP VIA HTTP
//   }
// }
