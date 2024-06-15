import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hometory/dto/barang_dlm_container.dart';
import 'package:hometory/dto/barang_dlm_ruangan.dart';
import 'package:hometory/dto/containers.dart';
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

  static Future<List<Barang_dlm_container>> fetchBarangDlmContainer() async {
    final response =
        await http.get(Uri.parse(Endpoints.barangDlmContainerRead));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      return (data['datas'] as List<dynamic>)
          .map((item) =>
              Barang_dlm_container.fromJson(item as Map<String, dynamic>))
          .toList();
    } else {
      // Handle error
      throw Exception('Failed to load data ${response.statusCode}');
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
}
