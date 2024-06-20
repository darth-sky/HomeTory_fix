class totalBrgContainer {
  final int jumlah_barang_container;

  totalBrgContainer({
    required this.jumlah_barang_container,
  });

  factory totalBrgContainer.fromJson(Map<String, dynamic> json) =>
      totalBrgContainer(
        jumlah_barang_container: json['jumlah_barang_container'] as int,
      );
}
