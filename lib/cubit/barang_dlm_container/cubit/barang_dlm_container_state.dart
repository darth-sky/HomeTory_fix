part of 'barang_dlm_container_cubit.dart';

@immutable
class BarangDlmContainerState {
  const BarangDlmContainerState(
      {required this.listOfBarangDlmContainer,
      required this.listAllBarangContainer,
      required this.listOfBarangDlmContainerByUser
      // required this.listOfBarang_dlm_container_byUser
      });
  final List<BarangDlmContainer> listOfBarangDlmContainer;
  final List<BarangDlmContainer> listAllBarangContainer;
  final List<BarangDlmContainer> listOfBarangDlmContainerByUser;
  // final List<Barang_dlm_container> listOfBarang_dlm_container_byUser;
}

final class BarangDlmContainerInitial extends BarangDlmContainerState {
  BarangDlmContainerInitial()
      : super(listOfBarangDlmContainer: [
          BarangDlmContainer(
            idBarangDlmContainer: 1,
            idContainer: 1,
            namaBarangDlmContainer: 'default',
            descBarangDlmContainer: 'default',
            qntyBarangDlmContainer: 1,
            gambarBarangDlmContainer: 'pfp.jpg',
            categoryBarangDlmContainer: 'lain-lain',
          )
        ], 
        listAllBarangContainer: [
          BarangDlmContainer(
            idBarangDlmContainer: 1,
            idContainer: 1,
            namaBarangDlmContainer: 'default',
            descBarangDlmContainer: 'default',
            qntyBarangDlmContainer: 1,
            gambarBarangDlmContainer: 'pfp.jpg',
            categoryBarangDlmContainer: 'lain-lain',
          )
        ],
        listOfBarangDlmContainerByUser: [
          BarangDlmContainer(
            idBarangDlmContainer: 1,
            idContainer: 1,
            namaBarangDlmContainer: 'default',
            descBarangDlmContainer: 'default',
            qntyBarangDlmContainer: 1,
            gambarBarangDlmContainer: 'pfp.jpg',
            categoryBarangDlmContainer: 'lain-lain',
          )
        ],
        );
}
