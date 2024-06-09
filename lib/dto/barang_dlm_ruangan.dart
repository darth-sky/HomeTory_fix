class Barang_dlm_ruangan {
  final int id_barang_dlm_ruangan;
  final int id_ruangan;
  final String nama_barang_dlm_ruangan;
  final String desc_barang_dlm_ruangan;
  final int qnty_barang_dlm_ruangan;
  final String gambar_barang_dlm_ruangan;

  Barang_dlm_ruangan({
    required this.id_barang_dlm_ruangan,
    required this.id_ruangan,
    required this.nama_barang_dlm_ruangan,
    required this.desc_barang_dlm_ruangan,
    required this.qnty_barang_dlm_ruangan,
    required this.gambar_barang_dlm_ruangan,
  });

  factory Barang_dlm_ruangan.fromJson(Map<String, dynamic> json) =>
      Barang_dlm_ruangan(
          id_barang_dlm_ruangan: json['id_barang_dlm_ruangan'] as int,
          id_ruangan: json['id_ruangan'] as int,
          nama_barang_dlm_ruangan: json['nama_barang_dlm_ruangan'] as String,
          desc_barang_dlm_ruangan: json['desc_barang_dlm_ruangan'] as String,
          qnty_barang_dlm_ruangan: json['qnty_barang_dlm_ruangan'] as int,
          gambar_barang_dlm_ruangan:
              json['gambar_barang_dlm_ruangan'] as String);
}
