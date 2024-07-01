import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:hometory/dto/barang_dlm_ruangan.dart';
import 'package:hometory/services/data_services.dart';

part 'barang_dlm_ruangan_state.dart';

class BarangDlmRuanganCubit extends Cubit<BarangDlmRuanganState> {
  BarangDlmRuanganCubit() : super(BarangDlmRuanganInitial());

  Future<void> fetchBarangDlmRuanganCubit(
      int page, String search, int? idRuangan, int idPengguna) async {
    try {
      debugPrint("nice job ruangan!!!");
      List<BarangDlmRuangan>? tempBarangDlmRuangan;
      List<BarangDlmRuangan>? tempAllBarangDlmRuangan;
      List<BarangDlmRuangan>? tempAllBarangDlmRuanganByUser;
      tempBarangDlmRuangan = await DataService.fetchBarangDlmRuangan(
          page, search,
          idRuangan: idRuangan);
      tempAllBarangDlmRuangan =
          await DataService.fetchAllBarangDlmRuangan(page);
      tempAllBarangDlmRuanganByUser =
          await DataService.fetchBarangDlmRuanganByUser(page, search, idPengguna);
      debugPrint("${tempBarangDlmRuangan.length}");
      emit(BarangDlmRuanganState(
          listOfBarangDlmRuangan: tempBarangDlmRuangan,
          listAllBarang: tempAllBarangDlmRuangan,
          listOfBarangDlmRuanganByUser: tempAllBarangDlmRuanganByUser));
    } catch (e) {
      debugPrint('eror barang ruangan');
    }
  }
}
