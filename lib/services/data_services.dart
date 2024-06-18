import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hometory/dto/barang_dlm_container.dart';
import 'package:hometory/dto/barang_dlm_ruangan.dart';
import 'package:hometory/dto/containers.dart';
import 'package:hometory/dto/pengguna.dart';
import 'package:hometory/dto/ruangan.dart';

import 'package:http/http.dart' as http;
import 'package:hometory/endpoints/endpoints.dart';

class DataService {
  static Future<List<Ruangan>> fetchRuangan() async {
    final response = await http.get(Uri.parse(Endpoints.ruanganRead));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      return (data['datas'] as List<dynamic>)
          .map((item) => Ruangan.fromJson(item as Map<String, dynamic>))
          .toList();
    } else {
      // Handle error
      throw Exception('Failed to load data ${response.statusCode}');
    }
  }

  static Future<List<Pengguna>> fetchUser() async {
    final response = await http.get(Uri.parse(Endpoints.userRead));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      return (data['datas'] as List<dynamic>)
          .map((item) => Pengguna.fromJson(item as Map<String, dynamic>))
          .toList();
    } else {
      // Handle error
      throw Exception('Failed to load data pengguna ${response.statusCode}');
    }
  }

  // static Future<List<Pengguna>> fetchUserById(
  //   int id_pengguna,
  // ) async {
  //   String endpoint;
  //   endpoint = '${Endpoints.barangDlmRuanganByUser}/$id_pengguna';

  //   final uri = Uri.parse(endpoint).replace(queryParameters: {
  //     'search': search,
  //     'page': page.toString(),
  //   });
  //   final response = await http.get(uri);
  //   if (response.statusCode == 200) {
  //     final List<dynamic> data = json.decode(response.body)['datas'];
  //     return data.map((item) => Barang_dlm_ruangan.fromJson(item)).toList();
  //   } else {
  //     throw Exception('Failed to load data');
  //   }
  // }

  static Future<List<Containers>> fetchContainers() async {
    final response = await http.get(Uri.parse(Endpoints.containerRead));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      return (data['datas'] as List<dynamic>)
          .map((item) => Containers.fromJson(item as Map<String, dynamic>))
          .toList();
    } else {
      // Handle error
      throw Exception('Failed to load data ${response.statusCode}');
    }
  }

  

  // static Future<List<Barang_dlm_ruangan>> fetchBarangDlmRuangan() async {
  //   (int id_ruangan, int page, String search) async {
  //       final uri = Uri.parse('${Endpoints.barangDlmRuanganRead}').replace(queryParameters: {
  //     'search': search,
  //     'page': page.toString(),
  //       };
  //   final response = await http.get(Uri.parse(Endpoints.barangDlmRuanganRead));
  //   if (response.statusCode == 200) {
  //     final data = jsonDecode(response.body) as Map<String, dynamic>;
  //     return (data['datas'] as List<dynamic>)
  //         .map((item) =>
  //             Barang_dlm_ruangan.fromJson(item as Map<String, dynamic>))
  //         .toList();
  //   } else {
  //     // Handle error
  //     throw Exception('Failed to load data ${response.statusCode}');
  //   }
  // }

  static Future<List<Barang_dlm_ruangan>> fetchBarangDlmRuangan(
      int page, String search,
      {int? idRuangan}) async {
    String endpoint;
    if (idRuangan != null) {
      endpoint = '${Endpoints.barangDlmRuanganRead}/$idRuangan';
    } else {
      endpoint = Endpoints.barangDlmRuanganRead;
    }
    final uri = Uri.parse(endpoint).replace(queryParameters: {
      'search': search,
      'page': page.toString(),
    });
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      return (data['datas'] as List<dynamic>)
          .map((item) =>
              Barang_dlm_ruangan.fromJson(item as Map<String, dynamic>))
          .toList();
    } else {
      // Handle error
      throw Exception('Failed to load data ${response.statusCode}');
    }
  }

  // static Future<List<Barang_dlm_ruangan>> fetchBarangDlmRuanganId(
  //     int id_ruangan, int page, String search) async {
  //       final uri = Uri.parse('${Endpoints.barangDlmRuanganRead}').replace(queryParameters: {
  //     'search': search,
  //     'page': page.toString(),
  //   });
  //   final response = await http
  //       .get(Uri.parse('${Endpoints.barangDlmRuanganRead}/$id_ruangan'));
  //   if (response.statusCode == 200) {
  //     final data = jsonDecode(response.body) as Map<String, dynamic>;
  //     return (data['datas'] as List<dynamic>)
  //         .map((item) =>
  //             Barang_dlm_ruangan.fromJson(item as Map<String, dynamic>))
  //         .toList();
  //   } else {
  //     // Handle error
  //     throw Exception('Failed to load data ${response.statusCode}');
  //   }
  // }

  // static Future<List<Barang_dlm_container>> fetchBarangDlmContainer() async {
  //   final response =
  //       await http.get(Uri.parse(Endpoints.barangDlmContainerRead));
  //   if (response.statusCode == 200) {
  //     final data = jsonDecode(response.body) as Map<String, dynamic>;
  //     return (data['datas'] as List<dynamic>)
  //         .map((item) =>
  //             Barang_dlm_container.fromJson(item as Map<String, dynamic>))
  //         .toList();
  //   } else {
  //     // Handle error
  //     throw Exception('Failed to load data ${response.statusCode}');
  //   }
  // }

  static Future<List<Barang_dlm_container>> fetchBarangDlmContainer(
      int page, String search,
      {int? idContainer}) async {
    String endpoint;
    if (idContainer != null) {
      endpoint = '${Endpoints.barangDlmContainerRead}/$idContainer';
    } else {
      endpoint = Endpoints.barangDlmContainerRead;
    }
    final uri = Uri.parse(endpoint).replace(queryParameters: {
      'search': search,
      'page': page.toString(),
    });
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      return (data['datas'] as List<dynamic>)
          .map((item) =>
              Barang_dlm_container.fromJson(item as Map<String, dynamic>))
          .toList();
    } else {
      // Handle error
      throw Exception('Failed to load data ${response.statusCode} dari fetchBarangDlmContainer');
    }
  }

  static Future<List<Barang_dlm_container>> fetchBarangDlmContainerByUser(
    int page,
    String search,
    int id_pengguna,
  ) async {
    String endpoint;
    endpoint = '${Endpoints.barangDlmContainerByUser}/$id_pengguna';

    final uri = Uri.parse(endpoint).replace(queryParameters: {
      'search': search,
      'page': page.toString(),
    });
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)['datas'];
      return data.map((item) => Barang_dlm_container.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load data dari fetchBarangDlmContainerByuser');
    }
  }

  static Future<List<Barang_dlm_ruangan>> fetchBarangDlmRuanganByUser(
    int page,
    String search,
    int id_pengguna,
  ) async {
    String endpoint;
    endpoint = '${Endpoints.barangDlmRuanganByUser}/$id_pengguna';

    final uri = Uri.parse(endpoint).replace(queryParameters: {
      'search': search,
      'page': page.toString(),
    });
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)['datas'];
      return data.map((item) => Barang_dlm_ruangan.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load data');
    }
  }

  static Future<void> deleteRuangan(int id) async {
    await http.delete(Uri.parse('${Endpoints.ruanganDelete}/$id'),
        headers: {'Content-type': 'application/json'});
  }

  static Future<void> deleteContainer(int id) async {
    await http.delete(Uri.parse('${Endpoints.containerDelete}/$id'),
        headers: {'Content-type': 'application/json'});
  }

  static Future<void> deleteBarangDlmRuangan(int id) async {
    await http.delete(Uri.parse('${Endpoints.barangDlmRuanganDelete}/$id'),
        headers: {'Content-type': 'application/json'});
  }

  static Future<void> deleteBarangDlmContainer(int id) async {
    await http.delete(Uri.parse('${Endpoints.barangDlmContainerDelete}/$id'),
        headers: {'Content-type': 'application/json'});
  }

  //post login with email and password
  static Future<http.Response> sendLoginData(
      String email, String password) async {
    final url = Uri.parse(Endpoints.login);
    debugPrint("$email test");
    debugPrint("$password test");

    final data = {'username': email, 'kata_sandi': password};

    final response = await http.post(
      url,
      headers: {'Content-type': 'application/json'},
      body: jsonEncode(data),
    );
    return response;
  }

  static Future<http.Response> sendSignUpData(
      String email, String password) async {
    final url = Uri.parse(Endpoints.SignUp);

    final data = {'username': email, 'kata_sandi': password};

    final response = await http.post(
      url,
      headers: {'Content-type': 'application/json'},
      body: jsonEncode(data),
    );
    return response;
  }

  static Future<http.Response> sendUpdateRole(
      int idPengguna) async {
    final url = Uri.parse('${Endpoints.updateRole}/$idPengguna');
    final response = await http.put(
      url, 
    );
    return response;
  }

  static Future<List<Barang_dlm_ruangan>> fetchAllBarangDlmRuangan(
      int page) async {
    final uri =
        Uri.parse(Endpoints.barangDlmRuanganReadAll).replace(queryParameters: {
      'page': page.toString(),
    });
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      return (data['datas'] as List<dynamic>)
          .map((item) =>
              Barang_dlm_ruangan.fromJson(item as Map<String, dynamic>))
          .toList();
    } else {
      // Handle error
      throw Exception('Failed to load data ${response.statusCode}');
    }
  }

  static Future<List<Barang_dlm_container>> fetchAllBarangDlmContainer(
      int page) async {
    final uri =
        Uri.parse(Endpoints.barangDlmContainerReadAll).replace(queryParameters: {
      'page': page.toString(),
    });
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      return (data['datas'] as List<dynamic>)
          .map((item) =>
              Barang_dlm_container.fromJson(item as Map<String, dynamic>))
          .toList();
    } else {
      // Handle error
      throw Exception('Failed to load data ${response.statusCode} dari fetch all barang dalam container' );
    }
  }
}
