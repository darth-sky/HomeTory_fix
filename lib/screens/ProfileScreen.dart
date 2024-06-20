import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hometory/cubit/auth/cubit/auth_cubit.dart';
import 'package:hometory/dto/pengguna.dart';
import 'package:hometory/endpoints/endpoints.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:http/http.dart' as http;

class ProfileScreen extends StatefulWidget {
  Pengguna? pengguna;
  ProfileScreen({
    super.key,
    this.pengguna,
    // required this.idInsideRuangan
  });

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  File? _image;
  // final _usernameController = TextEditingController();
  late TextEditingController _emailController = TextEditingController();
  late TextEditingController _longitudeController = TextEditingController();
  late TextEditingController _latitudeController = TextEditingController();

  File? galleryFile;
  final picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    // _BarangController = TextEditingController(
    //     text: widget.barangDlmContainer.nama_barang_dlm_container);
    // _descItemController = TextEditingController(
    //     text: widget.barangDlmContainer.desc_barang_dlm_container);
    // _itemQtyController = TextEditingController(
    //     text: widget.barangDlmContainer.qnty_barang_dlm_container.toString());
    // _selectedCategory = widget.barangDlmContainer.category_barang_dlm_container;
    _emailController = TextEditingController(text: widget.pengguna!.email);
    _longitudeController =
        TextEditingController(text: widget.pengguna!.longtitude.toString());
    _latitudeController =
        TextEditingController(text: widget.pengguna!.latitude.toString());
  }

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
    _emailController.dispose();
    _longitudeController.dispose();
    _latitudeController.dispose();
    super.dispose();
  }

  Future<void> _updateDataWithImage(BuildContext context) async {
    try {
      final idPengguna = context.read<AuthCubit>().state.idPengguna;
      var request = http.MultipartRequest(
          'PUT', Uri.parse('${Endpoints.userUpdate}/$idPengguna'));
      request.fields['email'] = _emailController.text;
      request.fields['longtitude'] = _longitudeController.text;
      request.fields['latitude'] = _latitudeController.text;

      if (galleryFile != null) {
        var multipartFile =
            await http.MultipartFile.fromPath('foto_profil', galleryFile!.path);
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
        // Navigator.pushReplacement(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => InsideBarangDlmContainer(
        //       idContainer: widget.barangDlmContainer.id_container,
        //       idInsideBarangDlmContainer:
        //           widget.barangDlmContainer.id_barang_dlm_container,
        //       currentPages: 1,
        //     ),
        //   ),
        // );
        Navigator.pop(context);
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
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: Colors.blueGrey,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              GestureDetector(
                onTap: () {
                  _showPicker(context: context);
                },
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: _image != null ? FileImage(_image!) : null,
                  child: _image == null
                      ? const Icon(
                          Icons.camera_alt,
                          size: 50,
                        )
                      : null,
                ),
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _longitudeController,
                decoration: const InputDecoration(
                  labelText: 'Longitude',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your longitude';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _latitudeController,
                decoration: const InputDecoration(
                  labelText: 'Latitude',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your latitude';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  // if (_formKey.currentState!.validate()) {
                  //   // Process data
                  //   ScaffoldMessenger.of(context).showSnackBar(
                  //     const SnackBar(content: Text('Processing Data')),
                  //   );
                  // }
                  _updateDataWithImage(
                    context,
                  );
                },
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
