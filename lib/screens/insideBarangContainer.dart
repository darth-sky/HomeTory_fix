import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hometory/cubit/barang_dlm_container/cubit/barang_dlm_container_cubit.dart';
import 'package:hometory/cubit/barang_dlm_ruangan/cubit/barang_dlm_ruangan_cubit.dart';
import 'package:hometory/cubit/container/cubit/containers_cubit.dart';
import 'package:hometory/cubit/ruangan_cubit.dart';
import 'package:hometory/dto/barang_dlm_container.dart';
import 'package:hometory/dto/barang_dlm_ruangan.dart';
import 'package:hometory/dto/lokasiBrgContainer.dart';
import 'package:hometory/endpoints/endpoints.dart';
import 'package:hometory/screens/EditBarangContainer.dart';
import 'package:hometory/screens/editBarangRuangan.dart';
import 'package:hometory/screens/insideContainer.dart';
import 'package:hometory/screens/insideRuangan.dart';
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
  _InsideBarangDlmContainerState createState() =>
      _InsideBarangDlmContainerState();
}

class _InsideBarangDlmContainerState extends State<InsideBarangDlmContainer> {
  Future<List<locationBrgContainer>>? _locationbarangContainer;

  @override
  void initState() {
    super.initState();
    debugPrint('dibawah print');
    debugPrint(widget.idInsideBarangDlmContainer.toString());
    debugPrint(widget.idContainer.toString());
    debugPrint('ini currentpages ${widget.currentPages.toString()}');
    context.read<RuanganCubit>().fetchRuanganCubit();
    context.read<ContainersCubit>().fetchContainersCubit();
    context.read<BarangDlmContainerCubit>().fetchBarangDlmContainerCubit(
        widget.currentPages, '', widget.idContainer, 1);
    _locationbarangContainer = DataService.fetchBrgContainerLocation(
        widget.idInsideBarangDlmContainer.toString());
  }

  void _deleteBarang(int idBarangDlmContainer) async {
    await DataService.deleteBarangDlmContainer(idBarangDlmContainer!);
    context.read<BarangDlmContainerCubit>().fetchBarangDlmContainerCubit(
        widget.currentPages, '', widget.idContainer, 1);
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
            onPressed: () {
              _deleteBarang(idBarangDlmContainer!);
              Navigator.pop(context);
              idBarangDlmContainer = null;
            },
            icon: const Icon(Icons.delete_sharp),
          ),
          BlocBuilder<BarangDlmContainerCubit, BarangDlmContainerState>(
            builder: (context, state) {
              Barang_dlm_container? filterBarangContainer;
              String imageUrl = 'assets/images/pfp.jpg'; // Default image
              if (idBarangDlmContainer != null) {
                filterBarangContainer =
                    state.ListOfBarang_dlm_container.firstWhere((element) =>
                        element.id_barang_dlm_container ==
                        idBarangDlmContainer);
                imageUrl = Uri.parse(
                        '${Endpoints.baseUAS}/static/img/${filterBarangContainer.gambar_barang_dlm_container}')
                    .toString();
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
          Barang_dlm_container? filterBarangDlmContainer;
          String imageUrl = 'assets/images/pfp.jpg'; // Default image
          if (idBarangDlmContainer != null) {
            filterBarangDlmContainer =
                state.ListOfBarang_dlm_container.firstWhere((element) =>
                    element.id_barang_dlm_container == idBarangDlmContainer);
            imageUrl = Uri.parse(
                    '${Endpoints.baseUAS}/static/img/${filterBarangDlmContainer.gambar_barang_dlm_container}')
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
                    FutureBuilder<List<locationBrgContainer>>(
                      future: _locationbarangContainer,
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
                                      'Lokasi: ${item.nama_ruangan} > ${item.nama_container}',
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
                              filterBarangDlmContainer!
                                  .nama_barang_dlm_container,
                              style: TextStyle(
                                fontSize: 24.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.blueGrey.shade900,
                              ),
                            ),
                            const SizedBox(height: 8.0),
                            Text(
                              filterBarangDlmContainer
                                  .category_barang_dlm_container,
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
                              filterBarangDlmContainer
                                  .desc_barang_dlm_container,
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
                              filterBarangDlmContainer.qnty_barang_dlm_container
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
