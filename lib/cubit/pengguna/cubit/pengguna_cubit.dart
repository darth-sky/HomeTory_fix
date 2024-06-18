import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:hometory/dto/pengguna.dart';
import 'package:hometory/services/data_services.dart';
import 'package:meta/meta.dart';

part 'pengguna_state.dart';

class PenggunaCubit extends Cubit<PenggunaState> {
  PenggunaCubit() : super(PenggunaInitial());

  Future<void> fetchPenggunaCubit() async {
    try {
      debugPrint("berhasil list pengguna");
      List<Pengguna>? tempPengguna;
      tempPengguna = await DataService.fetchUser();
      emit(PenggunaState(listOfPengguna: tempPengguna));
    } catch (e) {
      debugPrint("eror catching data pengguna");
    }
  }
}
