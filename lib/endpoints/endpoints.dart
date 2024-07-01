import 'package:hometory/utils/secure_storage_util.dart';

class Endpoints {
  static late String baseUAS;
  
  // Panggil metode ini selama inisialisasi aplikasi
  static Future<void> initialize() async {
    final urlInput = await SecureStorageUtil.storage.read(key: 'url_setting');
    baseUAS = urlInput ?? "default_url_if_not_found";
  }

    //Ruangan
  static  String get ruanganRead => "$baseUAS/api/v1/ruangan/read";
  static String get ruanganCreate => "$baseUAS/api/v1/ruangan/create";
  static String get ruanganDelete => "$baseUAS/api/v1/ruangan/delete";
  static String get ruanganUpdate => "$baseUAS/api/v1/ruangan/update";

  // Containers
  static String get containerRead => "$baseUAS/api/v1/container/read";
  static String get containerCreate => "$baseUAS/api/v1/container/create";
  static String get containerDelete => "$baseUAS/api/v1/container/delete";
  static String get containerUpdate => "$baseUAS/api/v1/container/update";

  // barang dalam ruangan
  static String get barangDlmRuanganRead =>
      "$baseUAS/api/v1/barang_dlm_ruangan/read";
  static String get barangDlmRuanganReadAll =>
      "$baseUAS/api/v1/barang_dlm_ruangan/readAll";
  static String get barangDlmRuanganCreate =>
      "$baseUAS/api/v1/barang_dlm_ruangan/create";
  static String get barangDlmRuanganDelete =>
      "$baseUAS/api/v1/barang_dlm_ruangan/delete";
  static String get barangDlmRuanganUpdate =>
      "$baseUAS/api/v1/barang_dlm_ruangan/update";
  static String get barangDlmRuanganByUser =>
      "$baseUAS/api/v1/barang_dlm_ruangan/readByUser";
  static String get barangDlmRuanganLocation =>
      "$baseUAS/api/v1/barang_dlm_ruangan/readTotalBarang";

  // barang dalam container
  static String get barangDlmContainerRead =>
      "$baseUAS/api/v1/barang_dlm_container/read";
  static String get barangDlmContainerReadAll =>
      "$baseUAS/api/v1/barang_dlm_container/readAll";
  static String get barangDlmContainerCreate =>
      "$baseUAS/api/v1/barang_dlm_container/create";
  static String get barangDlmContainerDelete =>
      "$baseUAS/api/v1/barang_dlm_container/delete";
  static String get barangDlmContainerUpdate =>
      "$baseUAS/api/v1/barang_dlm_container/update";
  static String get barangDlmContainerByUser =>
      "$baseUAS/api/v1/barang_dlm_container/readByUserContainer";
  static String get barangDlmContainerLocation =>
      "$baseUAS/api/v1/barang_dlm_container/readTotalBarangContainer";

  // auth
  static String get login => "$baseUAS/api/v1/auth/login";
  static String get signUp => "$baseUAS/api/v1/auth/register";

  // role
  static String get updateRole => "$baseUAS/api/v1/pengguna/updateRole";

  // user
  static String get userRead => "$baseUAS/api/v1/pengguna/read";
  static String get userReadId => "$baseUAS/api/v1/pengguna/readByIdUser";
  static String get userUpdate => "$baseUAS/api/v1/pengguna/update";
  static String get userRuangan => "$baseUAS/api/v1/pengguna/userReadRuangan";
  static String get userBrgContainer =>
      "$baseUAS/api/v1/pengguna/userReadBrgContainer";
  static String get userBrgRuangan =>
      "$baseUAS/api/v1/pengguna/userReadBrgRuangan";

}

// class Endpoints {
//   // UAS
//   static String get host => "10.0.2.2";
//   static String get hostpublic => '10.23.2.28';

//   static String get baseUAS => "http://$hostpublic:5000";

//   //Ruangan
//   static String get ruanganRead => "$baseUAS/api/v1/ruangan/read";
//   static String get ruanganCreate => "$baseUAS/api/v1/ruangan/create";
//   static String get ruanganDelete => "$baseUAS/api/v1/ruangan/delete";
//   static String get ruanganUpdate => "$baseUAS/api/v1/ruangan/update";

//   // Containers
//   static String get containerRead => "$baseUAS/api/v1/container/read";
//   static String get containerCreate => "$baseUAS/api/v1/container/create";
//   static String get containerDelete => "$baseUAS/api/v1/container/delete";
//   static String get containerUpdate => "$baseUAS/api/v1/container/update";

//   // barang dalam ruangan
//   static String get barangDlmRuanganRead =>
//       "$baseUAS/api/v1/barang_dlm_ruangan/read";
//   static String get barangDlmRuanganReadAll =>
//       "$baseUAS/api/v1/barang_dlm_ruangan/readAll";
//   static String get barangDlmRuanganCreate =>
//       "$baseUAS/api/v1/barang_dlm_ruangan/create";
//   static String get barangDlmRuanganDelete =>
//       "$baseUAS/api/v1/barang_dlm_ruangan/delete";
//   static String get barangDlmRuanganUpdate =>
//       "$baseUAS/api/v1/barang_dlm_ruangan/update";
//   static String get barangDlmRuanganByUser =>
//       "$baseUAS/api/v1/barang_dlm_ruangan/readByUser";
//   static String get barangDlmRuanganLocation =>
//       "$baseUAS/api/v1/barang_dlm_ruangan/readTotalBarang";

//   // barang dalam container
//   static String get barangDlmContainerRead =>
//       "$baseUAS/api/v1/barang_dlm_container/read";
//   static String get barangDlmContainerReadAll =>
//       "$baseUAS/api/v1/barang_dlm_container/readAll";
//   static String get barangDlmContainerCreate =>
//       "$baseUAS/api/v1/barang_dlm_container/create";
//   static String get barangDlmContainerDelete =>
//       "$baseUAS/api/v1/barang_dlm_container/delete";
//   static String get barangDlmContainerUpdate =>
//       "$baseUAS/api/v1/barang_dlm_container/update";
//   static String get barangDlmContainerByUser =>
//       "$baseUAS/api/v1/barang_dlm_container/readByUserContainer";
//   static String get barangDlmContainerLocation =>
//       "$baseUAS/api/v1/barang_dlm_container/readTotalBarangContainer";

//   // auth
//   static String get login => "$baseUAS/api/v1/auth/login";
//   static String get signUp => "$baseUAS/api/v1/auth/register";

//   // role
//   static String get updateRole => "$baseUAS/api/v1/pengguna/updateRole";

//   // user
//   static String get userRead => "$baseUAS/api/v1/pengguna/read";
//   static String get userReadId => "$baseUAS/api/v1/pengguna/readByIdUser";
//   static String get userUpdate => "$baseUAS/api/v1/pengguna/update";
//   static String get userRuangan => "$baseUAS/api/v1/pengguna/userReadRuangan";
//   static String get userBrgContainer =>
//       "$baseUAS/api/v1/pengguna/userReadBrgContainer";
//   static String get userBrgRuangan =>
//       "$baseUAS/api/v1/pengguna/userReadBrgRuangan";
// }
