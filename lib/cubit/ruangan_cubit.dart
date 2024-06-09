// import 'dart:ffi';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:hometory/dto/ruangan.dart';
import 'package:hometory/services/data_services.dart';
import 'package:meta/meta.dart';

part 'ruangan_state.dart';

class RuanganCubit extends Cubit<RuanganState> {
  RuanganCubit() : super(RuanganInitial());

  Future<void> fetchRuanganCubit() async {
    try {
      debugPrint("nice job!!!");
      List<Ruangan>? tempRuangan;
      tempRuangan = await DataService.fetchRuangan();
      debugPrint("${tempRuangan.length}");
      emit(RuanganState(ListOfRuangan: tempRuangan));
    } catch (e) {
      debugPrint('eror catching data ruangan');
    }
  }
}
