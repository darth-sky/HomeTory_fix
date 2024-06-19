import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hometory/cubit/barang_dlm_ruangan/cubit/barang_dlm_ruangan_cubit.dart';
import 'package:hometory/cubit/container/cubit/containers_cubit.dart';
import 'package:hometory/cubit/ruangan_cubit.dart';
import 'package:hometory/dto/barang_dlm_ruangan.dart';
import 'package:hometory/dto/lokasiBrgRuangan.dart';
import 'package:hometory/endpoints/endpoints.dart';
import 'package:hometory/screens/editBarangRuangan.dart';
import 'package:hometory/screens/insideRuangan.dart';
import 'package:hometory/services/data_services.dart';

class InsideBarangDlmRuangan extends StatefulWidget {
  const InsideBarangDlmRuangan({
    super.key,
    required this.idInsideBarangDlmRuangan,
    required this.idRuangan,
    required this.currentPages,
  });

  final int idInsideBarangDlmRuangan;
  final int idRuangan;
  final int currentPages;

  @override
  _InsideBarangDlmRuanganState createState() => _InsideBarangDlmRuanganState();
}

class _InsideBarangDlmRuanganState extends State<InsideBarangDlmRuangan> {
  Future<List<locationBrgRuangan>>? _location;

  @override
  void initState() {
    super.initState();
    debugPrint('dibawah print');
    debugPrint(widget.idInsideBarangDlmRuangan.toString());
    debugPrint(widget.idRuangan.toString());
    debugPrint('ini currentpages ${widget.currentPages.toString()}');
    context.read<RuanganCubit>().fetchRuanganCubit();
    context.read<ContainersCubit>().fetchContainersCubit();
    context.read<BarangDlmRuanganCubit>().fetchBarangDlmRuanganCubit(
        widget.currentPages, '', widget.idRuangan, 1);
    _location = DataService.fetchBrgRuanganLocation(
        widget.idInsideBarangDlmRuangan.toString());
  }

  @override
  Widget build(BuildContext context) {
    int? idBarangDlmRuangan = widget.idInsideBarangDlmRuangan;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Barang'),
        backgroundColor: Colors.blueGrey,
        actions: [
          IconButton(
            onPressed: () {
              DataService.deleteBarangDlmRuangan(idBarangDlmRuangan!);
              idBarangDlmRuangan = null;
              context.read<BarangDlmRuanganCubit>().fetchBarangDlmRuanganCubit(
                  widget.currentPages, "", idBarangDlmRuangan, 1);
              Navigator.pop(context);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      InsideRuangan(idInsideRuangan: widget.idRuangan),
                ),
              );
            },
            icon: const Icon(Icons.delete_sharp),
          ),
          BlocBuilder<BarangDlmRuanganCubit, BarangDlmRuanganState>(
            builder: (context, state) {
              Barang_dlm_ruangan? filterBarangRuangan;
              String imageUrl = 'assets/images/pfp.jpg'; // Default image
              if (idBarangDlmRuangan != null) {
                filterBarangRuangan = state.ListOfBarang_dlm_ruangan.firstWhere(
                    (element) =>
                        element.id_barang_dlm_ruangan == idBarangDlmRuangan);
                imageUrl = Uri.parse(
                        '${Endpoints.baseUAS}/static/img/${filterBarangRuangan.gambar_barang_dlm_ruangan}')
                    .toString();
              }
              return IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditBarangRuangan(
                        barangDlmRuangan: filterBarangRuangan!,
                      ),
                    ),
                  );
                },
                icon: const Icon(Icons.edit),
              );
            },
          ),
        ],
      ),
      body: BlocBuilder<BarangDlmRuanganCubit, BarangDlmRuanganState>(
        builder: (context, state) {
          Barang_dlm_ruangan? filterBarangDlmRuangan;
          String imageUrl = 'assets/images/pfp.jpg'; // Default image
          if (idBarangDlmRuangan != null) {
            filterBarangDlmRuangan = state.ListOfBarang_dlm_ruangan.firstWhere(
                (element) =>
                    element.id_barang_dlm_ruangan == idBarangDlmRuangan);
            imageUrl = Uri.parse(
                    '${Endpoints.baseUAS}/static/img/${filterBarangDlmRuangan.gambar_barang_dlm_ruangan}')
                .toString();
          } else {
            return const SizedBox(
              height: 10,
            );
          }

          return Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/bg 1.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12.0),
                        child: Image.network(
                          imageUrl,
                          height: 200,
                          width: double.infinity,
                          fit: BoxFit.fitHeight,
                          errorBuilder: (context, error, stackTrace) =>
                              const Icon(Icons.error),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    FutureBuilder<List<locationBrgRuangan>>(
                      future: _location,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          final data = snapshot.data!;
                          return Container(
                            // Tambahkan Container sebagai parent
                            height:
                                30, // Atur tinggi Container sesuai kebutuhan
                            child: ListView.builder(
                              itemCount: data.length,
                              itemBuilder: (context, index) {
                                final item = data[index];
                                return Row(
                                  children: [
                                    Text(
                                      'Lokasi: ${item.nama_ruangan}',
                                      style: TextStyle(
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
                        return Center(
                            child:
                                CircularProgressIndicator()); // Tambahkan Center jika perlu
                      },
                    ),
                    const SizedBox(height: 16.0),
                    Card(
                      color: Colors.white.withOpacity(0.8),
                      elevation: 8.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              filterBarangDlmRuangan!.nama_barang_dlm_ruangan,
                              style: TextStyle(
                                fontSize: 24.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.blueGrey.shade900,
                              ),
                            ),
                            const SizedBox(height: 8.0),
                            Text(
                              filterBarangDlmRuangan
                                  .category_barang_dlm_ruangan,
                              style: TextStyle(
                                fontSize: 18.0,
                                color: Colors.blueGrey.shade600,
                              ),
                            ),
                            const Divider(
                              height: 32.0,
                              thickness: 1.0,
                              color: Colors.black,
                            ),
                            Text(
                              'Description',
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.blueGrey.shade900,
                              ),
                            ),
                            const SizedBox(height: 8.0),
                            Text(
                              filterBarangDlmRuangan.desc_barang_dlm_ruangan,
                              style: TextStyle(
                                fontSize: 16.0,
                                color: Colors.blueGrey.shade600,
                              ),
                            ),
                            const Divider(
                              height: 32.0,
                              thickness: 1.0,
                              color: Colors.black,
                            ),
                            const SizedBox(height: 16.0),
                            Text(
                              'Quantity',
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.blueGrey.shade900,
                              ),
                            ),
                            const SizedBox(height: 8.0),
                            Text(
                              filterBarangDlmRuangan.qnty_barang_dlm_ruangan
                                  .toString(),
                              style: TextStyle(
                                fontSize: 16.0,
                                color: Colors.blueGrey.shade600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
