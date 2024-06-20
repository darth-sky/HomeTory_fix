class totalRuangan {
  final int jumlah_ruangan;

  totalRuangan({
    required this.jumlah_ruangan,
  });

  factory totalRuangan.fromJson(Map<String, dynamic> json) =>
      totalRuangan(
        jumlah_ruangan: json['jumlah_ruangan'] as int,
      );
}
