class LocationBrgContainer {
  final String namaRuangan;
  final String namaContainer;

  LocationBrgContainer({
    required this.namaRuangan,
    required this.namaContainer
  });

  factory LocationBrgContainer.fromJson(Map<String, dynamic> json) =>
      LocationBrgContainer(
        namaRuangan: json['nama_ruangan'] as String,
        namaContainer: json['nama_container'] as String,
      );
}
