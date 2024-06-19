class locationBrgContainer {
  final String nama_ruangan;
  final String nama_container;

  locationBrgContainer({
    required this.nama_ruangan,
    required this.nama_container
  });

  factory locationBrgContainer.fromJson(Map<String, dynamic> json) =>
      locationBrgContainer(
        nama_ruangan: json['nama_ruangan'] as String,
        nama_container: json['nama_container'] as String,
      );
}
