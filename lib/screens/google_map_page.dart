import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hometory/dto/pengguna.dart';
import 'package:hometory/dto/totalBrgContainer.dart';
import 'package:hometory/dto/totalBrgRuangan.dart';
import 'package:hometory/dto/totalRuangan.dart';
import 'package:hometory/services/data_services.dart';

class GoogleMapPage extends StatefulWidget {
  final Pengguna? user;
  final int idPengguna;

  const GoogleMapPage({Key? key, required this.idPengguna, this.user})
      : super(key: key);

  @override
  _GoogleMapPageState createState() => _GoogleMapPageState();
}

class _GoogleMapPageState extends State<GoogleMapPage> {
  static const LatLng googlePlex = LatLng(37.4223, -122.0848);
  late LatLng currentHome;

  late Future<List<totalRuangan>> _totalRuangan;
  late Future<List<totalBrgContainer>> _totalBrgContainer;
  late Future<List<totalBrgRuangan>> _totalBrgRuangan;

  @override
  void initState() {
    super.initState();
    currentHome = widget.user != null
        ? LatLng(widget.user!.latitude, widget.user!.longtitude)
        : googlePlex;
    _totalRuangan = DataService.fetchTotalRuangan(widget.idPengguna.toString());
    _totalBrgContainer =
        DataService.fetchTotalBrgContainer(widget.idPengguna.toString());
    _totalBrgRuangan =
        DataService.fetchTotalBrgRuangan(widget.idPengguna.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Status Properti"),
        backgroundColor: Colors.blueGrey,
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/bg 2.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Expanded(
            //   child: Padding(
            //     padding: const EdgeInsets.all(8.0),
            //     child: ClipRRect(
            //       borderRadius: BorderRadius.circular(15.0),
            //       child: GoogleMap(
            //         initialCameraPosition:
            //             CameraPosition(target: currentHome, zoom: 13),
            //         markers: {
            //           Marker(
            //             markerId: const MarkerId('currentHome'),
            //             position: currentHome,
            //             icon: BitmapDescriptor.defaultMarker,
            //           ),
            //         },
            //       ),
            //     ),
            //   ),
            // ),
            Expanded(
              child: GoogleMap(
                initialCameraPosition:
                    CameraPosition(target: currentHome, zoom: 13),
                markers: {
                  Marker(
                    markerId: const MarkerId('currentHome'),
                    position: currentHome,
                    icon: BitmapDescriptor.defaultMarker,
                  ),
                },
              ),
            ),

            _buildSection(
              title: 'Total Ruangan',
              future: _totalRuangan,
              itemBuilder: (context, index, item) {
                return ListTile(
                  title: Text(
                    'Jumlah Ruangan: ${item.jumlah_ruangan}',
                    style: const TextStyle(fontSize: 16.0, color: Colors.black),
                  ),
                  leading: const Icon(Icons.room, color: Colors.blueGrey),
                );
              },
            ),
            _buildSection(
              title: 'Total Barang Dalam Container',
              future: _totalBrgContainer,
              itemBuilder: (context, index, item) {
                return ListTile(
                  title: Text(
                    'Jumlah Barang Container: ${item.jumlah_barang_container}',
                    style: const TextStyle(fontSize: 16.0, color: Colors.black),
                  ),
                  leading: const Icon(Icons.storage, color: Colors.blueGrey),
                );
              },
            ),
            _buildSection(
              title: 'Total Barang Dalam Ruangan',
              future: _totalBrgRuangan,
              itemBuilder: (context, index, item) {
                return ListTile(
                  title: Text(
                    'Jumlah Barang Ruangan: ${item.jumlah_barang_ruangan}',
                    style: const TextStyle(fontSize: 16.0, color: Colors.black),
                  ),
                  leading: const Icon(Icons.home, color: Colors.blueGrey),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required Future<List<dynamic>> future,
    required Widget Function(BuildContext, int, dynamic) itemBuilder,
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              title,
              style:
                  const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
          ),
          FutureBuilder<List<dynamic>>(
            future: future,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final data = snapshot.data!;
                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: data.length,
                  itemBuilder: (context, index) =>
                      itemBuilder(context, index, data[index]),
                );
              } else if (snapshot.hasError) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Error: ${snapshot.error}"),
                );
              }
              return const Center(child: CircularProgressIndicator());
            },
          ),
        ],
      ),
    );
  }
}
