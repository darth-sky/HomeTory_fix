import 'package:flutter/material.dart';

class TambahItemScreen extends StatefulWidget {
  const TambahItemScreen({Key? key}) : super(key: key);

  @override
  _TambahItemScreenState createState() => _TambahItemScreenState();
}

class _TambahItemScreenState extends State<TambahItemScreen> {
  TextEditingController _itemController = TextEditingController();
  TextEditingController _itemQtyController = TextEditingController();
  TextEditingController _descQtyController = TextEditingController();
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
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(10.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                  ),
                  minimumSize:
                      const Size(110.0, 30.0), 
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
                controller: _descQtyController,
                decoration: const InputDecoration(
                    labelText: 'Deskripsi', border: OutlineInputBorder()),
              ),
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