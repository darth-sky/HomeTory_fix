class Endpoints {
  // UAS
  static const String host = "10.0.2.2";
  // static const String hostpublic =;

  static const String baseUAS = "http://$host:5000";

  //Ruangan
  static const String ruanganRead = "$baseUAS/api/v1/ruangan/read";
  static const String ruanganCreate = "$baseUAS/api/v1/ruangan/create";

  // Containers
  static const String containerRead = "$baseUAS/api/v1/container/read";
  static const String containerCreate = "$baseUAS/api/v1/container/create";

  // barang dalam ruangan
  static const String barangDlmRuanganRead =
      "$baseUAS/api/v1/barang_dlm_ruangan/read";

  // auth
  static const String login = "$baseUAS/api/v1/auth/login";
}
