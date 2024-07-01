import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:hometory/dto/barang_dlm_container.dart';
import 'package:hometory/services/data_services.dart';

part 'barang_dlm_container_state.dart';

class BarangDlmContainerCubit extends Cubit<BarangDlmContainerState> {
  BarangDlmContainerCubit() : super(BarangDlmContainerInitial());

  Future<void> fetchBarangDlmContainerCubit(
      int page, String search, int? idContainer, int idPengguna) async {
    try {
      debugPrint("nice job barang dalam container!!!");
      List<BarangDlmContainer>? tempBarangDlmContainer;
      List<BarangDlmContainer>? tempAllBarangDlmContainer;
      List<BarangDlmContainer>? tempAllBarangDlmContainerByUser;
      // List<Barang_dlm_container>? tempBarangDlmContainerByUser;
      tempBarangDlmContainer = await DataService.fetchBarangDlmContainer(
          page, search,
          idContainer: idContainer);
      tempAllBarangDlmContainer =
          await DataService.fetchAllBarangDlmContainer(page);
      tempAllBarangDlmContainerByUser =
          await DataService.fetchBarangDlmContainerByUser(
              page, search, idPengguna);
      // tempBarangDlmContainerByUser =
      //     await DataService.fetchBarangDlmContainerbyUser();
      debugPrint("${tempBarangDlmContainer.length}");
      emit(BarangDlmContainerState(
        listOfBarangDlmContainer: tempBarangDlmContainer,
        listAllBarangContainer: tempAllBarangDlmContainer,
        listOfBarangDlmContainerByUser: tempAllBarangDlmContainerByUser,
        // listOfBarang_dlm_container_byUser: tempBarangDlmContainerByUser
      ));
    } catch (e) {
      debugPrint('eror barang dalam container');
      debugPrint('ini eror e:  ${e.toString()}');
    }
  }
}
