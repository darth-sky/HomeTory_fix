import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hometory/cubit/auth/cubit/auth_cubit.dart';
import 'package:hometory/cubit/barang_dlm_ruangan/cubit/barang_dlm_ruangan_cubit.dart';
import 'package:hometory/endpoints/endpoints.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';

class TambahItemScreen extends StatefulWidget {
  const TambahItemScreen({super.key, required this.idInsideRuangan});

  final int idInsideRuangan;

  @override
  _TambahItemScreenState createState() => _TambahItemScreenState();
}

class _TambahItemScreenState extends State<TambahItemScreen> {
  TextEditingController _itemController = TextEditingController();
  TextEditingController _itemQtyController = TextEditingController();
  TextEditingController _descItemController = TextEditingController();

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
        MultipartRequest('POST', Uri.parse(Endpoints.barangDlmRuanganCreate));
    debugPrint(idUser.toString());
    debugPrint(galleryFile!.path.toString());
    debugPrint(_itemController.text);
    request.fields['id_ruangan'] = idUser.toString();
    request.fields['nama_barang_dlm_ruangan'] = _itemController.text;
    request.fields['desc_barang_dlm_ruangan'] = _descItemController.text;
    request.fields['qnty_barang_dlm_ruangan'] = _itemQtyController.text;

    var multipartFile = await MultipartFile.fromPath(
      'gambar_barang_dlm_ruangan',
      galleryFile!.path,
    );
    request.files.add(multipartFile);

    request.send().then((response) {
      // Handle response (success or error)
      if (response.statusCode == 201) {
        debugPrint('Data and image posted successfully!');
        context.read<BarangDlmRuanganCubit>().fetchBarangDlmRuanganCubit();
        Navigator.pop(context);
        // Navigator.pushReplacementNamed(context, '/inside-ruangan');
        // Navigator.pushReplacement(context,
        //                 MaterialPageRoute(builder: (context) => InsideRuangan(idInsideRuangan: ,)));
      } else {
        debugPrint('Error posting data: ${response.statusCode}');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Item'),
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
                  minimumSize: const Size(110.0, 30.0),
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
                controller: _itemController,
                decoration: const InputDecoration(
                  labelText: 'Nama Item',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _itemQtyController,
                decoration: const InputDecoration(
                    labelText: 'Quantity', border: OutlineInputBorder()),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _descItemController,
                decoration: const InputDecoration(
                    labelText: 'Deskripsi', border: OutlineInputBorder()),
              ),
              ElevatedButton(
                    onPressed: () {
                      String itemName = _itemController.text;
                      if (itemName.isNotEmpty) {
                        _postDataWithImage(context, widget.idInsideRuangan);
                      }
                    },
                    child: const Text('Save'),
                  ),
            ],
          ),
        ),
      ),
    );
  }
}
