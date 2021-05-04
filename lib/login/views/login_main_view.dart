import 'dart:math';

import 'package:authentication_with_bloc/authenticaiton/bloc/authentication_bloc.dart';
import 'package:authentication_with_bloc/erp/Screens/Dashboard/DefaultDashboard.dart';
import 'package:authentication_with_bloc/login/bloc/cubit/user_login_cubit.dart';

import 'package:authentication_with_bloc/login/constants.dart';

import 'package:authentication_with_bloc/home/views/home_main_view.dart';
import 'package:authentication_with_bloc/phone_auth/bloc/phone_auth_bloc.dart';
import 'package:authentication_with_bloc/phone_auth/data/provider/phone_auth_firebase_provider.dart';
import 'package:authentication_with_bloc/phone_auth/data/repositories/phone_auth_repository.dart';
import 'package:authentication_with_bloc/phone_auth/views/login_phone_number_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter/services.dart';

// class LoginScreen extends StatefulWidget {
//   @override
//   _LoginScreenState createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen> {
//   bool _rememberMe = false;

//   Widget _buildEmailTF() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: <Widget>[
//         Text(
//           'Email',
//           style: kLabelStyle,
//         ),
//         SizedBox(height: 10.0),
//         Container(
//           alignment: Alignment.centerLeft,
//           decoration: kBoxDecorationStyle,
//           height: 60.0,
//           child: TextField(
//             keyboardType: TextInputType.emailAddress,
//             style: TextStyle(
//               color: Colors.white,
//               fontFamily: 'OpenSans',
//             ),
//             decoration: InputDecoration(
//               border: InputBorder.none,
//               contentPadding: EdgeInsets.only(top: 14.0),
//               prefixIcon: Icon(
//                 Icons.email,
//                 color: Colors.white,
//               ),
//               hintText: 'Enter your Email',
//               hintStyle: kHintTextStyle,
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildPasswordTF() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: <Widget>[
//         Text(
//           'Password',
//           style: kLabelStyle,
//         ),
//         SizedBox(height: 10.0),
//         Container(
//           alignment: Alignment.centerLeft,
//           decoration: kBoxDecorationStyle,
//           height: 60.0,
//           child: TextField(
//             obscureText: true,
//             style: TextStyle(
//               color: Colors.white,
//               fontFamily: 'OpenSans',
//             ),
//             decoration: InputDecoration(
//               border: InputBorder.none,
//               contentPadding: EdgeInsets.only(top: 14.0),
//               prefixIcon: Icon(
//                 Icons.lock,
//                 color: Colors.white,
//               ),
//               hintText: 'Enter your Password',
//               hintStyle: kHintTextStyle,
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildForgotPasswordBtn() {
//     return Container(
//       alignment: Alignment.centerRight,
//       child: FlatButton(
//         onPressed: () => print('Forgot Password Button Pressed'),
//         padding: EdgeInsets.only(right: 0.0),
//         child: Text(
//           'Forgot Password?',
//           style: kLabelStyle,
//         ),
//       ),
//     );
//   }

//   Widget _buildRememberMeCheckbox() {
//     return Container(
//       height: 20.0,
//       child: Row(
//         children: <Widget>[
//           Theme(
//             data: ThemeData(unselectedWidgetColor: Colors.white),
//             child: Checkbox(
//               value: _rememberMe,
//               checkColor: Colors.green,
//               activeColor: Colors.white,
//               onChanged: (value) {
//                 setState(() {
//                   _rememberMe = value;
//                 });
//               },
//             ),
//           ),
//           Text(
//             'Remember me',
//             style: kLabelStyle,
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildLoginBtn() {
//     return Container(
//       padding: EdgeInsets.symmetric(vertical: 25.0),
//       width: double.infinity,
//       child: RaisedButton(
//         elevation: 5.0,
//         onPressed: () {
//           Navigator.push(
//             context,
//             MaterialPageRoute(builder: (context) => DashBoardScreen()),
//           );
//         },
//         padding: EdgeInsets.all(15.0),
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(30.0),
//         ),
//         color: Colors.white,
//         child: Text(
//           'LOGIN',
//           style: TextStyle(
//             color: Colors.grey,
//             letterSpacing: 1.5,
//             fontSize: 18.0,
//             fontWeight: FontWeight.bold,
//             fontFamily: 'OpenSans',
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildSocialBtn(Function onTap, AssetImage logo) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         height: 60.0,
//         width: 60.0,
//         decoration: BoxDecoration(
//           shape: BoxShape.circle,
//           color: Colors.white,
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black26,
//               offset: Offset(0, 2),
//               blurRadius: 6.0,
//             ),
//           ],
//           image: DecorationImage(
//             image: logo,
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildSocialBtnRow() {
//     return Padding(
//         padding: EdgeInsets.symmetric(vertical: 30.0), child: Container());
//   }

//   Widget _buildSignupBtn() {
//     return GestureDetector(
//       onTap: () {
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (context) => LoginScreen()),
//         );
//       },
//       child: RichText(
//         text: TextSpan(
//           children: [

//           ],
//         ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: AnnotatedRegion<SystemUiOverlayStyle>(
//         value: SystemUiOverlayStyle.light,
//         child: GestureDetector(
//           onTap: () => FocusScope.of(context).unfocus(),
//           child: Stack(
//             children: <Widget>[
//               Container(
//                 height: double.infinity,
//                 width: double.infinity,
//                 decoration: BoxDecoration(
//                   gradient: LinearGradient(
//                     begin: Alignment.topCenter,
//                     end: Alignment.bottomCenter,
//                     colors: [
//                       Color(0xFF5CAF60),
//                       Color(0xFF4CAF50),
//                       Color(0xFF4CAF50),
//                       Color(0xFF4CAF50),
//                     ],
//                     stops: [0.1, 0.4, 0.7, 0.9],
//                   ),
//                 ),
//               ),
//               Container(
//                 height: double.infinity,
//                 child: SingleChildScrollView(
//                   physics: AlwaysScrollableScrollPhysics(),
//                   padding: EdgeInsets.symmetric(
//                     horizontal: 40.0,
//                     vertical: 120.0,
//                   ),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: <Widget>[
//                       Text(
//                         'Sign In',
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontFamily: 'OpenSans',
//                           fontSize: 30.0,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       SizedBox(height: 30.0),
//                       _buildEmailTF(),
//                       SizedBox(
//                         height: 30.0,
//                       ),
//                       _buildPasswordTF(),
//                       // _buildForgotPasswordBtn(),
//                       // _buildRememberMeCheckbox(),
//                       _buildLoginBtn(),
//                       //_buildSignInWithText(),
//                       _buildSocialBtnRow(),
//                       _buildSignupBtn(),
//                     ],
//                   ),
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

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
                      .set({'u_id': state.authenticationDetail.uid});

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
                          builder: (context) => DashBoardScreen()));
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

// import 'package:authentication_with_bloc/authenticaiton/bloc/authentication_bloc.dart';
// import 'package:authentication_with_bloc/erp/Screens/Dashboard/DefaultDashboard.dart';

// import 'package:authentication_with_bloc/home/views/home_main_view.dart';
// import 'package:authentication_with_bloc/phone_auth/bloc/phone_auth_bloc.dart';
// import 'package:authentication_with_bloc/phone_auth/data/provider/phone_auth_firebase_provider.dart';
// import 'package:authentication_with_bloc/phone_auth/data/repositories/phone_auth_repository.dart';
// import 'package:authentication_with_bloc/phone_auth/views/login_phone_number_view.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class LoginMainView extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         appBar: AppBar(
//           title: Text('Login'),
//         ),
//         body: Builder(
//           builder: (context) {
//             return BlocConsumer<AuthenticationBloc, AuthenticationState>(
//               listener: (context, state) {
//                 if (state is AuthenticationSuccess) {
//                   Navigator.pushReplacement(context,
//                       MaterialPageRoute(builder: (context) => DashBoardScreen()));
//                 } else if (state is AuthenticationFailiure) {
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     SnackBar(
//                       content: Text(state.message),
//                     ),
//                   );
//                 }
//               },
//               buildWhen: (current, next) {
//                 if (next is AuthenticationSuccess) {
//                   return false;
//                 }
//                 return true;
//               },
//               builder: (context, state) {
//                 if (state is AuthenticationInitial ||
//                     state is AuthenticationFailiure) {
//                   return Center(
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         OutlinedButton(
//                           onPressed: () =>
//                               BlocProvider.of<AuthenticationBloc>(context).add(
//                             AuthenticationGoogleStarted(),
//                           ),
//                           child: Text('Login with Google'),
//                         ),
//                         OutlinedButton(
//                           onPressed: () {
//                             Navigator.pushReplacement(
//                               context,
//                               MaterialPageRoute(
//                                   builder: (context) => BlocProvider(
//                                         create: (context) => PhoneAuthBloc(
//                                           phoneAuthRepository:
//                                               PhoneAuthRepository(
//                                             phoneAuthFirebaseProvider:
//                                                 PhoneAuthFirebaseProvider(
//                                                     firebaseAuth:
//                                                         FirebaseAuth.instance),
//                                           ),
//                                         ),
//                                         child: LoginPhoneNumberView(),
//                                       )),
//                             );
//                           },
//                           child: Text('Login with Phone Number'),
//                         ),
//                       ],
//                     ),
//                   );
//                 } else if (state is AuthenticationLoading) {
//                   return Center(child: CircularProgressIndicator());
//                 }
//                 return Center(
//                     child: Text('Undefined state : ${state.runtimeType}'));
//               },
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
