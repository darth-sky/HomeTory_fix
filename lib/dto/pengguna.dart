class Pengguna {
  final int idPengguna;
  final String username;
  // final String kata_sandi;
  final String email;
  final String role;
  final String fotoProfil;
  final double longtitude;
  final double latitude;

  Pengguna({
    required this.idPengguna,
    required this.username,
    // required this.kata_sandi,
    required this.email,
    required this.role,
    required this.fotoProfil,
    required this.longtitude,
    required this.latitude,
  });

  factory Pengguna.fromJson(Map<String, dynamic> json) => Pengguna(
        idPengguna: json['id_pengguna'] as int,
        username: json['username'] ?? '', // Provide a default value if null
        // kata_sandi: json['kata_sandi'] as String,
        email: json['email'] ?? '', // Provide a default value if null
        role: json['role'] ?? '', // Provide a default value if null
        fotoProfil: json['foto_profil'] ?? '', // Provide a default value if null
        // longtitude: (json['longtitude'] as num?)?.toDouble() ?? 0.0, // Handle possible null and convert to double
        // latitude: (json['latitude'] as num?)?.toDouble() ?? 0.0, // Handle possible null and convert to double
        longtitude: double.parse(json['longtitude'] as String),
        latitude: double.parse(json['latitude'] as String),
      );
}
