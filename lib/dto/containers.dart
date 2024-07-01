class Containers {
  final int idContainer;
  final int idRuangan;
  final String namaContainer;
  final String gambarContainer;

  Containers(
      {required this.idContainer,
      required this.idRuangan,
      required this.namaContainer,
      required this.gambarContainer,
      
      });

  factory Containers.fromJson(Map<String, dynamic> json) => Containers(
      idContainer: json['id_container'] as int,
      idRuangan: json['id_ruangan'] as int,
      namaContainer: json['nama_container'] as String,
      gambarContainer: json['gambar_container'] as String);
      
}