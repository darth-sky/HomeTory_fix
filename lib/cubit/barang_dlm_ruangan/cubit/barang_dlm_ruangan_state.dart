part of 'barang_dlm_ruangan_cubit.dart';

@immutable
class BarangDlmRuanganState {
  const BarangDlmRuanganState({required this.ListOfBarang_dlm_ruangan});
  final List<Barang_dlm_ruangan> ListOfBarang_dlm_ruangan;
}

final class BarangDlmRuanganInitial extends BarangDlmRuanganState {
  BarangDlmRuanganInitial()
      : super(ListOfBarang_dlm_ruangan: [
          Barang_dlm_ruangan(
              id_barang_dlm_ruangan: 1,
              id_ruangan: 1,
              nama_barang_dlm_ruangan: 'default',
              desc_barang_dlm_ruangan: 'default',
              qnty_barang_dlm_ruangan: 1,
              gambar_barang_dlm_ruangan: 'pfp.jpg')
        ]);
}



