import 'package:auto_size_text/auto_size_text.dart';

import 'package:authentication_with_bloc/erp/Blocs/Reports/Inventory/ReportsCommon/reportscommon_cubit.dart';
import 'package:authentication_with_bloc/erp/Webservice/webservice.dart';
import 'package:authentication_with_bloc/erp/Widgets/Drawer/GDrawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class ClosingStockReportScreen extends StatefulWidget {
  ClosingStockReportScreen(
      {Key key, @required this.link, @required this.reportTitle})
      : super(key: key);

  final String link;
  final String reportTitle;

  @override
  _ClosingStockReportScreenState createState() =>
      _ClosingStockReportScreenState();
}

class _ClosingStockReportScreenState extends State<ClosingStockReportScreen> {
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
      title: Text(widget.reportTitle),
    );

    return GDrawer(
      child: BlocProvider(
        create: (context) => ReportscommonCubit(web: WebServiceHelper()),
        child: ClosingStockReport(
          appBar: appBar,
          link: widget.link,
        ),
      ),
    );
  }
}

class ClosingStockReport extends StatefulWidget {
  ClosingStockReport({Key key, this.appBar, this.link}) : super(key: key);
  final AppBar appBar;
  final String link;
  @override
  _ClosingStockReportState createState() => _ClosingStockReportState();
}

class _ClosingStockReportState extends State<ClosingStockReport> {
  final _scrollController = ScrollController();
  final _scrollThreshold = 200.0;

  ReportscommonCubit reportsCubit;

  DateTime dateFrom;
  DateTime dateTo;
  bool dateChanged = false;
  @override
  void initState() {
    super.initState();
    dateFrom = DateTime.now();
    dateTo = DateTime.now();
    dateChanged = false;
    _scrollController.addListener(_onScroll);
    reportsCubit = BlocProvider.of<ReportscommonCubit>(context)
      ..fetchReportsData(
        dateFrom: DateTime.now().subtract(
          const Duration(days: 30),
        ),
        dateTo: DateTime.now(),
      );
  }

  void requestData() {
    reportsCubit.fetchReportsData(dateFrom: dateFrom, dateTo: dateTo);
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;

    // print('maxScroll : $maxScroll');
    // print('current : $currentScroll');
    if (maxScroll - currentScroll <= _scrollThreshold) {
      print('Load More...');
      // reportsCubit.fetchReportsData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.appBar,
      body: Column(
        children: [
          getFilter(),
          Expanded(child: getBlocBody()),
        ],
      ),
    );
  }

  BlocConsumer<ReportscommonCubit, ReportscommonState> getBlocBody() {
    return BlocConsumer<ReportscommonCubit, ReportscommonState>(
      builder: (context, state) {
        if (state is ReportListReady) {
          return getBody(state.data);
        } else if (state is ReportlistFetching) {
          return Container(
            child: Center(
              child: Text('Reading...'),
            ),
          );
        } else if (state is ReportListFetchError) {
          return Container(
            child: Center(
              child: Text('Can\'t fetch Data!!!'),
            ),
          );
        } else if (state is ReportListEmpty) {
          return Container(
            child: Center(
              child: Text('List is Empty'),
            ),
          );
        } else {
          return Container();
        }
      },
      listener: (context, state) {},
    );
  }

  Widget getBody(List data) {
    return Container(
      child: Column(
        children: [Expanded(flex: 20, child: getList(data))],
      ),
    );
  }

  Widget getList(List data) {
    print('Data[0] is ${data[0]}');
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.builder(
        itemBuilder: (context, index) {
          return getListCard(data, index);
        },
        itemCount: data.length,
      ),
    );
  }

  Card getListCard(List data, int index) {
    print('Item Name : ${data[index]['Item']}');
    return Card(
      child: ListTile(
        title: Text('${data[index]['Item']}'),
        subtitle: Row(
          children: [
            Expanded(
              child: Text(
                'Op : ${double.parse(data[index]['Opening'] ?? "0").toStringAsFixed(2)}',
                style: TextStyle(
                    fontSize: 12,
                    color: double.parse(data[index]['Opening'] ?? '0') >= 0
                        ? Colors.grey
                        : Colors.red),
              ),
            ),
            Expanded(
              child: Text(
                  'In : ${double.parse(data[index]['Inward'] ?? '0').toStringAsFixed(2)}',
                  style: TextStyle(
                    fontSize: 12,
                  )),
            ),
            Expanded(
              child: Text(
                  'Out : ${double.parse(data[index]['Issued'] ?? '0').toStringAsFixed(2)}',
                  style: TextStyle(
                    fontSize: 12,
                  )),
            ),
          ],
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.all(1.0),
              child: Text(
                double.parse(data[index]['Closing Stock'] ?? '0')
                    .toStringAsFixed(2),
                style: TextStyle(
                    fontSize: 16,
                    color: double.parse(data[index]['Closing Stock'] ?? '0') < 0
                        ? Colors.red
                        : Colors.black),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(1.0),
              child: Text(
                "\u20B9" +
                    double.parse(data[index]['Stock Value'] ?? '0')
                        .toStringAsFixed(2),
                style: TextStyle(
                    fontSize: 16,
                    color: double.parse(data[index]['Stock Value'] ?? '0') < 0
                        ? Colors.red
                        : Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getFilter() {
    final DateFormat formatter = DateFormat('dd-MM-yy');

    print('Date is $dateFrom');
    String dateF = formatter.format(dateFrom);
    String datet = formatter.format(dateTo);

    // return Container();

    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Column(
        children: [
          Container(
            // color: Colors.grey.shade300,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                getCalenderIcon(),
                Padding(
                  padding: EdgeInsets.fromLTRB(3, 0, 3, 0),
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
                ),
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
      ),
    );
  }

  void refreshList() {
    setState(() {
      dateChanged = true;
    });
    requestData();
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
}
