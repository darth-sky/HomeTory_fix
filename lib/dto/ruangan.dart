class Ruangan {
  final int idRuangan;
  final int idPengguna;
  final String namaRuangan;
  final String gambarRuangan;

  Ruangan(
      {required this.idRuangan,
      required this.idPengguna,
      required this.namaRuangan,
      required this.gambarRuangan,
      
      });

  factory Ruangan.fromJson(Map<String, dynamic> json) => Ruangan(
      idRuangan: json['id_ruangan'] as int,
      idPengguna: json['id_pengguna'] as int,
      namaRuangan: json['nama_ruangan'] as String,
      gambarRuangan: json['gambar_ruangan'] as String);
}