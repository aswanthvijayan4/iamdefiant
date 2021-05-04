part of 'vouchercubit_cubit.dart';

abstract class VouchercubitState {
  const VouchercubitState();
}

class VouchercubitInitial extends VouchercubitState {}

class VoucherReady extends VouchercubitState {
  final GeneralVoucherDataModel voucher;
  VoucherReady({this.voucher});
}

class VoucherRefreshing extends VouchercubitState {}

class VoucherSaving extends VouchercubitState {}

class VoucherFetching extends VouchercubitState {}

class VoucherSaved extends VouchercubitState {}

class VoucherSaveError extends VouchercubitState {
  final String error;

  VoucherSaveError({this.error});
}
