import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hometory/cubit/auth/cubit/auth_cubit.dart';
import 'package:hometory/dto/containers.dart';
import 'package:hometory/endpoints/endpoints.dart';
import 'package:hometory/screens/inside_container.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class EditContainer extends StatefulWidget {
  final Containers containers;

  const EditContainer({required this.containers, super.key});

  @override
  State<EditContainer> createState() => _EditContainerState();
}

class _EditContainerState extends State<EditContainer> {
  late TextEditingController _titleController;

  File? galleryFile;
  final picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _titleController =
        TextEditingController(text: widget.containers.namaContainer);
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

  void push() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
          builder: (context) => InsideContainer(
                idInsideContianer: widget.containers.idContainer,
                idRuangan: widget.containers.idRuangan,
              )),
    );
  }

  Future<void> _updateDataWithImage(BuildContext context, int idUser, String accessToken) async {
    try {
      var request = http.MultipartRequest(
          'PUT',
          Uri.parse(
              '${Endpoints.containerUpdate}/${widget.containers.idContainer}'));
      request.headers['Authorization'] = 'Bearer $accessToken';
      request.fields['id_ruangan'] = idUser.toString();
      request.fields['nama_container'] = _titleController.text;

      if (galleryFile != null) {
        var multipartFile = await http.MultipartFile.fromPath(
            'gambar_container', galleryFile!.path);
        request.files.add(multipartFile);
      }

      // Debug prints to verify request details
      debugPrint('Request URL: ${request.url}');
      debugPrint('Request Fields: ${request.fields}');
      debugPrint('Request Files: ${request.files}');

      var response = await request.send();
      if (response.statusCode == 200) {
        debugPrint('Menu updated successfully!');
        push();
      } else {
        debugPrint('Error updating menu: ${response.statusCode}');
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
                  "Edit Container",
                  style: GoogleFonts.poppins(
                    fontSize: 32,
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  "Isi Form Ruangan untuk mengedit container!",
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
                                  ? (widget
                                          .containers.gambarContainer.isNotEmpty
                                      ? Image.network(
                                          "${Endpoints.baseUAS}/static/img/${widget.containers.gambarContainer}")
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
                                hintText: "Nama Container",
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
                          final tokenContainer = context.read<AuthCubit>().state.accessToken;
                          _updateDataWithImage(
                              context, widget.containers.idContainer, tokenContainer!);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Semua Field Harus Terisi!')));
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
