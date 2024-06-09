class Containers {
  final int id_containers;
  final int id_ruangan;
  final String nama_containers;
  final String gambar_containers;

  Containers(
      {required this.id_containers,
      required this.id_ruangan,
      required this.nama_containers,
      required this.gambar_containers,
      
      });

  factory Containers.fromJson(Map<String, dynamic> json) => Containers(
      id_containers: json['id_container'] as int,
      id_ruangan: json['id_ruangan'] as int,
      nama_containers: json['nama_container'] as String,
      gambar_containers: json['gambar_container'] as String);
      
}