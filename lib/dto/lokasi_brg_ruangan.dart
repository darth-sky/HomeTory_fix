class LocationBrgRuangan {
  final String namaRuangan;

  LocationBrgRuangan({
    required this.namaRuangan,
  });

  factory LocationBrgRuangan.fromJson(Map<String, dynamic> json) =>
      LocationBrgRuangan(
        namaRuangan: json['nama_ruangan'] as String,
      );
}
