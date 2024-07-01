// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:hometory/endpoints/endpoints.dart';
// import 'package:http/http.dart';
// import 'package:image_picker/image_picker.dart';

// class TambahbarangDlmContainer extends StatefulWidget {
//   const TambahbarangDlmContainer({super.key, required this.idInsideContainer});

//   final int idInsideContainer;

//   @override
//   _TambahbarangDlmContainerState createState() =>
//       _TambahbarangDlmContainerState();
// }

// class _TambahbarangDlmContainerState extends State<TambahbarangDlmContainer> {
//   TextEditingController _itemController = TextEditingController();
//   TextEditingController _itemQtyController = TextEditingController();
//   TextEditingController _descItemController = TextEditingController();
  
//   String _selectedCategory = 'lain-lain';

//   File? galleryFile;
//   final picker = ImagePicker();

//   _showPicker({
//     required BuildContext context,
//   }) {
//     showModalBottomSheet(
//       context: context,
//       builder: (BuildContext context) {
//         return SafeArea(
//           child: Wrap(
//             children: <Widget>[
//               ListTile(
//                 leading: const Icon(Icons.photo_library),
//                 title: const Text('Photo Library'),
//                 onTap: () {
//                   getImage(ImageSource.gallery);
//                   Navigator.of(context).pop();
//                 },
//               ),
//               ListTile(
//                 leading: const Icon(Icons.photo_camera),
//                 title: const Text('Camera'),
//                 onTap: () {
//                   getImage(ImageSource.camera);
//                   Navigator.of(context).pop();
//                 },
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }

//   Future getImage(
//     ImageSource img,
//   ) async {
//     final pickedFile = await picker.pickImage(source: img);
//     XFile? xfilePick = pickedFile;
//     setState(
//       () {
//         if (xfilePick != null) {
//           galleryFile = File(pickedFile!.path);
//         } else {
//           ScaffoldMessenger.of(context).showSnackBar(
//               const SnackBar(content: Text('Nothing is selected')));
//         }
//       },
//     );
//   }

//   Future<void> _postDataWithImage(BuildContext context, int idUser) async {
//     if (galleryFile == null) {
//       return; // Handle case where no image is selected
//     }

//     var request =
//         MultipartRequest('POST', Uri.parse(Endpoints.barangDlmContainerCreate));
//     debugPrint(idUser.toString());
//     debugPrint(galleryFile!.path.toString());
//     debugPrint(_itemController.text);
//     request.fields['id_container'] = idUser.toString();
//     request.fields['nama_barang_dlm_container'] = _itemController.text;
//     request.fields['desc_barang_dlm_container'] = _descItemController.text;
//     request.fields['qnty_barang_dlm_container'] = _itemQtyController.text;
//     request.fields['category_barang_dlm_container'] = _selectedCategory; // Add selected category

//     var multipartFile = await MultipartFile.fromPath(
//       'gambar_barang_dlm_container',
//       galleryFile!.path,
//     );
//     request.files.add(multipartFile);

//     request.send().then((response) {
//       // Handle response (success or error)
//       if (response.statusCode == 201) {
//         debugPrint('Data and image posted successfully!');
//         // context.read<BarangDlmRuanganCubit>().fetchBarangDlmRuanganCubit();
//         // context.read<BarangDlmContainerCubit>().fetchBarangDlmContainerCubit();
//         Navigator.pop(context);
//         // Navigator.pushReplacementNamed(context, '/inside-ruangan');
//         // Navigator.pushReplacement(context,
//         //                 MaterialPageRoute(builder: (context) => InsideRuangan(idInsideRuangan: ,)));
//       } else {
//         debugPrint('Error posting data: ${response.statusCode}');
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Tambah barang container'),
//         backgroundColor: Colors.blueGrey,
//       ),
//       body: Center(
//         child: Padding(
//           padding: const EdgeInsets.all(20.0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               ElevatedButton(
//                 onPressed: () {
//                   _showPicker(context: context);
//                 },
//                 style: ElevatedButton.styleFrom(
//                   padding: const EdgeInsets.all(10.0),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(18.0),
//                   ),
//                   minimumSize: const Size(110.0, 30.0),
//                 ),
//                 child: const Icon(
//                   Icons.camera_alt,
//                   size: 50.0,
//                 ),
//               ),
//               const SizedBox(
//                 height: 10,
//               ),
//               DropdownButtonFormField<String>(
//                 value: _selectedCategory,
//                 onChanged: (String? newValue) {
//                   setState(() {
//                     _selectedCategory = newValue!;
//                   });
//                 },
//                 items: <String>[
//                   'lain-lain',
//                   'elektronik',
//                   'perabotan rumah tangga',
//                   'perabotan kamar mandi'
//                 ].map<DropdownMenuItem<String>>((String value) {
//                   return DropdownMenuItem<String>(
//                     value: value,
//                     child: Text(value),
//                   );
//                 }).toList(),
//                 decoration: const InputDecoration(
//                   labelText: 'Category',
//                   border: OutlineInputBorder(),
//                 ),
//               ),
//               const SizedBox(height: 20),
//               TextField(
//                 controller: _itemController,
//                 decoration: const InputDecoration(
//                   labelText: 'Nama Item',
//                   border: OutlineInputBorder(),
//                 ),
//               ),
//               const SizedBox(height: 20),
//               TextField(
//                 controller: _itemQtyController,
//                 decoration: const InputDecoration(
//                     labelText: 'Quantity', border: OutlineInputBorder()),
//               ),
//               const SizedBox(height: 20),
//               TextField(
//                 controller: _descItemController,
//                 decoration: const InputDecoration(
//                     labelText: 'Deskripsi', border: OutlineInputBorder()),
//               ),
//               ElevatedButton(
//                 onPressed: () {
//                   String itemName = _itemController.text;
//                   if (itemName.isNotEmpty) {
//                     _postDataWithImage(context, widget.idInsideContainer);
//                   }
//                 },
//                 child: const Text('Save'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
