import 'dart:async';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../models/excahngeModel.dart';
import '../models/symoblesModel.dart';
import '../repositories/dioHelper.dart';
import 'appState.dart';
import 'appevent.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc() : super(InitialState()) {
    on<GetSymoblesEvent>(_getSymoblesEvent);
    on<GetRetasEvent>(_getRatesEvent, transformer: droppable());
    on<ChangeEndData>(_changeEndData);
    on<ChangeStartData>(_changeStartData);
    on<ChangeBaseCode>(_changeBaseCode);
    on<ChangeToCode>(_changeToCode);
  }

  // // some fields need in app to pass some data
  List<SymoblesModel> symbols = [];
  List<String> codes = [""];
  List<ExchangeModel> rates = [];
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();
  String baseCode = "";
  String toCode = "";

  static get(BuildContext context) => BlocProvider.of<AppBloc>(context);

  FutureOr<void> _getSymoblesEvent(
      GetSymoblesEvent event, Emitter<AppState> emit) async {
    emit(LoadingSymobles());
    symbols = [];
    var value = await DioHelper.getSymobles(url: "symbols");

    var ourmap = value.data['symbols'];
    ourmap.keys.forEach(
      (k) {
        symbols.add(SymoblesModel.fromJson(ourmap[k]));
      },
    );
    codes = [];
    for (var x in symbols) {
      codes.add(x.code);
    }

    baseCode = symbols[0].code;
    toCode = symbols[0].code;

    emit(GetSymobles());
  }

  FutureOr<void> _getRatesEvent(
      GetRetasEvent event, Emitter<AppState> emit) async {
    getNext10Day();
    emit(LoadingGetExcahngeData());
    if (event.firstTime) {
      rates = [];
    }
    var value = await DioHelper.postRateRequest(url: "timeseries", values: {
      "start_date": DateFormat("yyyy-MM-dd").format(first!),
      "end_date": DateFormat("yyyy-MM-dd").format(second!),
      "base": baseCode,
      "symbols": toCode,
    });

    debugPrint(value.data['rates'].toString());

    var ourmap = value.data['rates'];
    ourmap.keys.forEach((k) {
      rates.add(ExchangeModel.fromJson(ourmap[k][toCode], k));
    });
    emit(SuccssGetExcahngeData());
  }
  DateTime? first;
  DateTime? second;
  void getNext10Day() {
    first = startDate;
    second = first!.add(const Duration(days: 10));

    if (second!.compareTo(endDate) == 1) {
      second = endDate;
    }
    startDate = second!.add(const Duration(days: 1));
  }

  FutureOr<void> _changeEndData(ChangeEndData event, Emitter<AppState> emit) {
    emit(LoadingChageDate());
    endDate = event.newTime!;
    emit(SuccssChangeDate());
  }

  FutureOr<void> _changeStartData(
      ChangeStartData event, Emitter<AppState> emit) {
    emit(LoadingChageDate());
    startDate = event.newTime!;
    emit(SuccssChangeDate());
  }

  FutureOr<void> _changeBaseCode(ChangeBaseCode event, Emitter<AppState> emit) {
    emit(LoadingChageCode());
    baseCode = event.newCode!;
    emit(SuccssChangeCode());
  }

  FutureOr<void> _changeToCode(ChangeToCode event, Emitter<AppState> emit) {
    emit(LoadingChageCode());
    toCode = event.newCode!;
    emit(SuccssChangeCode());
  }
}
