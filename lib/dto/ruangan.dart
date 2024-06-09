class Ruangan {
  final int id_ruangan;
  final int id_pengguna;
  final String nama_ruangan;
  final String gambar_ruangan;

  Ruangan(
      {required this.id_ruangan,
      required this.id_pengguna,
      required this.nama_ruangan,
      required this.gambar_ruangan,
      
      });

  factory Ruangan.fromJson(Map<String, dynamic> json) => Ruangan(
      id_ruangan: json['id_ruangan'] as int,
      id_pengguna: json['id_pengguna'] as int,
      nama_ruangan: json['nama_ruangan'] as String,
      gambar_ruangan: json['gambar_ruangan'] as String);
}