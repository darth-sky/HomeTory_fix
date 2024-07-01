class BarangDlmRuangan {
  final int idBarangDlmRuangan;
  final int idRuangan;
  final String namaBarangDlmRuangan;
  final String descBarangDlmRuangan;
  final int qntyBarangDlmRuangan;
  final String gambarBarangDlmRuangan;
  final String categoryBarangDlmRuangan;

  BarangDlmRuangan({
    required this.idBarangDlmRuangan,
    required this.idRuangan,
    required this.namaBarangDlmRuangan,
    required this.descBarangDlmRuangan,
    required this.qntyBarangDlmRuangan,
    required this.gambarBarangDlmRuangan,
    required this.categoryBarangDlmRuangan
  });

  factory BarangDlmRuangan.fromJson(Map<String, dynamic> json) =>
      BarangDlmRuangan(
          idBarangDlmRuangan: json['id_barang_dlm_ruangan'] as int,
          idRuangan: json['id_ruangan'] as int,
          namaBarangDlmRuangan: json['nama_barang_dlm_ruangan'] as String,
          descBarangDlmRuangan: json['desc_barang_dlm_ruangan'] as String,
          qntyBarangDlmRuangan: json['qnty_barang_dlm_ruangan'] as int,
          gambarBarangDlmRuangan:
              json['gambar_barang_dlm_ruangan'] as String,
          categoryBarangDlmRuangan: json['category_barang_dlm_ruangan'] as String,
              );
          
}
