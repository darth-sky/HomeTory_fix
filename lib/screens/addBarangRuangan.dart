import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hometory/cubit/auth/cubit/auth_cubit.dart';
import 'package:hometory/cubit/barang_dlm_ruangan/cubit/barang_dlm_ruangan_cubit.dart';
import 'package:hometory/cubit/ruangan_cubit.dart';
import 'package:hometory/endpoints/endpoints.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';

class AddBarangRuangan extends StatefulWidget {
  const AddBarangRuangan({super.key, required this.idInsideRuangan});

  final int idInsideRuangan;

  @override
  _AddBarangRuanganState createState() => _AddBarangRuanganState();
}

class _AddBarangRuanganState extends State<AddBarangRuangan> {
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
  void dispose() {
    _BarangController.dispose();
    _descItemController.dispose();
    _itemQtyController.dispose();
    super.dispose();
  }

  saveData() {
    debugPrint(_title);
  }

  Future<void> _postDataWithImage(BuildContext context, int idUser) async {
    if (galleryFile == null) {
      return; // Handle case where no image is selected
    }

    var request = MultipartRequest('POST', Uri.parse(Endpoints.barangDlmRuanganCreate));
    debugPrint(idUser.toString());
    debugPrint(galleryFile!.path.toString());
    request.fields['id_ruangan'] = idUser.toString();
    request.fields['nama_barang_dlm_ruangan'] = _BarangController.text;
    request.fields['desc_barang_dlm_ruangan'] = _descItemController.text;
    request.fields['qnty_barang_dlm_ruangan'] = _itemQtyController.text;
    request.fields['category_barang_dlm_ruangan'] =
        _selectedCategory; // Add selected category

    var multipartFile = await MultipartFile.fromPath(
      'gambar_barang_dlm_ruangan',
      galleryFile!.path,
    );
    request.files.add(multipartFile);

    request.send().then((response) {
      // Handle response (success or error)
      if (response.statusCode == 201) {
        debugPrint('Data and image posted successfully!');
        context
            .read<BarangDlmRuanganCubit>()
            .fetchBarangDlmRuanganCubit(1, "", widget.idInsideRuangan);
        Navigator.pop(context);
        // Navigator.pushReplacementNamed(context, '/home-screen');
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Tambah Barang dalam Ruangan",
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
                                  ? Center(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const Icon(
                                            Icons.add_photo_alternate_outlined,
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
                        String barangRuanganName = _BarangController.text;
                        if (barangRuanganName.isNotEmpty) {
                          _postDataWithImage(context, widget.idInsideRuangan);
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
