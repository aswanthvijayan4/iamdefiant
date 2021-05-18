import 'package:authentication_with_bloc/authenticaiton/bloc/authentication_bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'branch_state.dart';

class BranchCubit extends Cubit<BranchState> {
  BranchCubit() : super(BranchInitial());
  void chooseBranch(String uid) async {
    emit(Branchrefresh());
    // print('selected branch $branch');
    // var data = (state as UserLoginReady).data;

    final firestore = FirebaseFirestore.instance;
    DocumentSnapshot documentSnapshot;
    try {
      documentSnapshot = await firestore.collection('user').doc(uid).get();
      print('branches ${documentSnapshot.data()['brach'][0]}');
      emit(BranchReady(branches: documentSnapshot.data()['brach'][0]));
    } catch (e) {
      print(e);
      emit(BranchError());
    }
  }
}
