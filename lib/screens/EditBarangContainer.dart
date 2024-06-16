import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hometory/cubit/auth/cubit/auth_cubit.dart';
import 'package:hometory/cubit/barang_dlm_ruangan/cubit/barang_dlm_ruangan_cubit.dart';
import 'package:hometory/cubit/ruangan_cubit.dart';
import 'package:hometory/dto/barang_dlm_container.dart';
import 'package:hometory/dto/barang_dlm_ruangan.dart';
import 'package:hometory/endpoints/endpoints.dart';
import 'package:hometory/screens/insideBarangContainer.dart';
import 'package:hometory/screens/insideBarangDlmRuangan.dart';
import 'package:hometory/screens/insideContainer.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';

class EditBarangContainer extends StatefulWidget {
  final Barang_dlm_container barangDlmContainer;
  // final int idInsideRuangan;
  const EditBarangContainer({
    super.key,
    required this.barangDlmContainer,
    // required this.idInsideRuangan
  });

  @override
  _EditBarangContainerState createState() => _EditBarangContainerState();
}

class _EditBarangContainerState extends State<EditBarangContainer> {
  TextEditingController _BarangController = TextEditingController();
  TextEditingController _itemQtyController = TextEditingController();
  TextEditingController _descItemController = TextEditingController();
  String _title = "";

  String _selectedCategory = 'lain-lain';

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
  void initState() {
    super.initState();
    _BarangController = TextEditingController(
        text: widget.barangDlmContainer.nama_barang_dlm_container);
    _descItemController = TextEditingController(
        text: widget.barangDlmContainer.desc_barang_dlm_container);
    _itemQtyController = TextEditingController(
        text: widget.barangDlmContainer.qnty_barang_dlm_container.toString());
    _selectedCategory = widget.barangDlmContainer.category_barang_dlm_container;
  }

  @override
  void dispose() {
    _BarangController.dispose();
    _descItemController.dispose();
    _itemQtyController.dispose();
    super.dispose();
  }

  saveData() {
    debugPrint(_title);
  }

  Future<void> _updateDataWithImage(BuildContext context, int idUser) async {
    try {
      var request = http.MultipartRequest(
          'POST',
          Uri.parse(
              '${Endpoints.barangDlmContainerUpdate}/${widget.barangDlmContainer.id_barang_dlm_container}'));
      request.fields['id_container'] = idUser.toString();
      request.fields['nama_barang_dlm_container'] = _BarangController.text;
      request.fields['desc_barang_dlm_container'] = _descItemController.text;
      request.fields['qnty_barang_dlm_container'] = _itemQtyController.text;
      request.fields['category_barang_dlm_container'] =
          _selectedCategory; // Add selected category

      if (galleryFile != null) {
        var multipartFile = await http.MultipartFile.fromPath(
            'gambar_barang_dlm_container', galleryFile!.path);
        request.files.add(multipartFile);
      }

      // Debug prints to verify request details
      debugPrint('Request URL: ${request.url}');
      debugPrint('Request Fields: ${request.fields}');
      debugPrint('Request Files: ${request.files}');

      var response = await request.send();
      if (response.statusCode == 200) {
        debugPrint('Menu updated successfully!');
        // Navigator.pushReplacementNamed(context, '/home-screen');
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => InsideBarangDlmContainer(
              idContainer: widget.barangDlmContainer.id_container,
              idInsideBarangDlmContainer: widget.barangDlmContainer.id_barang_dlm_container,
              currentPages: 1,
            ),
          ),
        );
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
                  "Edit Barang dalam Ruangan",
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  "Isi Form Ruangan untuk menambah barang dalam ruangan!",
                  style: GoogleFonts.poppins(
                    fontSize: 10,
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
                                  ? (widget.barangDlmContainer
                                          .gambar_barang_dlm_container.isNotEmpty
                                      ? Image.network(
                                          "${Endpoints.baseUAS}/static/img/${widget.barangDlmContainer.gambar_barang_dlm_container}")
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
                              controller: _BarangController,
                              decoration: const InputDecoration(
                                hintText: "Nama Barang dalam Ruangan",
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
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: const BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(color: Colors.black)),
                            ),
                            child: TextField(
                              controller: _descItemController,
                              decoration: const InputDecoration(
                                hintText: "Deskripsi Barang dalam Ruangan",
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
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: const BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(color: Colors.black)),
                            ),
                            child: TextField(
                              controller: _itemQtyController,
                              decoration: const InputDecoration(
                                hintText: "Quantity Barang dalam Ruangan",
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
                          const SizedBox(
                            height: 10,
                          ),
                          DropdownButtonFormField<String>(
                            value: _selectedCategory,
                            onChanged: (String? newValue) {
                              setState(() {
                                _selectedCategory = newValue!;
                              });
                            },
                            items: <String>[
                              'lain-lain',
                              'elektronik',
                              'perabotan rumah tangga',
                              'perabotan kamar mandi'
                            ].map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            decoration: const InputDecoration(
                              labelText: 'Category',
                              border: OutlineInputBorder(),
                            ),
                          ),
                          const SizedBox(height: 10),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        String barangContainerName = _BarangController.text;
                        if (barangContainerName.isNotEmpty) {
                          _updateDataWithImage(context,
                              widget.barangDlmContainer.id_barang_dlm_container);
                        }
                      },
                      child: const Text('Save'),
                    ),
                    const SizedBox(height: 20),
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
