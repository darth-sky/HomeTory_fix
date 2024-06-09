
import 'package:flutter/material.dart';

class TambahContainerScreen extends StatefulWidget {
  const TambahContainerScreen({Key? key}) : super(key: key);

  @override
  _TambahContainerScreenState createState() => _TambahContainerScreenState();
}

class _TambahContainerScreenState extends State<TambahContainerScreen> {
  TextEditingController _containerController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Container'),
        backgroundColor: Colors.blueGrey,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(10.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                  ),
                  minimumSize:
                      const Size(110.0, 30.0), // Sesuaikan dengan keinginan Anda
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
                controller: _containerController,
                decoration: const InputDecoration(
                  labelText: 'Nama Container',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {},
                child: const Text('Tambah'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
