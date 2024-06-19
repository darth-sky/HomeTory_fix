class locationBrgRuangan {
  final String nama_ruangan;

  locationBrgRuangan({
    required this.nama_ruangan,
  });

  factory locationBrgRuangan.fromJson(Map<String, dynamic> json) =>
      locationBrgRuangan(
        nama_ruangan: json['nama_ruangan'] as String,
      );
}
