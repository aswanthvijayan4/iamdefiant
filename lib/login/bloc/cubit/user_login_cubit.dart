import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'user_login_state.dart';

class UserLoginCubit extends Cubit<UserLoginState> {
  UserLoginCubit() : super(UserLoginInitial());

  void fetchUserLogin() async {
    // emit(UserLoginFetching());

    try {
      final CollectionReference userCollection =
          FirebaseFirestore.instance.collection('user');
      print('auth success');
      // var result = userCollection
      //     .doc(state.authenticationDetail.uid)
      //     .set({'u_id': state.authenticationDetail.uid});
      // var data = [];
      // if (data != null) {
      //   if (data.length > 0) emit(UserLoginReady(data: data));
      // } else

      //   emit(UserLoginEmpty());
    } catch (E) {
      print('Error : ${E.toString()}');
      // emit(UserLoginFetchError());
    }
  }
}
