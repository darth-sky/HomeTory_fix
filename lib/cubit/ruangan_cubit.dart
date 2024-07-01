// import 'dart:ffi';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:hometory/dto/ruangan.dart';
import 'package:hometory/services/data_services.dart';

part 'ruangan_state.dart';

class RuanganCubit extends Cubit<RuanganState> {
  RuanganCubit() : super(RuanganInitial());

  Future<void> fetchRuanganCubit(String accessToken) async {
    try {
      debugPrint("nice job!!!");
      List<Ruangan>? tempRuangan;
      tempRuangan = await DataService.fetchRuangan(accessToken);
      debugPrint("${tempRuangan.length}");
      emit(RuanganState(listOfRuangan: tempRuangan));
    } catch (e) {
      debugPrint('eror catching data ruangan');
    }
  }
}
