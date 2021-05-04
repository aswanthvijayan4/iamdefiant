import 'package:authentication_with_bloc/erp/Blocs/POS/InvGroups/invgroupspos_cubit.dart';
import 'package:authentication_with_bloc/erp/Blocs/POS/InvItems/invitemspos_cubit.dart';
import 'package:authentication_with_bloc/erp/Blocs/Transactions/VoucherCubit/vouchercubit_cubit.dart';
import 'package:authentication_with_bloc/erp/DataModels/Masters/Inventory/InventoryItemDataModel.dart';
import 'package:authentication_with_bloc/erp/DataModels/Transactions/GeneralVoucherDataModel.dart';
import 'package:authentication_with_bloc/erp/Screens/Counter/CartWidget.dart';
import 'package:authentication_with_bloc/erp/Screens/Counter/POSCartList.dart';
import 'package:authentication_with_bloc/erp/Webservice/webservice.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:authentication_with_bloc/erp/Widgets/Drawer/GDrawer.dart';
import 'package:shimmer/shimmer.dart';

class POSCounterScreen extends StatefulWidget {
  POSCounterScreen({Key key}) : super(key: key);

  @override
  _POSCounterScreenState createState() => _POSCounterScreenState();
}

class _POSCounterScreenState extends State<POSCounterScreen> {
  @override
  Widget build(BuildContext context) {
    AppBar appBar = AppBar(
      leading: Builder(
        builder: (context) {
          return IconButton(
            icon: Icon(Icons.menu),
            onPressed: () => GDrawer.of(context).open(),
          );
        },
      ),
      title: Text('authentication_with_bloc/erpTouch'),
      // Shimmer.fromColors(
      //     child: Text('authentication_with_bloc/erpTouch'),
      //     baseColor: Colors.green[900],
      //     highlightColor: Colors.grey), //Text('authentication_with_bloc/erpTouch'),
    );

    return GDrawer(
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => VouchercubitCubit(
              web: WebServiceHelper(),
              voucherType: 'SALESVOUCHER',
              link: 'sales_voucher_webservice.php?action=upsertSalesVoucher',
            )..getEmptyVoucher(),
          ),
          BlocProvider(
            create: (context) =>
                InvgroupsposCubit(WebServiceHelper())..fetchAllGroups(),
          ),
          BlocProvider(
              create: (context) => InvitemsposCubit(
                    WebServiceHelper(),
                  )),
        ],
        child: POSCounter(
          appBar: appBar,
        ),
      ),
    );
  }
}

class POSCounter extends StatefulWidget {
  POSCounter({
    Key key,
    this.appBar,
  }) : super(key: key);
  final AppBar appBar;

  @override
  _POSCounterState createState() => _POSCounterState();
}

class _POSCounterState extends State<POSCounter> {
  InvitemsposCubit _invCubit;
  VouchercubitCubit _voucherCubit;

  double cwidth = 300;
  double cheight = 300;
  Offset position;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // SystemChrome.setPreferredOrientations(
    //     [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
    _invCubit = BlocProvider.of<InvitemsposCubit>(context);
    _voucherCubit = BlocProvider.of<VouchercubitCubit>(context);
    position = Offset(0, cheight - 20);
  }

  int gridViewColCount = 4;

  @override
  Widget build(BuildContext context) {
    print('DX : ${position.dx}');
    return BlocConsumer<VouchercubitCubit, VouchercubitState>(
      listener: (context, state) {
        if (state is VoucherSaved) {
          _voucherCubit.getEmptyVoucher();
        }
      },
      builder: (context, state) {
        if (state is VoucherReady)
          return Scaffold(
            appBar: widget.appBar,
            body: Stack(
              children: [
                getMainWidget(state.voucher),
                state.voucher.InventoryItems.length == -1
                    ? Positioned(
                        bottom: -300,
                        child: draggableCart(state.voucher),
                      )
                    : Container(),
                state.voucher.InventoryItems.length > 0
                    ? Align(
                        alignment: Alignment.bottomLeft,
                        child: IconButton(
                            icon: Icon(Icons.shopping_bag),
                            onPressed: openCart),
                      )
                    : Container(),
              ],
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                sendVoucher(state.voucher);
              },
              child: Icon(Icons.send),
            ),
          );
      },
    );
  }

  void openCart() {
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            backgroundColor: Colors.transparent,
            child: BlocProvider.value(
              value: _voucherCubit,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(40),
                child: Container(
                    color: Colors.white54,
                    height: MediaQuery.of(context).size.height * 0.90,
                    width: MediaQuery.of(context).size.width * 0.95,
                    child: CartWidget()),
              ),
            ),
          );
        });
  }

  Widget draggableCart(final GeneralVoucherDataModel voucher) {
    return Draggable(
      child: Container(
        width: cwidth,
        height: cheight,
        child: POSCartList(
          fontSize: 8,
          justQty: true,
          voucher: voucher,
        ),
      ),
      feedback: Container(
        color: Colors.blue,
        child: Center(
          child: Text('drag'),
        ),
      ),
      onDragEnd: (details) {
        position = details.offset;
        print('Drag complete');
        setState(() {});
      },
    );
  }

  Container getMainWidget(final GeneralVoucherDataModel voucher) {
    print('Voucher Total : ${voucher.grandTotal}');
    return Container(
      child: Column(
        children: [
          SizedBox(
            height: 120,
            child: Container(
              // color: Colors.black,
              child: getGroupBloc(),
            ),
          ),
          Expanded(
            flex: 20,
            child: Container(
              color: Colors.amber,
              child: getItemsBloc(),
            ),
          ),
          voucher.InventoryItems.length > 0
              ? Expanded(
                  flex: 1,
                  child: Row(
                    children: [
                      Expanded(
                        child: FlatButton(
                          onPressed: () {
                            openCart();
                          },
                          child: Text('Open Cart'),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          ' Total : ${voucher.grandTotal.toStringAsFixed(2)}',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ],
                  ),
                )
              : Container()
        ],
      ),
    );
  }

  void sendVoucher(final GeneralVoucherDataModel voucher) async {
    if (voucher.InventoryItems.length > 0) {
      voucher.reference = DateTime.now().millisecondsSinceEpoch.toString();
      _voucherCubit.saveVoucher(voucher);
    } else {
      Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text('No items Added!'),
        ),
      );
    }
  }

  Widget getGroupBloc() {
    return BlocConsumer<InvgroupsposCubit, InvgroupsposState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is InvgroupsposFetching) {
          return Center(child: CircularProgressIndicator());
        } else if (state is InvgroupsposReady) {
          final data = state.data;
          return getgroupsBody(data);
        } else if (state is InvgroupsposFetchError) {
          return Container(child: Text('Cant fetch data error ${state.err}'));
        } else {
          return InkWell(
            child: Container(
              child: Center(
                child: Column(
                  children: [
                    Flexible(
                      child: Text('Load Error Refresh????'),
                      flex: 1,
                    ),
                    Icon(Icons.refresh),
                  ],
                ),
              ),
            ),
            onTap: () {
              _voucherCubit.getEmptyVoucher();
            },
          );
        }
      },
    );
  }

  Widget getgroupsBody(List data) {
    return Center(
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: data.length - 1,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              child: Card(
                elevation: 10,
                child: SizedBox(
                  width: 100,
                  child: Container(
                    child: Center(
                        child: Padding(
                      padding: const EdgeInsets.fromLTRB(4, 0, 4, 0),
                      child: Text(
                        data[index + 1]['Group_Name'],
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    )),
                  ),
                ),
              ),
              onTap: () {
                groupSelected(groupID: data[index + 1]['Group_Id']);
              },
            ),
          );
        },
      ),
    );
  }

  void groupSelected({String groupID}) {
    _invCubit.fetchitemsUnder(groupID: groupID);
  }

  Widget getItemsBloc() {
    return BlocConsumer<InvitemsposCubit, InvitemsposState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is InvitemsposFetching) {
          return Center(child: CircularProgressIndicator());
        } else if (state is InvitemsposReady) {
          final data = state.data;
          return getItemsBody(data);
        } else if (state is InvitemsposInitial) {
          return Container(
            child: Center(
              child: Text('Select a Group'),
            ),
          );
        } else {
          return Container(
            child: Center(
              child: Text('Load Error'),
            ),
          );
        }
      },
    );
  }

  Widget getItemsBody(List data) {
    return GridView.count(
      crossAxisCount: gridViewColCount,
      children: List.generate(data.length, (index) {
        return getItemCard(data, index);
      }),
    );
  }

  Widget getItemCard(List data, int index) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          elevation: 5,
          child: Column(
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  color: double.parse(data[index]['ClosingStock'] ?? '0') > 0
                      ? Colors.blue[400]
                      : Colors.grey,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(4, 0, 4, 0),
                    child: Center(
                      child: Text(
                        data[index]['Item_Name'],
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  child: Center(
                    child: Text(
                      double.parse(data[index]['price']).toStringAsFixed(2),
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        onTap: () {
          if (double.parse(data[index]['ClosingStock'] ?? '0') > 0 || true) {
            print('Item : ${data[index]}');

            final InventoryItemDataModel item =
                InventoryItemDataModel.fromMapForTransTest(data[index]);
            print('Item : ${item.itemName} Price :  ${item.price} ');
            _voucherCubit.addItemByQty(item);
          }
        },
      ),
    );
  }
}
