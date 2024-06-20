class Endpoints {
  // UAS
  static const String host = "10.0.2.2";
  static const String hostpublic = '192.168.18.208';

  static const String baseUAS = "http://$host:5000";

  //Ruangan
  static const String ruanganRead = "$baseUAS/api/v1/ruangan/read";
  static const String ruanganCreate = "$baseUAS/api/v1/ruangan/create";
  static const String ruanganDelete = "$baseUAS/api/v1/ruangan/delete";
  static const String ruanganUpdate = "$baseUAS/api/v1/ruangan/update";

  // Containers
  static const String containerRead = "$baseUAS/api/v1/container/read";
  static const String containerCreate = "$baseUAS/api/v1/container/create";
  static const String containerDelete = "$baseUAS/api/v1/container/delete";
  static const String containerUpdate = "$baseUAS/api/v1/container/update";

  // barang dalam ruangan
  static const String barangDlmRuanganRead =
      "$baseUAS/api/v1/barang_dlm_ruangan/read";
  static const String barangDlmRuanganReadAll =
      "$baseUAS/api/v1/barang_dlm_ruangan/readAll";
  static const String barangDlmRuanganCreate =
      "$baseUAS/api/v1/barang_dlm_ruangan/create";
  static const String barangDlmRuanganDelete =
      "$baseUAS/api/v1/barang_dlm_ruangan/delete";
  static const String barangDlmRuanganUpdate =
      "$baseUAS/api/v1/barang_dlm_ruangan/update";
  static const String barangDlmRuanganByUser =
      "$baseUAS/api/v1/barang_dlm_ruangan/readByUser";
  static const String barangDlmRuanganLocation =
      "$baseUAS/api/v1/barang_dlm_ruangan/readTotalBarang";

  // barang dalam container
  static const String barangDlmContainerRead =
      "$baseUAS/api/v1/barang_dlm_container/read";
  static const String barangDlmContainerReadAll =
      "$baseUAS/api/v1/barang_dlm_container/readAll";
  static const String barangDlmContainerCreate =
      "$baseUAS/api/v1/barang_dlm_container/create";
  static const String barangDlmContainerDelete =
      "$baseUAS/api/v1/barang_dlm_container/delete";
  static const String barangDlmContainerUpdate =
      "$baseUAS/api/v1/barang_dlm_container/update";
  static const String barangDlmContainerByUser =
      "$baseUAS/api/v1/barang_dlm_container/readByUserContainer";
  static const String barangDlmContainerLocation =
      "$baseUAS/api/v1/barang_dlm_container/readTotalBarangContainer";

  // auth
  static const String login = "$baseUAS/api/v1/auth/login";
  static const String SignUp = "$baseUAS/api/v1/auth/register";

  // role
  static const String updateRole = "$baseUAS/api/v1/pengguna/updateRole";

  // user
  static const String userRead = "$baseUAS/api/v1/pengguna/read";
  static const String userReadId = "$baseUAS/api/v1/pengguna/readByIdUser";
  static const String userUpdate = "$baseUAS/api/v1/pengguna/update";
  static const String userRuangan = "$baseUAS/api/v1/pengguna/userReadRuangan";
  static const String userBrgContainer =
      "$baseUAS/api/v1/pengguna/userReadBrgContainer";
  static const String userBrgRuangan =
      "$baseUAS/api/v1/pengguna/userReadBrgRuangan";
}
