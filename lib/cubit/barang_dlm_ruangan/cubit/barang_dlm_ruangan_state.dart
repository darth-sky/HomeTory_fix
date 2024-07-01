part of 'barang_dlm_ruangan_cubit.dart';

@immutable
class BarangDlmRuanganState {
  const BarangDlmRuanganState(
      {required this.listOfBarangDlmRuangan, 
      required this.listAllBarang, 
      required this.listOfBarangDlmRuanganByUser
      });
  final List<BarangDlmRuangan> listOfBarangDlmRuangan;
  final List<BarangDlmRuangan> listAllBarang;
  final List<BarangDlmRuangan> listOfBarangDlmRuanganByUser;
}

final class BarangDlmRuanganInitial extends BarangDlmRuanganState {
  BarangDlmRuanganInitial()
      : super(
          listOfBarangDlmRuangan: [
            BarangDlmRuangan(
              idBarangDlmRuangan: 1,
              idRuangan: 1,
              namaBarangDlmRuangan: 'default',
              descBarangDlmRuangan: 'default',
              qntyBarangDlmRuangan: 1,
              gambarBarangDlmRuangan: 'pfp.jpg',
              categoryBarangDlmRuangan: 'lain-lain',
            ),
          ],
          listAllBarang: [
            BarangDlmRuangan(
              idBarangDlmRuangan: 1,
              idRuangan: 1,
              namaBarangDlmRuangan: 'default',
              descBarangDlmRuangan: 'default',
              qntyBarangDlmRuangan: 1,
              gambarBarangDlmRuangan: 'pfp.jpg',
              categoryBarangDlmRuangan: 'lain-lain',
            ),
          ],
          listOfBarangDlmRuanganByUser: [
            BarangDlmRuangan(
              idBarangDlmRuangan: 1,
              idRuangan: 1,
              namaBarangDlmRuangan: 'default',
              descBarangDlmRuangan: 'default',
              qntyBarangDlmRuangan: 1,
              gambarBarangDlmRuangan: 'pfp.jpg',
              categoryBarangDlmRuangan: 'lain-lain',
            ),
          ],
        );
}
