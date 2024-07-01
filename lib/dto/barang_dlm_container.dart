class BarangDlmContainer {
  final int idBarangDlmContainer;
  final int idContainer;
  final String namaBarangDlmContainer;
  final String descBarangDlmContainer;
  final int qntyBarangDlmContainer;
  final String gambarBarangDlmContainer;
  final String categoryBarangDlmContainer;

  BarangDlmContainer(
      {required this.idBarangDlmContainer,
      required this.idContainer,
      required this.namaBarangDlmContainer,
      required this.descBarangDlmContainer,
      required this.qntyBarangDlmContainer,
      required this.gambarBarangDlmContainer,
      required this.categoryBarangDlmContainer});

  factory BarangDlmContainer.fromJson(Map<String, dynamic> json) =>
      BarangDlmContainer(
        idBarangDlmContainer: json['id_barang_dlm_container'] as int,
        idContainer: json['id_container'] as int,
        namaBarangDlmContainer: json['nama_barang_dlm_container'] as String,
        descBarangDlmContainer: json['desc_barang_dlm_container'] as String,
        qntyBarangDlmContainer: json['qnty_barang_dlm_container'] as int,
        gambarBarangDlmContainer:
            json['gambar_barang_dlm_container'] as String,
        categoryBarangDlmContainer:
            json['category_barang_dlm_container'] as String,
      );
}
