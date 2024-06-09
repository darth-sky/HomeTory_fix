import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:hometory/dto/barang_dlm_ruangan.dart';
import 'package:hometory/services/data_services.dart';
import 'package:meta/meta.dart';

part 'barang_dlm_ruangan_state.dart';

class BarangDlmRuanganCubit extends Cubit<BarangDlmRuanganState> {
  BarangDlmRuanganCubit() : super(BarangDlmRuanganInitial());

  Future<void> fetchBarangDlmRuanganCubit() async {
    try {
      debugPrint("nice job ruangan!!!");
      List<Barang_dlm_ruangan>? tempBarangDlmRuangan;
      tempBarangDlmRuangan = await DataService.fetchBarangDlmRuangan();
      debugPrint("${tempBarangDlmRuangan.length}");
      emit(BarangDlmRuanganState(
          ListOfBarang_dlm_ruangan: tempBarangDlmRuangan));
    } catch (e) {
      debugPrint('eror barang ruangan');
    }
  }
}
