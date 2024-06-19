class Login {
  final String accessToken;
  final String tokenType;
  final int expiresIn;
  final int idUser;
  final String roles;
  final String username;

  Login(
      {required this.accessToken,
      required this.tokenType,
      required this.expiresIn,
      required this.idUser,
      required this.roles,
      required this.username});

  factory Login.fromJson(Map<String, dynamic> json) {
    return Login(
        accessToken: json['access_token'] as String,
        tokenType: json['type'] as String,
        expiresIn: json['expires_in'] as int,
        idUser: json['id_pengguna'] as int,
        roles: json['role'] as String,
        username: json['username'] as String);
  }
}
