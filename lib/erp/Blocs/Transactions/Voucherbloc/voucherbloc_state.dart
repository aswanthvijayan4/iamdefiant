part of 'voucherbloc_bloc.dart';

abstract class VoucherblocState extends Equatable {
  const VoucherblocState();
  @override
  List<Object> get props => [];
}

class VoucherblocInitial extends VoucherblocState {}

class VoucherReady extends VoucherblocBloc {
  final GeneralVoucherDataModel voucher;
  VoucherReady(this.voucher);
}

class VoucherSaving extends VoucherblocState {}
