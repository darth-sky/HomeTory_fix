import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:hometory/dto/barang_dlm_container.dart';
import 'package:hometory/services/data_services.dart';
import 'package:meta/meta.dart';

part 'barang_dlm_container_state.dart';

class BarangDlmContainerCubit extends Cubit<BarangDlmContainerState> {
  BarangDlmContainerCubit() : super(BarangDlmContainerInitial());

  Future<void> fetchBarangDlmContainerCubit() async {
    try {
      debugPrint("nice job barang dalam container!!!");
      List<Barang_dlm_container>? tempBarangDlmContainer;
      // List<Barang_dlm_container>? tempBarangDlmContainerByUser;
      tempBarangDlmContainer = await DataService.fetchBarangDlmContainer();
      // tempBarangDlmContainerByUser =
      //     await DataService.fetchBarangDlmContainerbyUser();
      debugPrint("${tempBarangDlmContainer.length}");
      emit(BarangDlmContainerState(
          ListOfBarang_dlm_container: tempBarangDlmContainer,
          // listOfBarang_dlm_container_byUser: tempBarangDlmContainerByUser
          ));
    } catch (e) {
      debugPrint('eror barang dalam container');
    }
  }
}
