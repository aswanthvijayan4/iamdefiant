import 'package:authentication_with_bloc/Blocs/Transactions/VoucherListCubit/voucherlist_cubit.dart';
import 'package:authentication_with_bloc/Webservice/webservice.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:authentication_with_bloc/Widgets/Drawer/GDrawer.dart';
import 'package:intl/intl.dart';
import 'package:json_table/json_table.dart';

class SampleReportScreen extends StatelessWidget {
  const SampleReportScreen({
    Key key,
    this.reportName,
    this.getVoucherListLink,
  }) : super(key: key);
  final String reportName;
  final String getVoucherListLink;
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
      title: Text(reportName),
    );

    return GDrawer(
      child: BlocProvider(
        create: (context) => VoucherlistCubit(
          web: WebServiceHelper(),
          voucherListLink: getVoucherListLink,
        ),
        child: SampleReport(
          appBar: appBar,
          title: reportName,
        ),
      ),
    );
  }
}

class SampleReport extends StatefulWidget {
  final AppBar appBar;
  final String title;
  SampleReport({Key key, this.appBar, this.title}) : super(key: key);

  @override
  _SampleReportState createState() => _SampleReportState();
}

class _SampleReportState extends State<SampleReport> {
  final _scrollController = ScrollController();
  final _scrollThreshold = 200.0;
  VoucherlistCubit _voucherList;
  DateTime dateFrom;
  DateTime dateTo;
  bool dateChanged = false;

  @override
  void initState() {
    super.initState();
    dateFrom = DateTime.now();
    dateTo = DateTime.now();
    dateChanged = false;
    // link = 'resto/sales_order_webservice.php?action=getvoucherlistbydate';
    _scrollController.addListener(_onScroll);
    _voucherList = BlocProvider.of<VoucherlistCubit>(context)
      ..fetchVoucherList(
        dateFrom: dateFrom,
        dateTo: dateTo,
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

  void refreshList() {
    setState(() {
      dateChanged = true;
    });

    _voucherList.fetchVoucherList(
      dateFrom: dateFrom,
      dateTo: dateTo,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: widget.appBar,
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
          return Container(child: Text('Fetching'));
        } else if (state is VoucherListEmpty) {
          return Container(child: Center(child: Text('Empty Here!!!')));
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
    return Expanded(
        child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: JsonTable(data),
    ));
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
}
