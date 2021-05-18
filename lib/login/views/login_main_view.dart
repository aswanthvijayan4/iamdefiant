import 'dart:math';

import 'package:authentication_with_bloc/authenticaiton/bloc/authentication_bloc.dart';
import 'package:authentication_with_bloc/Screens/Dashboard/DefaultDashboard.dart';
import 'package:authentication_with_bloc/login/bloc/cubit/user_login_cubit.dart';
import 'package:authentication_with_bloc/login/branch.dart';

import 'package:authentication_with_bloc/login/constants.dart';

// import 'package:authentication_with_bloc/home/views/home_main_view.dart';
// import 'package:authentication_with_bloc/phone_auth/bloc/phone_auth_bloc.dart';
// import 'package:authentication_with_bloc/phone_auth/data/provider/phone_auth_firebase_provider.dart';
// import 'package:authentication_with_bloc/phone_auth/data/repositories/phone_auth_repository.dart';
// import 'package:authentication_with_bloc/phone_auth/views/login_phone_number_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter/services.dart';

//rework

class LoginMainView extends StatefulWidget {
  @override
  _LoginMainViewState createState() => _LoginMainViewState();
}

class _LoginMainViewState extends State<LoginMainView> {
  String _chosenValue;
  String email;
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('user');
  @override
  Widget _buildEmailTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Email',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            onChanged: (value) {
              setState(() {
                email = value;
              });
            },
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.email,
                color: Colors.white,
              ),
              hintText: 'Enter your Email',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPasswordTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Password',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            obscureText: true,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.lock,
                color: Colors.white,
              ),
              hintText: 'Enter your Password',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLoginBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: () {
          BlocProvider.of<AuthenticationBloc>(context).add(
            AuthenticationGoogleStarted(),
          );

          // Navigator.push(
          //   context,
          //   MaterialPageRoute(builder: (context) => DashBoardScreen()),
          // );
        },
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: Colors.white,
        child: Text(
          'Google LOGIN',
          style: TextStyle(
            color: Colors.grey,
            letterSpacing: 1.5,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
      ),
    );
  }

  Widget _buildEmailPasswordBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: () async {
          if (email != '') {
            QuerySnapshot variable2 = await FirebaseFirestore.instance
                .collection('user')
                .where('email', isEqualTo: email)
                .get();

            var data = variable2.docs.first.data()['branch'];
            //var group = variable2.docs.first.data()['user_group'];
            print('branch is $data');
            //print('group is $group');
          }
          // BlocProvider.of<AuthenticationBloc>(context).add(
          // //   AuthenticationGoogleStarted(),
          // );

          // Navigator.push(
          //   context,
          //   MaterialPageRoute(builder: (context) => DashBoardScreen()),
          // );
        },
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: Colors.white,
        child: Text(
          'LOGIN',
          style: TextStyle(
            color: Colors.grey,
            letterSpacing: 1.5,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
      ),
    );
  }

  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.blue,
        appBar: AppBar(
          title: Text('Login'),
        ),
        body: Builder(
          builder: (context) {
            return BlocConsumer<AuthenticationBloc, AuthenticationState>(
              listener: (context, state) {
                if (state is AuthenticationSuccess) {
                  print('auth success');
                  var result = userCollection
                      .doc(state.authenticationDetail.uid)
                      .update({'u_id': state.authenticationDetail.uid});

                  // Container(
                  //   child: BlocProvider<UserLoginCubit>(
                  //     lazy: true,
                  //     create: (context) => UserLoginCubit()..fetchUserLogin(),
                  //     child: DashBoardScreen(),
                  //   ),
                  // );

                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              branchBloc(uid: state.authenticationDetail.uid)));
                } else if (state is AuthenticationFailiure) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.message),
                    ),
                  );
                }
              },
              buildWhen: (current, next) {
                if (next is AuthenticationSuccess) {
                  return false;
                }
                return true;
              },
              builder: (context, state) {
                // if (state is AuthenticationSuccess) {
                //   return branchBloc(
                //     uid: state.authenticationDetail.uid,
                //   );
                // } else
                if (state is AuthenticationInitial ||
                    state is AuthenticationFailiure) {
                  return Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          _buildEmailTF(),
                          _buildPasswordTF(),

                          _buildEmailPasswordBtn(),
                          _buildLoginBtn(),

                          // OutlinedButton(
                          //   onPressed: () =>
                          //       BlocProvider.of<AuthenticationBloc>(context)
                          //           .add(
                          //     AuthenticationGoogleStarted(),
                          //   ),
                          //   child: Text('Login with Google'),
                          // ),
                          // OutlinedButton(
                          //   onPressed: () {
                          //     Navigator.pushReplacement(
                          //       context,
                          //       MaterialPageRoute(
                          //           builder: (context) => BlocProvider(
                          //                 create: (context) => PhoneAuthBloc(
                          //                   phoneAuthRepository:
                          //                       PhoneAuthRepository(
                          //                     phoneAuthFirebaseProvider:
                          //                         PhoneAuthFirebaseProvider(
                          //                             firebaseAuth: FirebaseAuth
                          //                                 .instance),
                          //                   ),
                          //                 ),
                          //                 child: LoginPhoneNumberView(),
                          //               )),
                          //     );
                          //   },
                          //   child: Text('Login with Phone Number'),
                          // ),
                        ],
                      ),
                    ),
                  );
                } else if (state is AuthenticationLoading) {
                  return Center(child: CircularProgressIndicator());
                }
                return Center(
                    child: Text('Undefined state : ${state.runtimeType}'));
              },
            );
          },
        ),
      ),
    );
  }
}
