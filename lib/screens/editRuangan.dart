import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hometory/dto/ruangan.dart';
import 'package:hometory/endpoints/endpoints.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class EditRuangan extends StatefulWidget {
  final Ruangan ruangan;

  const EditRuangan({required this.ruangan, Key? key}) : super(key: key);

  @override
  _EditRuanganState createState() => _EditRuanganState();
}

class _EditRuanganState extends State<EditRuangan> {
  late TextEditingController _titleController;

  File? galleryFile;
  final picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.ruangan.nama_ruangan);
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  Future<void> _showPicker({required BuildContext context}) async {
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

  Future<void> getImage(ImageSource img) async {
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

  Future<void> _updateDataWithImage(BuildContext context) async {
    try {
      var request = http.MultipartRequest('PUT',
          Uri.parse('${Endpoints.ruanganUpdate}/${widget.ruangan.id_ruangan}'));
      request.fields['id_ruangan'] = widget.ruangan.id_ruangan.toString();
      request.fields['nama_ruangan'] = _titleController.text;

      if (galleryFile != null) {
        var multipartFile = await http.MultipartFile.fromPath(
            'gambar_ruangan', galleryFile!.path);
        request.files.add(multipartFile);
      }

      // Debug prints to verify request details
      debugPrint('Request URL: ${request.url}');
      debugPrint('Request Fields: ${request.fields}');
      debugPrint('Request Files: ${request.files}');

      var response = await request.send();
      if (response.statusCode == 200) {
        debugPrint('Ruangan updated successfully!');
        Navigator.pushReplacementNamed(context, '/home-screen');
      } else {
        debugPrint('Error updating Ruangan: ${response.statusCode}');
        var responseBody = await response.stream.bytesToString();
        debugPrint('Response body: $responseBody');
      }
    } catch (e) {
      if (e is http.ClientException) {
        debugPrint('ClientException: ${e.message}');
      } else if (e is SocketException) {
        debugPrint('SocketException: ${e.message}');
      } else {
        debugPrint('Exception: ${e.toString()}');
      }
    }
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Edit Ruangan",
                  style: GoogleFonts.poppins(
                    fontSize: 32,
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  "Isi Form Ruangan untuk mengedit ruangan!",
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
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(60),
                  topRight: Radius.circular(60),
                ),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
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
                              decoration: const BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(color: Colors.black),
                                ),
                              ),
                              width: double.infinity,
                              height: 150,
                              child: galleryFile == null
                                  ? (widget.ruangan.gambar_ruangan.isNotEmpty
                                      ? Image.network(
                                          "${Endpoints.baseUAS}/static/img/${widget.ruangan.gambar_ruangan}")
                                      : Center(
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
                                        ))
                                  : Center(child: Image.file(galleryFile!)),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: const BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(color: Colors.black)),
                            ),
                            child: TextField(
                              controller: _titleController,
                              decoration: const InputDecoration(
                                hintText: "Title",
                                hintStyle: TextStyle(color: Colors.grey),
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        String ruanganName = _titleController.text;
                        if (ruanganName.isNotEmpty) {
                          _updateDataWithImage(context);
                        }
                      },
                      child: const Text('Save'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
