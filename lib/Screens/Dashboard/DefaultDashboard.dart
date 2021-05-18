import 'package:authentication_with_bloc/authenticaiton/bloc/authentication_bloc.dart';
import 'package:authentication_with_bloc/Blocs/Dashboard/dashboardcubit_cubit.dart';
import 'package:authentication_with_bloc/Screens/Transactions/StockJournal/StockJournalList.dart';

import 'package:authentication_with_bloc/Webservice/webservice.dart';
import 'package:authentication_with_bloc/login/branch/cubit/branch_cubit.dart';
import 'package:flutter/material.dart';

import 'package:authentication_with_bloc/Widgets/Drawer/GDrawer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'dart:async';

class DashBoardScreen extends StatelessWidget {
  final String url;
  DashBoardScreen({Key key, this.url}) : super(key: key);
  final AppBar appBar = AppBar(
    leading: Builder(
      builder: (context) {
        return IconButton(
          icon: Icon(Icons.menu),
          onPressed: () => GDrawer.of(context).open(),
        );
      },
    ),
    title: Text('DashBoard'),
    // backgroundColor: Colors.black,
  );

  @override
  Widget build(BuildContext context) {
    // print('Dashboard');
    // print(
    //     'url from branch ${(BlocProvider.of<BranchCubit>(context).state as BranchReady).baseURL}');
    print(
        'branch is ${(BlocProvider.of<AuthenticationBloc>(context).state as AuthenticationSuccess).branch}');
    return GDrawer(
      child: MultiBlocProvider(
        providers: [
          BlocProvider.value(
              value: BlocProvider.of<AuthenticationBloc>(context)),
          // BlocProvider.value(
          //   value: BlocProvider.of<BranchCubit>(context),
          // ),
          BlocProvider(
            create: (context) =>
                DashboardcubitCubit(web: WebServiceHelper.withURL(ip: url))
                  ..getDashboardData(),
          ),
          // BlocProvider.value(
          //   value: BlocProvider.of<ProfileCubit>(context),
          // )
        ],
        child: DefaultDashboard(
          appBar: appBar,
        ),
      ),
      // BlocProvider(
      //     create: (context) => DashboardcubitCubit(
      //         web: WebServiceHelper.withURL(ip:'http://31.220.109.198/test_app'))
      //       ..getDashboardData(),
      //     child: DefaultDashboard(
      //       appBar: appBar,
      //     ),
      //   ),
    );
  }
}

class DefaultDashboard extends StatefulWidget {
  const DefaultDashboard({Key key, this.appBar}) : super(key: key);

  @override
  _DefaultDashboardState createState() => _DefaultDashboardState();
  final AppBar appBar;
}

class _DefaultDashboardState extends State<DefaultDashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // bottomSheet: Text('Bottom'),
      appBar: widget.appBar,
      body: blocPass(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          refreshPage();
        },
        child: Icon(Icons.refresh),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // startTimer();
  }

  void startTimer() {
    const oneSec = const Duration(seconds: 5);
    new Timer.periodic(oneSec, (Timer t) {
      refreshPage();
    });
  }

  void refreshPage() {
    print('Refreshing Page');
    BlocProvider.of<DashboardcubitCubit>(context)
        .getDashboardData(showrefresh: true);
  }

  BlocConsumer<DashboardcubitCubit, DashboardcubitState> blocPass() {
    return BlocConsumer<DashboardcubitCubit, DashboardcubitState>(
      builder: (context, state) {
        if (state is DashBoardReady) {
          print(state.data);
          return getBody(state.data);
        } else if (state is DashBoardFetchError) {
          return Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Fetch Error!!! \nClick below to refresh',
                textAlign: TextAlign.center,
              ),
              IconButton(
                  icon: Icon(Icons.refresh),
                  onPressed: () {
                    BlocProvider.of<DashboardcubitCubit>(context)
                        .getDashboardData();
                  })
            ],
          ));
        } else if (state is DashBoardFetching) {
          return Center(
              child: Container(
            child: Text('Fetching Data'),
          ));
        } else {
          return Container();
        }
      },
      listener: (context, state) {},
    );
  }

  Widget getBody(Map data) {
    return Container(
      child: Column(
        children: [
          Expanded(
              flex: 1,
              child:
                  Container(color: Colors.blue.shade50, child: getTop(data))),
          // SizedBox(
          //   height: 10,
          //   child: Container(),
          // ),
          Expanded(
              flex: 4,
              child: Container(
                color: Colors.blue.shade50,
                child: getBottom(data),
              )),
          // Expanded(flex: 1, child: Container(color: Colors.green)),
        ],
      ),
    );
  }

  void moveTo({
    String listTitle = 'Sales Order',
    String upsertLink = 'sales_order_webservice.php?action=upsertSalesVoucher',
    String voucherLink =
        'sales_order_webservice.php?action=getvoucherbyvoucherno',
    String voucherListLink =
        'sales_order_webservice.php?action=getvoucherlistbydate',
    String voucherType = 'SALESORDER',
  }) {
    // Navigator.pop(context);
    Navigator.push(
      context,
      RouteTransition(
        page: StockJournalListScreen(
          getVoucherLink: voucherLink,
          upsertLink: upsertLink,
          getVoucherListLink: voucherListLink,
          voucherType: voucherType,
          title: listTitle,
        ),
      ),
    );
  }

  Widget getBottom(Map data) {
    List<dynamic> credLeds = data['SalesByLedger'] ?? [];
    List<Widget> wids = [];

    credLeds.forEach((element) {
      print('${element['Ledger']} - ${element['Amount']}');
      wids.add(
        getBottomListItem(
          'Sales By ' + element['Ledger'],
          inCurrency(element['Amount'] ?? "0"),
        ),
      );
    });
    return ListView(
      padding: EdgeInsets.fromLTRB(0, 4, 0, 4),
      children: [
        InkWell(
          onTap: () {
            moveTo(
              listTitle: 'Sales',
              upsertLink:
                  'sales_voucher_webservice.php?action=upsertSalesVoucher',
              voucherLink:
                  'sales_voucher_webservice.php?action=getvoucherbyvoucherno',
              voucherListLink:
                  'sales_voucher_webservice.php?action=getvoucherlistbydate',
              voucherType: 'SALESVOUCHER',
            );
          },
          child: getBottomListItem('Orders Served', data['billsCount'] ?? "0"),
        ),

        InkWell(
          onTap: () {
            moveTo(
              listTitle: 'Sales Order',
              upsertLink:
                  'sales_order_webservice.php?action=upsertSalesVoucher',
              voucherLink:
                  'sales_order_webservice.php?action=getvoucherbyvoucherno',
              voucherListLink:
                  'sales_order_webservice.php?action=getvoucherlistbydate',
              voucherType: 'SALESORDER',
            );
          },
          child:
              getBottomListItem('Orders Pending', data['ordersCount'] ?? "0"),
        ),
        InkWell(
            onTap: () {
              moveTo(
                listTitle: 'Deleted List',
                upsertLink: 'sales_voucher_deleted_webservice.php?action=',
                voucherLink:
                    'sales_voucher_deleted_webservice.php?action=getdeletedvoucherbyvoucherno',
                voucherListLink:
                    'sales_voucher_deleted_webservice.php?action=getdeletedvoucherlistbydate',
                voucherType: 'SALESVOUCHER',
              );
            },
            child: getBottomListItem(
                'Orders Deleted', data['deletedCount'] ?? "0")),
        // getBottomListItem('Pax Total', data['Pax'] ?? "0"),
        // getBottomListItem(
        //     'Sales By Cash', inCurrency(data['CashSales'] ?? "0")),

        getBottomListItem(
            'Sales By Credit', inCurrency(data['CreditSales'] ?? "0")),
        // Column(children: wids),
        getBottomListItem('Payments', inCurrency(data['PaymentTotal'] ?? "0")),
        getBottomListItem('Receipts', inCurrency(data['ReceiptTotal'] ?? "0")),
        getChart(data),
      ],
    );
  }

  Card getBottomListItem(String title, String value) {
    return Card(
      child: Row(
        children: [
          SizedBox(
            width: 5,
            child: Container(
              color: Colors.red,
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.transparent,
              child: Row(
                children: [
                  Flexible(
                    child: Container(
                      child: ListTile(
                        title: Text(
                          title,
                          style: TextStyle(color: Colors.blue.shade900),
                        ),
                        trailing: Text(
                          value,
                          style: TextStyle(color: Colors.blue.shade900),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget getTop(Map data) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              getTopChild(
                  'Sales', inCurrency(data['SalesTotal']), Colors.green),
              SizedBox(
                width: 10,
              ),
              getTopChild(
                  'Purchase', inCurrency(data['PurchaseTotal']), Colors.blue),
              getTopChild('Expenses', inCurrency(data['Expenses']), Colors.red),
            ],
          ),
        ),
      ),
    );
  }

  String inCurrency(String val) {
    return '\u20B9' + double.parse(val ?? "0").toStringAsFixed(2);
  }

  Expanded getTopChild(String label, String value, Color color) {
    return Expanded(
      child: Card(
        shadowColor: color,
        borderOnForeground: false,
        child: Container(
          decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(15.0)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    '$label',
                    style: TextStyle(fontSize: 20, color: color),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  '$value',
                  style: TextStyle(fontSize: 20, color: color),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget getChart(final Map data) {
    List<dynamic> days = data['7DaysSales'] ?? [];
    List<LinearSales> vals = [];
    int i = 1;
    days.forEach((element) {
      print(element['TotalSales']);
      int n = int.parse(element['Voucher_Date'].toString().split('-')[2]);
      vals.add(LinearSales(n, double.parse(element['TotalSales'] ?? "0")));
      i++;
    });

    List<charts.Series<LinearSales, int>> series = [
      new charts.Series<LinearSales, int>(
        id: 'Sales',
        displayName: 'Sales',
        colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault,
        domainFn: (LinearSales sales, _) => sales.date,
        measureFn: (LinearSales sales, _) => sales.sales,
        data: vals,
        strokeWidthPxFn: (datum, index) => 5,
        fillColorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
      )
    ];

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Card(
        shadowColor: Colors.grey,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
          ),
          child: Row(
            children: [
              Container(
                child: SizedBox(
                  width: 3,
                  child: Container(
                    color: Colors.red,
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.transparent,
                  ),
                  height: 250,
                  child: Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: SimpleLineChart(series),
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        widthFactor: 4.5,
                        child: Text(
                          'Last 7 days',
                          style: TextStyle(color: Colors.white),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SimpleLineChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  SimpleLineChart(this.seriesList, {this.animate, this.cData});

  /// Creates a [LineChart] with sample data and no transition.
  factory SimpleLineChart.withSampleData() {
    return new SimpleLineChart(
      _createSampleData(),
      // Disable animations for image tests.
      animate: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return new charts.LineChart(
      seriesList,
      animate: animate,
    );
  }

  final List cData;

  //  Create one series with sample hard coded data.
  static List<charts.Series<LinearSales, int>> _createSampleData() {
    final data = [
      LinearSales(1, 13200),
      LinearSales(2, 11200),
      LinearSales(3, 15900),
      LinearSales(4, 14200),
      LinearSales(5, 11200),
      LinearSales(6, 14500),
      LinearSales(7, 14380),
    ];

    return [
      new charts.Series<LinearSales, int>(
        id: 'Sales',
        displayName: 'Sales',
        colorFn: (_, __) => charts.MaterialPalette.green.shadeDefault,
        domainFn: (LinearSales sales, _) => sales.date,
        measureFn: (LinearSales sales, _) => sales.sales,
        data: data,
        strokeWidthPxFn: (datum, index) => 5,
        fillColorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
      )
    ];
  }
}

/// Sample linear data type.
class LinearSales {
  final int date;
  final double sales;

  LinearSales(this.date, this.sales);
}
