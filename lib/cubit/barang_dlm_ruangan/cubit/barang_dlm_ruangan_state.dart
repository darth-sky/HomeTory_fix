part of 'barang_dlm_ruangan_cubit.dart';

@immutable
class BarangDlmRuanganState {
  const BarangDlmRuanganState(
      {required this.ListOfBarang_dlm_ruangan, 
      required this.listAllBarang, 
      required this.listOfBarang_dlm_ruangan_byUser
      });
  final List<Barang_dlm_ruangan> ListOfBarang_dlm_ruangan;
  final List<Barang_dlm_ruangan> listAllBarang;
  final List<Barang_dlm_ruangan> listOfBarang_dlm_ruangan_byUser;
}

final class BarangDlmRuanganInitial extends BarangDlmRuanganState {
  BarangDlmRuanganInitial()
      : super(
          ListOfBarang_dlm_ruangan: [
            Barang_dlm_ruangan(
              id_barang_dlm_ruangan: 1,
              id_ruangan: 1,
              nama_barang_dlm_ruangan: 'default',
              desc_barang_dlm_ruangan: 'default',
              qnty_barang_dlm_ruangan: 1,
              gambar_barang_dlm_ruangan: 'pfp.jpg',
              category_barang_dlm_ruangan: 'lain-lain',
            ),
          ],
          listAllBarang: [
            Barang_dlm_ruangan(
              id_barang_dlm_ruangan: 1,
              id_ruangan: 1,
              nama_barang_dlm_ruangan: 'default',
              desc_barang_dlm_ruangan: 'default',
              qnty_barang_dlm_ruangan: 1,
              gambar_barang_dlm_ruangan: 'pfp.jpg',
              category_barang_dlm_ruangan: 'lain-lain',
            ),
          ],
          listOfBarang_dlm_ruangan_byUser: [
            Barang_dlm_ruangan(
              id_barang_dlm_ruangan: 1,
              id_ruangan: 1,
              nama_barang_dlm_ruangan: 'default',
              desc_barang_dlm_ruangan: 'default',
              qnty_barang_dlm_ruangan: 1,
              gambar_barang_dlm_ruangan: 'pfp.jpg',
              category_barang_dlm_ruangan: 'lain-lain',
            ),
          ],
        );
}
