import 'package:authentication_with_bloc/login/views/login_main_view.dart';
import 'package:authentication_with_bloc/authenticaiton/bloc/authentication_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeMainView extends StatefulWidget {
  @override
  _HomeMainViewState createState() => _HomeMainViewState();
}

class _HomeMainViewState extends State<HomeMainView> {
  String messageTitle = "Empty";
  String notificationAlert = "alert";

  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  @override
  void initState() {
    // TODO: implement initState
    _firebaseMessaging.configure(
      onMessage: (message) async {
        setState(() {
          messageTitle = message["notification"]["title"];
          notificationAlert = "New Notification Alert";
        });
      },
      onResume: (message) async {
        setState(() {
          messageTitle = message["data"]["title"];
          notificationAlert = "Application opened from Notification";
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final CollectionReference userCollection =
        FirebaseFirestore.instance.collection('user');
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Logout'),
          actions: [
            IconButton(
              icon: Icon(
                Icons.exit_to_app,
              ),
              onPressed: () {
                BlocProvider.of<AuthenticationBloc>(context).add(
                  AuthenticationExited(),
                );
                // Navigator.pushReplacement(
                //                   context,
                //                   MaterialPageRoute(
                //                       builder: (context) =>LoginMainView()));
              },
            ),
          ],
        ),
        body: Center(
          child: BlocConsumer<AuthenticationBloc, AuthenticationState>(
            listener: (context, state) {
              if (state is AuthenticationFailiure) {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (_) => LoginMainView()));
              }
              if (state is AuthenticationSuccess) {
                print('Auth Set');
                var result = userCollection
                    .doc(state.authenticationDetail.uid)
                    .set({'u_id': state.authenticationDetail.uid});
              }
            },
            builder: (context, state) {
              if (state is AuthenticationInitial) {
                BlocProvider.of<AuthenticationBloc>(context)
                    .add(AuthenticationStarted());
                return CircularProgressIndicator();
              } else if (state is AuthenticationLoading) {
                return CircularProgressIndicator();
              } else if (state is AuthenticationSuccess) {
                print('inside');

                return Container(
                  child: FloatingActionButton(
                    child: Text(notificationAlert),
                    onPressed: () async {},
                  ),
                );
                // return Text('Welcome :${state.authenticationDetail.uid}');
              }
              return Text('Undefined state : ${state.runtimeType}');
            },
          ),
        ),
      ),
    );
  }
}
