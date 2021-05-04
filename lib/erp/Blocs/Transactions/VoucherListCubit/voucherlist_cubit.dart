import 'package:bloc/bloc.dart';
import 'package:authentication_with_bloc/erp/Webservice/webservice.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'voucherlist_state.dart';

class VoucherlistCubit extends Cubit<VoucherlistState> {
  VoucherlistCubit({@required this.web, @required this.voucherListLink})
      : super(VoucherlistInitial());
  final WebServiceHelper web;
  final String voucherListLink;

  void fetchVoucherList({
    DateTime dateFrom,
    DateTime dateTo,
    int offset,
    int limit = 50,
  }) async {
    emit(VoucherlistFetching());

    try {
      final data = await web.getVoucherList(
        dateFrom: dateFrom,
        dateTo: dateTo,
        offset: offset,
        limit: 1000,
        link: voucherListLink,
      );
      if (data != null) {
        if (data.length > 0) emit(VoucherListReady(data: data));
      } else
        emit(VoucherListEmpty());
    } catch (E) {
      print('Error : ${E.toString()}');
    }
  }
}
