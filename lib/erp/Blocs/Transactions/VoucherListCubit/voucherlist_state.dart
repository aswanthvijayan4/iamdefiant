part of 'voucherlist_cubit.dart';

abstract class VoucherlistState extends Equatable {
  const VoucherlistState();

  @override
  List<Object> get props => [];
}

class VoucherlistInitial extends VoucherlistState {}

class VoucherlistFetching extends VoucherlistState {}

class VoucherListReady extends VoucherlistState {
  final List data;
  VoucherListReady({this.data});
}

class VoucherListFetchError extends VoucherlistState {}

class VoucherListEmpty extends VoucherlistState {}

class VoucherListRefreshing extends VoucherlistState {}
