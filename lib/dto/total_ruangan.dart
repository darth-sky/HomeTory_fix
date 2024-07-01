class TotalRuangan {
  final int jumlahRuangan;

  TotalRuangan({
    required this.jumlahRuangan,
  });

  factory TotalRuangan.fromJson(Map<String, dynamic> json) =>
      TotalRuangan(
        jumlahRuangan: json['jumlah_ruangan'] as int,
      );
}
