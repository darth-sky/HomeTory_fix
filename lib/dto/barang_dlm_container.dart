class Barang_dlm_container {
  final int id_barang_dlm_container;
  final int id_ruangan;
  final String nama_barang_dlm_container;
  final String desc_barang_dlm_container;
  final int qnty_barang_dlm_container;
  final String gambar_barang_dlm_container;

  Barang_dlm_container({
    required this.id_barang_dlm_container,
    required this.id_ruangan,
    required this.nama_barang_dlm_container,
    required this.desc_barang_dlm_container,
    required this.qnty_barang_dlm_container,
    required this.gambar_barang_dlm_container,
  });

  factory Barang_dlm_container.fromJson(Map<String, dynamic> json) =>
      Barang_dlm_container(
          id_barang_dlm_container: json['id_barang_dlm_container'] as int,
          id_ruangan: json['id_ruangan'] as int,
          nama_barang_dlm_container: json['nama_barang_dlm_container'] as String,
          desc_barang_dlm_container: json['desc_barang_dlm_container'] as String,
          qnty_barang_dlm_container: json['qnty_barang_dlm_container'] as int,
          gambar_barang_dlm_container:
              json['gambar_barang_dlm_container'] as String);
}
