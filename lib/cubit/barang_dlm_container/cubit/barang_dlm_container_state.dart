part of 'barang_dlm_container_cubit.dart';

@immutable
class BarangDlmContainerState {
  const BarangDlmContainerState(
      {required this.ListOfBarang_dlm_container,
      required this.listAllBarangContainer,
      required this.listOfBarang_dlm_container_byUser
      // required this.listOfBarang_dlm_container_byUser
      });
  final List<Barang_dlm_container> ListOfBarang_dlm_container;
  final List<Barang_dlm_container> listAllBarangContainer;
  final List<Barang_dlm_container> listOfBarang_dlm_container_byUser;
  // final List<Barang_dlm_container> listOfBarang_dlm_container_byUser;
}

final class BarangDlmContainerInitial extends BarangDlmContainerState {
  BarangDlmContainerInitial()
      : super(ListOfBarang_dlm_container: [
          Barang_dlm_container(
            id_barang_dlm_container: 1,
            id_container: 1,
            nama_barang_dlm_container: 'default',
            desc_barang_dlm_container: 'default',
            qnty_barang_dlm_container: 1,
            gambar_barang_dlm_container: 'pfp.jpg',
            category_barang_dlm_container: 'lain-lain',
          )
        ], 
        listAllBarangContainer: [
          Barang_dlm_container(
            id_barang_dlm_container: 1,
            id_container: 1,
            nama_barang_dlm_container: 'default',
            desc_barang_dlm_container: 'default',
            qnty_barang_dlm_container: 1,
            gambar_barang_dlm_container: 'pfp.jpg',
            category_barang_dlm_container: 'lain-lain',
          )
        ],
        listOfBarang_dlm_container_byUser: [
          Barang_dlm_container(
            id_barang_dlm_container: 1,
            id_container: 1,
            nama_barang_dlm_container: 'default',
            desc_barang_dlm_container: 'default',
            qnty_barang_dlm_container: 1,
            gambar_barang_dlm_container: 'pfp.jpg',
            category_barang_dlm_container: 'lain-lain',
          )
        ],
        );
}
