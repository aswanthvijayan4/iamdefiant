// import 'package:authentication_with_bloc/Blocs/Master/Inventory/Groups/List/inventorygroups_bloc.dart';
// import 'package:authentication_with_bloc/Blocs/Master/Inventory/Items/List/inventoryitemslist_bloc.dart';
import 'package:authentication_with_bloc/Blocs/MasterSync/ItemsSync/itemssync_cubit.dart';
import 'package:authentication_with_bloc/DataModels/HiveModels/TransactionItem/TransactionitemHelperModel.dart';
import 'package:authentication_with_bloc/DataModels/Search/ItemSearchModel.dart';
// import 'package:authentication_with_bloc/Database/DatabaseHelper.dart';
// import 'package:authentication_with_bloc/Database/Inventory/Masters/InventoryGroupsMasterDatabaseHelper.dart';
// import 'package:authentication_with_bloc/Database/Inventory/Masters/InventoryItemsDatabaseHelper.dart';
// import 'package:authentication_with_bloc/Screens/Counter/POSCounter.dart';
import 'package:authentication_with_bloc/Screens/Dashboard/DefaultDashboard.dart';
//import 'package:authentication_with_bloc/Screens/Masters/Inventory/InventoryItemsList.dart';
//import 'package:authentication_with_bloc/Sync/SyncHelper.dart';

//import 'package:authentication_with_bloc/Utils/Navigator/RouteGenerator.dart';
import 'package:authentication_with_bloc/Webservice/webservice.dart';
import 'package:authentication_with_bloc/login/branch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'DataModels/HiveModels/InventoryItems/InvetoryItemDataModel.dart';
// import 'Screens/jsonTable.dart';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';

// import 'package:path_provider/path_provider.dart' as path_provider;

import 'package:flutter/foundation.dart' show kIsWeb;

//import 'package:path_provider/path_provider.dart' as pathProvider;

Future<void> main() async {
  // final docDir = path_provider.getApplicationDocumentsDirectory();

  if (!kIsWeb) {
    WidgetsFlutterBinding.ensureInitialized();
    // String token = await FirebaseMessagin.getToken();
    // print('Token : $token');
  }
  await Hive.initFlutter();
  Hive.registerAdapter<ItemSearchModel>(ItemSearchModelAdapter());
  Hive.registerAdapter<TransactionItemModel>(TransactionItemModelAdapter());
  Hive.registerAdapter<InventoryItemHive>(InventoryItemHiveAdapter());

  var v = await Hive.openBox<ItemSearchModel>('items');

  // ItemSearchModel item = ItemSearchModel()
  //   ..itemID = '0x1'
  //   ..itemName = 'Apple';
  // val.put(item.itemID, item);

  // ItemSearchModel item2 = val.get(item.itemID);

  // print('item Name : ${item2.itemName}');

  // await WebServiceHelper().loadAllItems();

  // runApp(Testss());
  runApp(MaterialApp(home: MyApp(box: v)));
  // runApp(DashBoardScreen());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  final Box box;

  const MyApp({Key key, this.box}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'authentication_with_bloc Dashboard',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(
          // primarySwatch: Colors.blueGrey,
          // cardTheme: CardTheme(elevation: 5, color: Colors.cyanAccent)
          ),

      home: BlocProvider(
        lazy: true,
        create: (context) =>
            ItemssyncCubit(WebServiceHelper())..fetchItems(box),
        child: ItemsLoader(
          box: box,
        ),
      ),

      // till here
    );
  }
}

class ItemsLoader extends StatefulWidget {
  ItemsLoader({Key key, this.box}) : super(key: key);

  final Box box;

  @override
  _ItemsLoaderState createState() => _ItemsLoaderState();
}

class _ItemsLoaderState extends State<ItemsLoader> {
  String _homeScreenText = "Waiting for token...";
  String _messageText = "Waiting for message...";

  @override
  void initState() {
    super.initState();
    return;
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: BlocBuilder<ItemssyncCubit, ItemssyncState>(
          builder: (context, state) {
        // if (state is ItemsFetchCompleted) {
        //   return DashBoardScreen();
        //   // return POSCounterScreen();
        // }

        if (state is ItemsFetching) {
          return Container(
            child: Center(child: Text('Waiting for Server...')),
          );
        }

        if (state is ItemsFetchError) {
          return Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '${state.message ?? ''}\nFetch Error!!! \nClick below to check Again',
                textAlign: TextAlign.center,
              ),
              IconButton(
                  icon: Icon(Icons.refresh),
                  onPressed: () {
                    BlocProvider.of<ItemssyncCubit>(context)
                        .fetchItems(widget.box);
                  })
            ],
          ));
        } else {
          return Column(
            children: [
              Expanded(
                flex: 1,
                child: DashBoardScreen(),
                 

              ),
              // Expanded(flex: 1, child: Material(child: Text(_messageText))),
            ],
          );
        }
      }),
    );
  }
}
