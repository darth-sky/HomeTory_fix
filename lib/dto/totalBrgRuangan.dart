class totalBrgRuangan {
  final int jumlah_barang_ruangan;

  totalBrgRuangan({
    required this.jumlah_barang_ruangan,
  });

  factory totalBrgRuangan.fromJson(Map<String, dynamic> json) =>
      totalBrgRuangan(
        jumlah_barang_ruangan: json['jumlah_barang_ruangan'] as int,
      );
}
