import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hometory/cubit/auth/cubit/auth_cubit.dart';
import 'package:hometory/endpoints/endpoints.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';

class TambahRuanganScreen extends StatefulWidget {
  const TambahRuanganScreen({Key? key}) : super(key: key);

  @override
  _TambahRuanganScreenState createState() => _TambahRuanganScreenState();
}

class _TambahRuanganScreenState extends State<TambahRuanganScreen> {
  TextEditingController _ruanganController = TextEditingController();

  File? galleryFile;
  final picker = ImagePicker();

  _showPicker({
    required BuildContext context,
  }) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Photo Library'),
                onTap: () {
                  getImage(ImageSource.gallery);
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_camera),
                title: const Text('Camera'),
                onTap: () {
                  getImage(ImageSource.camera);
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future getImage(
    ImageSource img,
  ) async {
    final pickedFile = await picker.pickImage(source: img);
    XFile? xfilePick = pickedFile;
    setState(
      () {
        if (xfilePick != null) {
          galleryFile = File(pickedFile!.path);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Nothing is selected')));
        }
      },
    );
  }

  Future<void> _postDataWithImage(BuildContext context, int idUser) async {
    if (galleryFile == null) {
      return; // Handle case where no image is selected
    }

    var request =
        MultipartRequest('POST', Uri.parse(Endpoints.ruanganCreate));
    debugPrint(idUser.toString());
    debugPrint(galleryFile!.path.toString());
    debugPrint(_ruanganController.text);
    request.fields['id_pengguna'] = idUser.toString();
    request.fields['nama_ruangan'] = _ruanganController.text;

    var multipartFile = await MultipartFile.fromPath(
      'gambar_ruangan',
      galleryFile!.path,
    );
    request.files.add(multipartFile);

    request.send().then((response) {
      // Handle response (success or error)
      if (response.statusCode == 201) {
        debugPrint('Data and image posted successfully!');
        Navigator.pushReplacementNamed(context, '/home-screen');
      } else {
        debugPrint('Error posting data: ${response.statusCode}');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Ruangan'),
        backgroundColor: Colors.blueGrey,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  _showPicker(context: context);
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(10.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                  ),
                  minimumSize: const Size(
                      110.0, 30.0), // Sesuaikan dengan keinginan Anda
                ),
                child: const Icon(
                  Icons.camera_alt,
                  size: 50.0,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: _ruanganController,
                decoration: const InputDecoration(
                  labelText: 'Nama Ruangan',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              BlocBuilder<AuthCubit, AuthState>(
                builder: (context, state) {
                  return ElevatedButton(
                    onPressed: () {
                      String ruanganName = _ruanganController.text;
                      if (ruanganName.isNotEmpty) {
                        _postDataWithImage(context, state.idPengguna!);
                      }
                    },
                    child: const Text('Save'),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
