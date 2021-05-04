import '../DatabaseHelper.dart';
import 'dart:async';
import 'dart:convert';

class SyncLogHelper {


  /*
   1. my_last_timestamp (get latest time in log for client_id) with action=my_last_timestamp&client_id=C
   2. JsonData = getLogData() SELECT  * FROM log where `client_id` = ? AND `timestamp` > ? order by `timestamp` Limit 10
   3. store_my_data store_my_data&client_id=C with JsonData in header
   4. JsonData = get_restofdata (action=get_restofdata&client_id=C)
   5. call insert or update or delete as per log
   */

    Future<String> getMyLastTimeStamp () async {

      String timeStamp;
      timeStamp = "";

      return timeStamp;
    }

    Future<List<Map<String,dynamic>>> getLogData(String timestamp) async{

      List<Map<String,dynamic>> data;
      String action = "action=my_last_timestamp&client_id=C";
      // Call webservice with action

      return data;
    }

    Future<bool> SendMyData(Map map) async{
      //store_my_data&client_id=C
      bool value = true;

      return value;

    }


    Future<List<Map>> getRestOfData() async {
      //get_restofdata&client_id=C
      List<Map<String,dynamic>> map;

      return map;
    }

    Future<bool> storeData() async {
      // Call database insert|update|delete functions depending on action
        bool flag;

        return flag;
    }

}