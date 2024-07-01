// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hometory/cubit/auth/cubit/auth_cubit.dart';
import 'package:hometory/cubit/barang_dlm_container/cubit/barang_dlm_container_cubit.dart';
import 'package:hometory/cubit/container/cubit/containers_cubit.dart';
import 'package:hometory/cubit/ruangan_cubit.dart';
import 'package:hometory/dto/barang_dlm_container.dart';
import 'package:hometory/dto/lokasi_brg_container.dart';
import 'package:hometory/endpoints/endpoints.dart';
import 'package:hometory/screens/edit_barang_container.dart';
import 'package:hometory/services/data_services.dart';

class InsideBarangDlmContainer extends StatefulWidget {
  const InsideBarangDlmContainer({
    super.key,
    required this.idInsideBarangDlmContainer,
    required this.idContainer,
    required this.currentPages,
  });

  final int idInsideBarangDlmContainer;
  final int idContainer;
  final int currentPages;

  @override
  State<InsideBarangDlmContainer> createState() =>
      _InsideBarangDlmContainerState();
}

class _InsideBarangDlmContainerState extends State<InsideBarangDlmContainer> {
  Future<List<LocationBrgContainer>>? _locationbarangContainer;

  @override
  void initState() {
    super.initState();
    debugPrint('dibawah print');
    debugPrint(widget.idInsideBarangDlmContainer.toString());
    debugPrint(widget.idContainer.toString());
    debugPrint('ini currentpages ${widget.currentPages.toString()}');
    final accessToken = context.read<AuthCubit>().state.accessToken;
    context.read<RuanganCubit>().fetchRuanganCubit(accessToken!);
    context.read<ContainersCubit>().fetchContainersCubit(accessToken);
    final idPengguna = context.read<AuthCubit>().state.idPengguna;
    context.read<BarangDlmContainerCubit>().fetchBarangDlmContainerCubit(
        widget.currentPages, '', widget.idContainer, idPengguna!);
    _locationbarangContainer = DataService.fetchBrgContainerLocation(
        widget.idInsideBarangDlmContainer.toString());
  }

  void _deleteBarang(int idBarangDlmContainer) async {
    final accessToken = context.read<AuthCubit>().state.accessToken;
    await DataService.deleteBarangDlmContainer(idBarangDlmContainer, accessToken!);
    _fetchBarangContainer();
  }

  void _fetchBarangContainer() {
    final idPengguna = context.read<AuthCubit>().state.idPengguna;
    context.read<BarangDlmContainerCubit>().fetchBarangDlmContainerCubit(
        widget.currentPages, '', widget.idContainer, idPengguna!);
  }

  @override
  Widget build(BuildContext context) {
    int? idBarangDlmContainer = widget.idInsideBarangDlmContainer;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Barang dalam Container'),
        backgroundColor: Colors.blueGrey,
        actions: [
          IconButton(
            onPressed: () async {
              // Tampilkan dialog konfirmasi
              final confirmDelete = await showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Konfirmasi Hapus'),
                    content: const Text(
                        'Apakah Anda yakin ingin menghapus barang ini?'),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(false),
                        child: const Text('Batal'),
                      ),
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(true),
                        child: const Text('Hapus'),
                      ),
                    ],
                  );
                },
              );

              // Jika pengguna memilih untuk menghapus, lakukan aksi penghapusan
              if (confirmDelete == true) {
                _deleteBarang(idBarangDlmContainer!);
                // ignore: use_build_context_synchronously
                Navigator.pop(context);
                idBarangDlmContainer = null;
              }
            },
            icon: const Icon(Icons.delete_sharp),
          ),
          BlocBuilder<BarangDlmContainerCubit, BarangDlmContainerState>(
            builder: (context, state) {
              BarangDlmContainer? filterBarangContainer;
              // String imageUrl = 'assets/images/pfp.jpg'; // Default image
              if (idBarangDlmContainer != null) {
                filterBarangContainer = state.listOfBarangDlmContainerByUser
                    .firstWhere((element) =>
                        element.idBarangDlmContainer == idBarangDlmContainer);
                // imageUrl = Uri.parse(
                //         '${Endpoints.baseUAS}/static/img/${filterBarangContainer.gambarBarangDlmContainer}')
                //     .toString();
              } else {
                return const SizedBox();
              }
              return IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditBarangContainer(
                        barangDlmContainer: filterBarangContainer!,
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
      body: BlocBuilder<BarangDlmContainerCubit, BarangDlmContainerState>(
        builder: (context, state) {
          BarangDlmContainer? filterBarangDlmContainer;
          String imageUrl = 'assets/images/pfp.jpg'; // Default image
          if (idBarangDlmContainer != null) {
            filterBarangDlmContainer = state.listOfBarangDlmContainerByUser
                .firstWhere((element) =>
                    element.idBarangDlmContainer == idBarangDlmContainer);
            imageUrl = Uri.parse(
                    '${Endpoints.baseUAS}/static/img/${filterBarangDlmContainer.gambarBarangDlmContainer}')
                .toString();
          } else {
            return const SizedBox();
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
                    FutureBuilder<List<LocationBrgContainer>>(
                      future: _locationbarangContainer,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          final data = snapshot.data!;
                          return SizedBox(
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
                                      'Lokasi: ${item.namaRuangan} > ${item.namaContainer}',
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
                              filterBarangDlmContainer.namaBarangDlmContainer,
                              style: TextStyle(
                                fontSize: 24.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.blueGrey.shade900,
                              ),
                            ),
                            const SizedBox(height: 8.0),
                            Text(
                              filterBarangDlmContainer
                                  .categoryBarangDlmContainer,
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
                              filterBarangDlmContainer.descBarangDlmContainer,
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
                              filterBarangDlmContainer.qntyBarangDlmContainer
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
