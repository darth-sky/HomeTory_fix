class Pengguna {
  final int id_pengguna;
  final String username;
  // final String kata_sandi;
  // final String email;
  final String role;
  final String foto_profil;

  Pengguna(
      {required this.id_pengguna,
      required this.username,
      // required this.kata_sandi,
      // required this.email,
      required this.role,
      required this.foto_profil});

  factory Pengguna.fromJson(Map<String, dynamic> json) => Pengguna(
        id_pengguna: json['id_pengguna'] as int,
        username: json['username'] as String,
        // kata_sandi: json['kata_sandi'] as String,
        // email: json['email'] as String ,
        role: json['role'] as String,
        foto_profil: json['foto_profil'] as String,
      );
}
