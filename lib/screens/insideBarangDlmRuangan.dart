import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hometory/cubit/barang_dlm_ruangan/cubit/barang_dlm_ruangan_cubit.dart';
import 'package:hometory/cubit/container/cubit/containers_cubit.dart';
import 'package:hometory/cubit/ruangan_cubit.dart';
import 'package:hometory/dto/barang_dlm_ruangan.dart';
import 'package:hometory/endpoints/endpoints.dart';

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
  @override
  void initState() {
    super.initState();
    debugPrint('dibawah print');
    debugPrint(widget.idInsideBarangDlmRuangan.toString());
    debugPrint(widget.idRuangan.toString());
    debugPrint('ini currentpages ${widget.currentPages.toString()}');
    context.read<RuanganCubit>().fetchRuanganCubit();
    context.read<ContainersCubit>().fetchContainersCubit();
    context
        .read<BarangDlmRuanganCubit>()
        .fetchBarangDlmRuanganCubit(widget.currentPages, '', widget.idRuangan);
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
                // Implement search functionality here
              },
              icon: const Icon(Icons.search)),
          IconButton(
              onPressed: () {
                // Implement edit functionality here
              },
              icon: const Icon(Icons.edit)),
        ],
      ),
      body: BlocBuilder<BarangDlmRuanganCubit, BarangDlmRuanganState>(
        builder: (context, state) {
          Barang_dlm_ruangan? filterBarangDlmRuangan;
          filterBarangDlmRuangan =
              state.ListOfBarang_dlm_ruangan.firstWhere((element) {
            debugPrint(
                'ini id barang dalam ruangan ${element.id_barang_dlm_ruangan.toString()}');
            return element.id_barang_dlm_ruangan == idBarangDlmRuangan;
          });
          String imageUrl = Uri.parse(
                  '${Endpoints.baseUAS}/static/img/${filterBarangDlmRuangan!.gambar_barang_dlm_ruangan}')
              .toString();

          return Container(
            color: Colors.white,
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
                    const Text(
                      'Kamar Mandi > Lemari',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.black,
                      ),
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
                              filterBarangDlmRuangan.nama_barang_dlm_ruangan,
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
