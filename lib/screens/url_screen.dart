import 'package:flutter/material.dart';
import 'package:hometory/endpoints/endpoints.dart';
import 'package:hometory/utils/secure_storage_util.dart';

class InputUrlPage extends StatefulWidget {
  const InputUrlPage({super.key});

  @override
  State<InputUrlPage> createState() => _InputUrlPageState();
}

class _InputUrlPageState extends State<InputUrlPage> {
  final _urlController = TextEditingController();

  @override
  void dispose() {
    _urlController.dispose();
    super.dispose();
  }

  void sendUrl() async {
    if (_urlController.text.isNotEmpty) {
      await SecureStorageUtil.storage
          .write(key: "url_setting", value: _urlController.text);
      await Endpoints.initialize();
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Input saved: ${_urlController.text}')),
      );
      _urlController.clear();
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter the url')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Input Url',
            style: TextStyle(fontWeight: FontWeight.bold),
            
          ),
          backgroundColor: Colors.blueGrey,
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 60,),
                const SizedBox(
                  height: 50,
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextField(
                        controller: _urlController,
                        decoration: InputDecoration(
                          hintText: 'Masukkan URL API',
                          filled: true,
                          fillColor: Colors.grey[100],
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 15, horizontal: 20),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide.none,
                          ),
                          prefixIcon:
                              const Icon(Icons.settings_input_antenna),
                        ),
                        style: const TextStyle(fontSize: 18),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          sendUrl();
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.symmetric(vertical: 16),
                          child: Text(
                            'Submit',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                
                                ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
// import 'package:flutter/material.dart';
// import 'package:hometory/endpoints/endpoints.dart';
// import 'package:hometory/utils/secure_storage_util.dart';

// class UrlScreen extends StatefulWidget {
//   const UrlScreen({super.key});

//   @override
//   State<UrlScreen> createState() => _UrlScreenState();
// }

// class _UrlScreenState extends State<UrlScreen> {
//   final TextEditingController _urlController = TextEditingController();

//   void _submitUrl() async {
//     final url = _urlController.text;
//     await SecureStorageUtil.storage.write(key: 'url_setting', value: url);
//     await Endpoints.initialize();
//     push();
//   }

//   void push() {
//     Navigator.pop(context);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Enter Url'),
//         backgroundColor: Colors.blueGrey,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             TextField(
//               controller: _urlController,
//               decoration: const InputDecoration(
//                 labelText: 'URL',
//                 border: OutlineInputBorder(),
//               ),
//               keyboardType: TextInputType.url,
//             ),
//             const SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: _submitUrl,
//               child: const Text('Submit'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
