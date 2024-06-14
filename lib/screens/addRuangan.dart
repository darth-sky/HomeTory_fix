import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hometory/cubit/auth/cubit/auth_cubit.dart';
import 'package:hometory/endpoints/endpoints.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';

class AddRuangan extends StatefulWidget {
  const AddRuangan({Key? key}) : super(key: key);

  @override
  _AddRuanganState createState() => _AddRuanganState();
}

class _AddRuanganState extends State<AddRuangan> {
  final _ruanganController = TextEditingController();
  String _title = "";

  File? galleryFile;
  final picker = ImagePicker();

  _showPicker({required BuildContext context}) {
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

  Future getImage(ImageSource img) async {
    final pickedFile = await picker.pickImage(source: img);
    setState(() {
      if (pickedFile != null) {
        galleryFile = File(pickedFile.path);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Nothing is selected')),
        );
      }
    });
  }

  @override
  void dispose() {
    _ruanganController.dispose();
    super.dispose();
  }

  saveData() {
    debugPrint(_title);
  }

  Future<void> _postDataWithImage(BuildContext context, int idUser) async {
    if (galleryFile == null) {
      return; // Handle case where no image is selected
    }

    var request = MultipartRequest('POST', Uri.parse(Endpoints.ruanganCreate));
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
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Container(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Tambah Ruangan",
                    style: GoogleFonts.poppins(
                      fontSize: 32,
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    "Isi Form Ruangan untuk menambah ruangan!",
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: Colors.black,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(60),
                      topRight: Radius.circular(60),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 10),
                    child: Column(
                      children: [
                        const SizedBox(height: 20),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  _showPicker(context: context);
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                          color: Colors.grey.shade200),
                                    ),
                                  ),
                                  width: double.infinity,
                                  height: 150,
                                  child: galleryFile == null
                                      ? Center(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              const Icon(
                                                Icons
                                                    .add_photo_alternate_outlined,
                                                color: Colors.grey,
                                                size: 50,
                                              ),
                                              Text(
                                                'Pick your Image here',
                                                style: GoogleFonts.poppins(
                                                  fontSize: 14,
                                                  color: const Color.fromARGB(
                                                      255, 124, 122, 122),
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      : Center(
                                          child: Image.file(galleryFile!),
                                        ),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          color: Colors.grey.shade200)),
                                ),
                                child: TextField(
                                  controller: _ruanganController,
                                  decoration: const InputDecoration(
                                    hintText: "Nama Ruangan",
                                    hintStyle: TextStyle(color: Colors.grey),
                                    border: InputBorder.none,
                                  ),
                                  onChanged: (value) {
                                    setState(() {
                                      _title = value;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        BlocBuilder<AuthCubit, AuthState>(
                          builder: (context, state) {
                            return ElevatedButton(
                              onPressed: () {
                                String ruanganName = _ruanganController.text;
                                if (ruanganName.isNotEmpty) {
                                  _postDataWithImage(
                                      context, state.idPengguna!);
                                }
                              },
                              child: const Text('Save'),
                            );
                          },
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
