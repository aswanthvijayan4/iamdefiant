import 'package:authentication_with_bloc/erp/Screens/Counter/POSCounter.dart';
import 'package:authentication_with_bloc/erp/Screens/Dashboard/DefaultDashboard.dart';
import 'package:authentication_with_bloc/erp/Screens/Masters/Inventory/InventoryGroupList.dart';
import 'package:authentication_with_bloc/erp/Screens/Masters/Inventory/InventoryItemsList.dart';
import 'package:authentication_with_bloc/erp/Screens/Reports/Inventory/Stock/ClosingStockReport.dart';
import 'package:authentication_with_bloc/erp/Screens/Transactions/ItemDetailEditor.dart';
import 'package:authentication_with_bloc/erp/Screens/Transactions/StockJournal/StockJournalList.dart';
import 'package:authentication_with_bloc/erp/Widgets/ReportsSampleWidget.dart';
import 'package:authentication_with_bloc/home/views/home_main_view.dart';

import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class GDrawer extends StatefulWidget {
  final Widget child;

  const GDrawer({Key key, @required this.child}) : super(key: key);

  static GDrawerState of(BuildContext context) =>
      context.findAncestorStateOfType<GDrawerState>();

  @override
  GDrawerState createState() => new GDrawerState();
}

class GDrawerState extends State<GDrawer> with SingleTickerProviderStateMixin {
  static const Duration toggleDuration = Duration(milliseconds: 250);
  static const double maxSlide = 225;
  static const double minDragStartEdge = 60;
  static const double maxDragStartEdge = maxSlide - 16;
  AnimationController _animationController;
  bool _canBeDragged = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: GDrawerState.toggleDuration,
      vsync: this,
    );
  }

  void close() => _animationController.reverse();

  void open() => _animationController.forward();

  void toggleDrawer() => _animationController.isCompleted ? close() : open();

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_animationController.isCompleted) {
          close();
          return false;
        }
        return true;
      },
      child: GestureDetector(
        onHorizontalDragStart: _onDragStart,
        onHorizontalDragUpdate: _onDragUpdate,
        onHorizontalDragEnd: _onDragEnd,
        child: AnimatedBuilder(
          animation: _animationController,
          child: widget.child,
          builder: (context, child) {
            double animValue = _animationController.value;
            final slideAmount = maxSlide * animValue;
            final contentScale = 1.0 - (0.3 * animValue);
            return Stack(
              children: <Widget>[
                MyDrawer(),
                Transform(
                  transform: Matrix4.identity()
                    ..translate(slideAmount)
                    ..scale(contentScale, contentScale),
                  alignment: Alignment.centerLeft,
                  child: GestureDetector(
                    onTap: _animationController.isCompleted ? close : null,
                    child: child,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  void _onDragStart(DragStartDetails details) {
    bool isDragOpenFromLeft = _animationController.isDismissed &&
        details.globalPosition.dx < minDragStartEdge;
    bool isDragCloseFromRight = _animationController.isCompleted &&
        details.globalPosition.dx > maxDragStartEdge;

    _canBeDragged = isDragOpenFromLeft || isDragCloseFromRight;
  }

  void _onDragUpdate(DragUpdateDetails details) {
    if (_canBeDragged) {
      double delta = details.primaryDelta / maxSlide;
      _animationController.value += delta;
    }
  }

  void _onDragEnd(DragEndDetails details) {
    //I have no idea what it means, copied from Drawer
    double _kMinFlingVelocity = 365.0;

    if (_animationController.isDismissed || _animationController.isCompleted) {
      return;
    }
    if (details.velocity.pixelsPerSecond.dx.abs() >= _kMinFlingVelocity) {
      double visualVelocity = details.velocity.pixelsPerSecond.dx /
          MediaQuery.of(context).size.width;

      _animationController.fling(velocity: visualVelocity);
    } else if (_animationController.value < 0.5) {
      close();
    } else {
      open();
    }
  }
}

class RouteTransition extends PageRouteBuilder {
  final Widget page;
  RouteTransition({this.page})
      : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              page,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(1, 0),
              end: Offset.zero,
            ).animate(animation),
            child: ScaleTransition(
                scale: Tween<double>(
                  begin: 0.0,
                  end: 1.0,
                ).animate(
                  CurvedAnimation(
                    parent: animation,
                    curve: Curves.easeInToLinear,
                  ),
                ),
                child: child),
          ),
        );
}

class MyDrawer extends StatefulWidget {
  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  String _chosenValue;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.grey.shade400,
      child: SafeArea(
        child: Theme(
          data: ThemeData(
            brightness: Brightness.light,
          ),
          child: Scaffold(
            body: Container(
              color: Colors.grey.shade400,
              child: Row(
                children: [
                  Expanded(
                    flex: 6,
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Image.asset(
                              'assets/images/testbg.jpg',
                              width: 200,
                            ),
                            ListTile(
                                leading: Icon(Icons.dashboard),
                                title: Text('Dashboard'),
                                onTap: () {
                                  Navigator.push(context,
                                      RouteTransition(page: DashBoardScreen()));
                                  // Navigator.of(context).push(MaterialPageRoute(
                                  //     builder: (_) =>
                                  //         InventoryGroupListScreen())); //InventoryItemsListScreen
                                }),
                            // ListTile(
                            //     leading: Icon(Icons.blur_on),
                            //     title: Text('Inventory Groups'),
                            //     onTap: () {
                            //       Navigator.push(
                            //           context,
                            //           RouteTransition(
                            //               page: InventoryGroupListScreen()));
                            //       // Navigator.of(context).push(MaterialPageRoute(
                            //       //     builder: (_) =>
                            //       //         InventoryGroupListScreen())); //InventoryItemsListScreen
                            //     }),
                            ListTile(
                                leading: Icon(Icons.blur_on),
                                title: Text('Inventory Items'),
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      RouteTransition(
                                          page: InventoryItemsListScreen()));
                                  // Navigator.of(context).push(MaterialPageRoute(
                                  //     builder: (_) => InventoryItemsListScreen()));
                                }),
                            // buildDummyListTile(context, 'Account Groups'),
                            // buildDummyListTile(context, 'Ledgers'),
                            // buildDummyListTile(context, 'UOM'),
                            // buildDummyListTile(context, 'Employees'),
                            // buildDummyListTile(context, 'Godowns'),
                            Divider(),
                            // ListTile(
                            //   leading: Icon(Icons.blur_on),
                            //   title: Text('POS'),
                            //   onTap: () {
                            //     Navigator.push(context,
                            //         RouteTransition(page: POSCounterScreen()));
                            //     // Navigator.of(context).push(MaterialPageRoute(
                            //     //     builder: (_) => InventoryItemsListScreen()));
                            //   },
                            // ),
                            getVoucherTile(
                              context: context,
                              listTitle: 'Sales Order',
                              upsertLink:
                                  'sales_order_webservice.php?action=upsertSalesVoucher',
                              voucherLink:
                                  'sales_order_webservice.php?action=getvoucherbyvoucherno',
                              voucherListLink:
                                  'sales_order_webservice.php?action=getvoucherlistbydate',
                              voucherType: 'SALESORDER',
                            ),
                            getVoucherTile(
                              context: context,
                              listTitle: 'Sales',
                              upsertLink:
                                  'sales_voucher_webservice.php?action=upsertSalesVoucher',
                              voucherLink:
                                  'sales_voucher_webservice.php?action=getvoucherbyvoucherno',
                              voucherListLink:
                                  'sales_voucher_webservice.php?action=getvoucherlistbydate',
                              voucherType: 'SALESVOUCHER',
                            ),
                            getVoucherTile(
                              context: context,
                              listTitle: 'Deleted List',
                              upsertLink:
                                  'sales_voucher_deleted_webservice.php?action=',
                              voucherLink:
                                  'sales_voucher_deleted_webservice.php?action=getdeletedvoucherbyvoucherno',
                              voucherListLink:
                                  'sales_voucher_deleted_webservice.php?action=getdeletedvoucherlistbydate',
                              voucherType: 'SALESVOUCHER',
                            ),

                            Divider(),
                            getVoucherTile(
                              context: context,
                              listTitle: 'Payments',
                              upsertLink:
                                  'transactions_webservice.php?action=upsertTransaction&Voucher_Type=PAYMENTVOUCHER',
                              voucherLink:
                                  'transactions_webservice.php?action=getvoucherbyvoucherno&Voucher_Type=PAYMENTVOUCHER',
                              voucherListLink:
                                  'transactions_webservice.php?action=getvoucherlistbydate&Voucher_Type=PAYMENTVOUCHER',
                              voucherType: 'PAYMENTVOUCHER',
                            ),
                            getVoucherTile(
                              context: context,
                              listTitle: 'Receipts',
                              upsertLink:
                                  'transactions_webservice.php?action=upsertTransaction&Voucher_Type=RECEIPTVOUCHER',
                              voucherLink:
                                  'transactions_webservice.php?action=getvoucherbyvoucherno&Voucher_Type=RECEIPTVOUCHER',
                              voucherListLink:
                                  'transactions_webservice.php?action=getvoucherlistbydate&Voucher_Type=RECEIPTVOUCHER',
                              voucherType: 'RECEIPTVOUCHER',
                            ),
                            Divider(),
                            getVoucherTile(
                              context: context,
                              listTitle: 'Stock IN/OUT',
                              upsertLink:
                                  'stock_journal_webservice.php?action=upsertStockJournal',
                              voucherLink:
                                  'stock_journal_webservice.php?action=getvoucherbyvoucherno',
                              voucherListLink:
                                  'stock_journal_webservice.php?action=getvoucherlistbydate',
                              voucherType: 'STOCKJOURNAL',
                            ),

                            Divider(),

                            // buildDummyListTile(context, 'Ledger Reports'),
                            // buildDummyListTile(context, 'Day Book'),
                            // buildDummyListTile(context, 'Shifts'),

                            buildDummyListTile(context, 'Billwise Sales',
                                'reports_webservice.php?action=billwise_sales'),
                            buildDummyListTile(context, 'Itemwise Sales',
                                'reports_webservice.php?action=itemwise_sales'),
                            buildDummyListTile(context, 'Groupwise Sales',
                                'reports_webservice.php?action=groupwise_sales'),
                            buildDummyListTile(context, 'Salesmanwise',
                                'reports_webservice.php?action=waiterwise_sales'),
                            buildDummyListTile(context, 'Datewise Sales',
                                'reports_webservice.php?action=datewise_sales'),
                            buildDummyListTile(context, 'Sales Margin Report',
                                'reports_webservice.php?action=sales_margin'),
                            buildDummyListTile(context, 'Time based Sales',
                                'reports_webservice.php?action=time_based'),
                            buildDummyListTile(context, 'Shift Reports',
                                'reports_webservice.php?action=shiftwise_report'),

                            ListTile(
                              leading: Icon(Icons.blur_on),
                              title: Text('Closing Stock'),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  RouteTransition(
                                    page: ClosingStockReportScreen(
                                      reportTitle: 'Closing Stock',
                                      link: '',
                                    ),
                                  ),
                                );
                                // Navigator.of(context).push(MaterialPageRoute(
                                //     builder: (_) => InventoryItemsListScreen()));
                              },
                            ),
                            // buildDummyListTile(context, 'Damage'),
                            // buildDummyListTile(context, 'ReOrder Level Report'),
                            ListTile(
                              leading: Icon(Icons.blur_on),
                              title: Text('Logout'),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  RouteTransition(
                                    page: HomeMainView(),
                                  ),
                                );
                                // Navigator.of(context).push(MaterialPageRoute(
                                //     builder: (_) => InventoryItemsListScreen()));
                              },
                            ),
                            DropdownButton<String>(
                              focusColor: Colors.white,
                              value: _chosenValue,
                              //elevation: 5,
                              style: TextStyle(color: Colors.white),
                              iconEnabledColor: Colors.black,
                              items: <String>[
                                'kannur',
                                'Mahe',
                                'Westhills',
                                'calicut',
                                'Palayam',
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(
                                    value,
                                    style: TextStyle(color: Colors.black),
                                  ),
                                );
                              }).toList(),
                              hint: Text(
                                "Please choose a Branch",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500),
                              ),
                              onChanged: (String value) {
                                setState(() {
                                  _chosenValue = value;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: Container(
                      color: Colors.grey.shade400,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  ListTile getVoucherTile(
      {BuildContext context,
      String listTitle,
      String voucherLink,
      String upsertLink,
      String voucherType,
      String voucherListLink}) {
    return ListTile(
        leading: Icon(Icons.blur_on),
        title: Text(listTitle),
        onTap: () {
          Navigator.pop(context);
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
          // Navigator.of(context).push(MaterialPageRoute(
          //     builder: (_) => InventoryItemsListScreen()));
        });
  }

  ListTile buildDummyListTile(BuildContext context, String text, String link) {
    //SampleReportScreen
    return ListTile(
      leading: Icon(Icons.blur_on),
      title: Text(text),
      onTap: () {
        Navigator.push(
            context,
            RouteTransition(
                page: SampleReportScreen(
              reportName: text,
              getVoucherListLink: link,
            )));
      },
    );
  }
}

class Divider extends StatelessWidget {
  const Divider({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: 2,
        child: Container(
          color: Colors.blue.shade100,
        ),
      ),
    );
  }
}
