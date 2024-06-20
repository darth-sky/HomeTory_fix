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
  static const googlePlex = LatLng(37.4223, -122.0848);
  Future<List<totalRuangan>>? _totalRuangan;
  Future<List<totalBrgContainer>>? _totalBrgContainer;
  Future<List<totalBrgRuangan>>? _totalBrgRuangan;

  LatLng? currentHome;

  @override
  void initState() {
    super.initState();
    if (widget.user != null) {
      currentHome = LatLng(widget.user!.latitude, widget.user!.longtitude);
    }
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
        title: const Text("hello google map"),
        backgroundColor: Colors.blueGrey,
      ),
      body: Column(
        children: [
          FutureBuilder<List<totalRuangan>>(
            future: _totalRuangan,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final data = snapshot.data!;
                return Container(
                  // Tambahkan Container sebagai parent
                  height: 30, // Atur tinggi Container sesuai kebutuhan
                  child: ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      final item = data[index];
                      return Row(
                        children: [
                          Text(
                            'Total Ruangan: ${item.jumlah_ruangan}',
                            style: const TextStyle(
                              fontSize: 16.0,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                );
              } else if (snapshot.hasError) {
                return Text("error lokasi: ${snapshot.error}");
              }
              return const Center(
                  child:
                      CircularProgressIndicator()); // Tambahkan Center jika perlu
            },
          ),
          FutureBuilder<List<totalBrgContainer>>(
            future: _totalBrgContainer,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final data = snapshot.data!;
                return Container(
                  // Tambahkan Container sebagai parent
                  height: 30, // Atur tinggi Container sesuai kebutuhan
                  child: ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      final item = data[index];
                      return Row(
                        children: [
                          Text(
                            'Total Barang Dalam Container: ${item.jumlah_barang_container}',
                            style: const TextStyle(
                              fontSize: 16.0,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                );
              } else if (snapshot.hasError) {
                return Text("error lokasi: ${snapshot.error}");
              }
              return const Center(
                  child:
                      CircularProgressIndicator()); // Tambahkan Center jika perlu
            },
          ),
          FutureBuilder<List<totalBrgRuangan>>(
            future: _totalBrgRuangan,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final data = snapshot.data!;
                return Container(
                  // Tambahkan Container sebagai parent
                  height: 30, // Atur tinggi Container sesuai kebutuhan
                  child: ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      final item = data[index];
                      return Row(
                        children: [
                          Text(
                            'Total Barang Dalam Ruangan: ${item.jumlah_barang_ruangan}',
                            style: const TextStyle(
                              fontSize: 16.0,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                );
              } else if (snapshot.hasError) {
                return Text("error lokasi: ${snapshot.error}");
              }
              return const Center(
                  child:
                      CircularProgressIndicator()); // Tambahkan Center jika perlu
            },
          ),
          Expanded(
            child: GoogleMap(
              initialCameraPosition:
                  CameraPosition(target: currentHome!, zoom: 13),
              markers: {
                Marker(
                  markerId: const MarkerId('currentHome'),
                  position: currentHome!,
                  icon: BitmapDescriptor.defaultMarker,
                )
              },
            ),
          ),
        ],
      ),
    );
  }
}
