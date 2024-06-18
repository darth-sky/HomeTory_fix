import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:hometory/dto/barang_dlm_container.dart';
import 'package:hometory/services/data_services.dart';
import 'package:meta/meta.dart';

part 'barang_dlm_container_state.dart';

class BarangDlmContainerCubit extends Cubit<BarangDlmContainerState> {
  BarangDlmContainerCubit() : super(BarangDlmContainerInitial());

  Future<void> fetchBarangDlmContainerCubit(
      int page, String search, int? idContainer, int id_pengguna) async {
    try {
      debugPrint("nice job barang dalam container!!!");
      List<Barang_dlm_container>? tempBarangDlmContainer;
      List<Barang_dlm_container>? tempAllBarangDlmContainer;
      List<Barang_dlm_container>? tempAllBarangDlmContainerByUser;
      // List<Barang_dlm_container>? tempBarangDlmContainerByUser;
      tempBarangDlmContainer = await DataService.fetchBarangDlmContainer(
          page, search,
          idContainer: idContainer);
      tempAllBarangDlmContainer =
          await DataService.fetchAllBarangDlmContainer(page);
      tempAllBarangDlmContainerByUser =
          await DataService.fetchBarangDlmContainerByUser(
              page, search, id_pengguna);
      // tempBarangDlmContainerByUser =
      //     await DataService.fetchBarangDlmContainerbyUser();
      debugPrint("${tempBarangDlmContainer.length}");
      emit(BarangDlmContainerState(
        ListOfBarang_dlm_container: tempBarangDlmContainer,
        listAllBarangContainer: tempAllBarangDlmContainer,
        listOfBarang_dlm_container_byUser: tempAllBarangDlmContainerByUser,
        // listOfBarang_dlm_container_byUser: tempBarangDlmContainerByUser
      ));
    } catch (e) {
      debugPrint('eror barang dalam container');
      debugPrint('ini eror e:  ${e.toString()}');
    }
  }
}
