class TotalBrgRuangan {
  final int jumlahBarangRuangan;

  TotalBrgRuangan({
    required this.jumlahBarangRuangan,
  });

  factory TotalBrgRuangan.fromJson(Map<String, dynamic> json) =>
      TotalBrgRuangan(
        jumlahBarangRuangan: json['jumlah_barang_ruangan'] as int,
      );
}
