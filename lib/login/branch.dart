import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:authentication_with_bloc/authenticaiton/bloc/authentication_bloc.dart';
import 'package:authentication_with_bloc/Screens/Dashboard/DefaultDashboard.dart';
import 'package:authentication_with_bloc/login/branch/cubit/branch_cubit.dart';
import 'package:authentication_with_bloc/login/views/login_main_view.dart';
import 'package:authentication_with_bloc/main.dart';

class branchBloc extends StatelessWidget {
  final String uid;

  const branchBloc({Key key, this.uid}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    print('called branch bloc');
    return Container(
      child: BlocProvider<BranchCubit>(
        create: (context) =>
            BranchCubit()..chooseBranch(uid), //..chooseBranch('Wayanad', uid),
        child: DropDownDemo(uid: uid),
      ),
    );
  }
}

class DropDownDemo extends StatefulWidget {
  final String uid;

  DropDownDemo({Key key, this.uid}) : super(key: key);
  List<String> item = [
    "Pari",
    'Cake Cali',
    'Nasco',
    'Cafe_sul',
    'Majlis_ho',
    'Majlis_feroke'
  ];
  @override
  _DropDownDemoState createState() => _DropDownDemoState();
}

class _DropDownDemoState extends State<DropDownDemo> {
  String _chosenValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Branch'),
      ),
      body: getBlocBody(context),
    );
  }

  Container getNewBody() {
    Map data =
        (BlocProvider.of<BranchCubit>(context).state as BranchReady).branches;
    List branchData = data.entries
        .map((entry) =>
            BranchModel(branchName: entry.key, branchUrl: entry.value))
        .toList();

    print('mybranch $branchData');
    return Container(
      child: ListView(
        children: <Widget>[
          for (BranchModel items in branchData)
            Card(
              color: Colors.blue,
              key: ValueKey(items),
              elevation: 2,
              child: ListTile(
                onTap: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (BuildContext context) {
                    return DashBoardScreen(
                      url: items.branchUrl,
                    );
                  }));
                },
                title: Text(items.branchName),
                leading: Icon(
                  Icons.place,
                  color: Colors.black,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget getBlocBody(BuildContext ctx) {
    return Container(
      child: BlocConsumer<BranchCubit, BranchState>(
        listener: (context, state) {
          if (state is BranchError) {
            BlocProvider.of<AuthenticationBloc>(context).add(
              AuthenticationExited(),
            );
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('User not authenticated'),
              ),
            );
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (BuildContext context) {
              return LoginMainView();
            }));
          } else if (state is BranchReady) {
            // print('mystate url${state.baseURL}');
            // String url = state.baseURL;
            var data = (BlocProvider.of<AuthenticationBloc>(context).state
                    as AuthenticationSuccess)
                .authenticationDetail;
            print('auth data $data');
            // print('stat url${state.baseURL}');

            // Navigator.of(context)  // BlocProvider.of<AuthenticationBloc>(context).add(
            // //   AuthenticationStateChanged(
            // //       authenticationDetail: data,),
            // // );
            //     .push(MaterialPageRoute(builder: (BuildContext context) {
            //   return DashBoardScreen();
            // }));
          }
        },
        // TODO: implement listener

        builder: (context, state) {
          if (state is BranchInitial) {
            return Center(child: getNewBody());
          } else if (state is BranchReady) {
            return getNewBody();

            // return DashBoardScreen();
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(builder: (context) => DashBoardScreen()),
            // );
          } else if (state is Branchrefresh)
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(child: CircularProgressIndicator()),
                Text('Loading Branches'),
              ],
            );
          else {
            return Container(
              child: Text('invalid state'),
            );
            // BlocProvider.of<AuthenticationBloc>(context).add(
            //   AuthenticationExited(),
            // );
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(builder: (context) => LoginMainView()),
            // );
            // // Navigator.pop(context);
            // return MyApp
            //main();
          }
        },
      ),
    );
  }
}

class BranchModel {
  String branchName;
  String branchUrl;
  BranchModel({
    this.branchName,
    this.branchUrl,
  });
}
