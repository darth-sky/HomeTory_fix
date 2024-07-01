class TotalBrgContainer {
  final int jumlahBarangContainer;

  TotalBrgContainer({
    required this.jumlahBarangContainer,
  });

  factory TotalBrgContainer.fromJson(Map<String, dynamic> json) =>
      TotalBrgContainer(
        jumlahBarangContainer: json['jumlah_barang_container'] as int,
      );
}
