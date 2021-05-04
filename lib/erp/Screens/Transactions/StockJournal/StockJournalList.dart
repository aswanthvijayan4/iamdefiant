import 'package:authentication_with_bloc/erp/Blocs/Transactions/VoucherCubit/vouchercubit_cubit.dart';
import 'package:authentication_with_bloc/erp/Blocs/Transactions/VoucherListCubit/voucherlist_cubit.dart';
import 'package:authentication_with_bloc/erp/Screens/Transactions/StockJournal/StockJournalEditor.dart';
import 'package:authentication_with_bloc/erp/Webservice/webservice.dart';
import 'package:authentication_with_bloc/erp/Widgets/Drawer/GDrawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

class StockJournalListScreen extends StatefulWidget {
  StockJournalListScreen({
    Key key,
    @required this.getVoucherListLink,
    @required this.upsertLink,
    @required this.getVoucherLink,
    this.voucherType,
    this.title,
  }) : super(key: key);

  final String getVoucherListLink,
      upsertLink,
      getVoucherLink,
      voucherType,
      title;

  @override
  _StockJournalListScreenState createState() => _StockJournalListScreenState();
}

class _StockJournalListScreenState extends State<StockJournalListScreen> {
  // 'stock_journal_webservice.php?action=getvoucherlistbydate';
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
      title: Text(widget.title),
    );

    return GDrawer(
      child: BlocProvider(
        create: (context) => VoucherlistCubit(
          web: WebServiceHelper(),
          voucherListLink: widget.getVoucherListLink,
        ),
        child: StockJournalList(
          appBar: appBar,
          upsertLink: widget.upsertLink,
          getVoucherLink: widget.getVoucherLink,
          voucherType: widget.voucherType,
          title: widget.title,
        ),
      ),
    );
  }
}

class StockJournalList extends StatefulWidget {
  StockJournalList(
      {Key key,
      this.appBar,
      this.upsertLink,
      this.getVoucherLink,
      this.voucherType,
      this.title})
      : super(key: key);
  final AppBar appBar;
  final String upsertLink;
  final String voucherType;
  final String getVoucherLink;
  final String title;

  @override
  StockJournalListState createState() => StockJournalListState();
}

class StockJournalListState extends State<StockJournalList> {
  final _scrollController = ScrollController();
  final _scrollThreshold = 200.0;
  VoucherlistCubit _voucherList;
  DateTime dateFrom;
  DateTime dateTo;
  bool dateChanged = false;

  @override
  void initState() {
    super.initState();
    dateFrom = DateTime.now().subtract(const Duration(days: 0));
    dateTo = DateTime.now();
    // link = 'resto/sales_order_webservice.php?action=getvoucherlistbydate';
    _scrollController.addListener(_onScroll);
    _voucherList = BlocProvider.of<VoucherlistCubit>(context)
      ..fetchVoucherList(
        dateFrom: dateFrom,
        dateTo: dateTo,
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: widget.appBar,
        resizeToAvoidBottomInset: false,

        // floatingActionButton: FloatingActionButton(
        //   onPressed: () {
        //     // _itemsListBloc.add(CreateEntityEvent());
        //     openEditor();
        //   },
        //   child: Icon(Icons.add),
        // ),

        body: Container(
          child: Column(
            children: [
              getFilter(),
              Expanded(
                child: _buildList(),
              ),
            ],
          ),
        ));
  }

  Widget _buildList() {
    return BlocConsumer<VoucherlistCubit, VoucherlistState>(
      builder: (context, state) {
        if (state is VoucherListReady) {
          return Container(child: getBody(state.data));
        } else if (state is VoucherListFetchError) {
          return Container(child: Text('Error'));
        } else if (state is VoucherlistFetching) {
          return Center(
            child: Column(
              children: [
                Container(child: Text('Fetching')),
              ],
            ),
          );
        } else if (state is VoucherListEmpty) {
          return Container(
              child: Center(
                  child: Shimmer.fromColors(
                      highlightColor: Colors.red,
                      baseColor: Colors.black,
                      child: Text(
                        'No items in List!!!',
                        style: TextStyle(fontSize: 18),
                      ))));
        } else if (state is VoucherListRefreshing) {
          return Container(child: Text('Refreshing'));
        } else {
          return Container(child: Text('Else of all'));
        }
      },
      listener: (context, state) {
        if (state is VoucherListRefreshing) {}
      },
    );
  }

  Widget getBody(List data) {
    return Container(
      color: Theme.of(context).secondaryHeaderColor,
      child: Column(
        children: [Expanded(flex: 30, child: getList(data))],
      ),
    );
  }

  String inCurrency(String val) {
    return '\u20B9' + double.parse(val ?? "0").toStringAsFixed(2);
  }

  Widget getList(List data) {
    num total = 0;
    for (int i = 0; i < data.length; i++) {
      total += double.parse(data[i]['Total'] ?? "0");
    }
    String _tString = total.toStringAsFixed(2);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Expanded(
            flex: 18,
            child: getListofVouchers(data),
          ),
          Expanded(
              child: Container(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  'Total : \u20B9 $_tString',
                  style: TextStyle(color: Colors.black, fontSize: 22),
                ),
              ),
            ),
          )),
        ],
      ),
    );
  }

  ListView getListofVouchers(List data) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return Card(
          child: ListTile(
            title: Text(' ${data[index]['Ledger'] ?? ""}'),
            subtitle: Text(data[index]['Voucher_Date'] ?? ""),
            leading: Text('# ${data[index]['Voucher_No'] ?? ""}'),
            trailing: Text(inCurrency(data[index]['Total'] ?? "0")),
            onTap: () {
              openEditorEdit(
                  data[index]['Voucher_No'], data[index]['Voucher_Prefix']);
            },
          ),
        );
      },
      itemCount: data.length,
    );
  }

  Widget getFilter() {
    final DateFormat formatter = DateFormat('dd-MM-yyyy');

    print('Date is $dateFrom');
    String dateF = formatter.format(dateFrom);
    String datet = formatter.format(dateTo);

    // return Container();

    return Column(
      children: [
        Container(
          // color: Colors.grey.shade300,
          child: Row(
            children: [
              getCalenderIcon(),
              Padding(
                padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
              ),
              Text(
                'Date',
                style: TextStyle(fontSize: 18, color: Colors.blue),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
              ),
              Flexible(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.blue.shade300,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Colors.transparent,
                    ),
                  ),
                  child: InkWell(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        '$dateF',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                    onTap: () async {
                      final DateTime dt = await showDatePicker(
                        context: context,
                        initialDate: dateFrom,
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2100),
                      );
                      if (dt != null) {
                        setState(() {
                          dateChanged = true;
                          dateFrom = dt;
                        });
                      }
                    },
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
              ),
              Text(
                'To',
                style: TextStyle(fontSize: 18, color: Colors.blue),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
              ),
              Flexible(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.blue.shade300,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Colors.transparent,
                    ),
                  ),
                  child: InkWell(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        '$datet',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                    onTap: () async {
                      final DateTime dt = await showDatePicker(
                        context: context,
                        initialDate: dateTo,
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2100),
                      );
                      if (dt != null) {
                        setState(() {
                          dateChanged = true;
                          dateTo = dt;
                        });
                      }
                    },
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
              ),
              IconButton(
                iconSize: 30,
                icon: Icon(
                  Icons.send,
                  color: dateChanged ? Colors.red : Colors.blue,
                ),
                onPressed: refreshList,
              )
            ],
          ),
        ),
        // SizedBox(
        //   height: 5,
        //   child: Container(
        //     color: Colors.blue,
        //   ),
        // )
      ],
    );
  }

  Padding getCalenderIcon() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10.0, 0, 0, 0),
      child: Icon(
        Icons.calendar_today_rounded,
        color: Colors.blue,
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void requestData() {
    _voucherList.fetchVoucherList(
      dateFrom: dateFrom,
      dateTo: dateTo,
      // link: 'resto/sales_order_webservice.php?action=getvoucherlistbydate',
    );
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;

    // print('maxScroll : $maxScroll');
    // print('current : $currentScroll');
    if (maxScroll - currentScroll <= _scrollThreshold) {
      print('Load More...');
      // _itemsListBloc.add(LoadData());
    }
  }

  void openEditor() {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (_) => MultiBlocProvider(
              providers: [
                BlocProvider(
                  create: (_) => VouchercubitCubit(
                    web: WebServiceHelper(),
                    voucherType: widget.voucherType,
                    link: widget.upsertLink,
                    getVoucherLink: widget.getVoucherLink,
                  )..getEmptyVoucher(),
                ),
              ],
              child: StockJournalEditor(
                isEdit: false,
                title: widget.title,
              ),
            )));
  }

  void openEditorEdit(String voucherNo, String voucherPrefix) {
    print('Voiucher : $voucherNo');
    Navigator.of(context).push(MaterialPageRoute(
        builder: (_) => MultiBlocProvider(
              providers: [
                BlocProvider(
                  create: (_) => VouchercubitCubit(
                      web: WebServiceHelper(),
                      voucherType: widget.voucherType,
                      link: widget.upsertLink,
                      getVoucherLink: widget.getVoucherLink)
                    ..getVoucherFromRepo(voucherNo, voucherPrefix),
                ),
              ],
              child: StockJournalEditor(
                isEdit: true,
                title: widget.title,
              ),
            )));
  }

  void refreshList() {
    setState(() {
      dateChanged = false;
    });
    _voucherList.fetchVoucherList(
      dateFrom: dateFrom,
      dateTo: dateTo,
    );
  }
}
