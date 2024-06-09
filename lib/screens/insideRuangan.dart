import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hometory/components/barangWidget.dart';
import 'package:hometory/components/containerWidget.dart';
import 'package:hometory/cubit/barang_dlm_ruangan/cubit/barang_dlm_ruangan_cubit.dart';
import 'package:hometory/cubit/container/cubit/containers_cubit.dart';
import 'package:hometory/cubit/ruangan_cubit.dart';
import 'package:hometory/dto/barang_dlm_ruangan.dart';
import 'package:hometory/dto/containers.dart';
import 'package:hometory/dto/ruangan.dart';
import 'package:hometory/endpoints/endpoints.dart';
import 'package:hometory/screens/tambahcontainerscreen.dart';
import 'package:hometory/screens/tambahitemscreen.dart';

class InsideRuangan extends StatefulWidget {
  const InsideRuangan({super.key, required this.idInsideRuangan});

  final int idInsideRuangan;

  @override
  _InsideRuanganState createState() => _InsideRuanganState();
}

class _InsideRuanganState extends State<InsideRuangan> {
  // Future<List<Barang_dlm_ruangan>>? _barangDlmRuangan;
  @override
  void initState() {
    debugPrint(widget.idInsideRuangan.toString());
    super.initState();
    context.read<RuanganCubit>().fetchRuanganCubit();
    context.read<ContainersCubit>().fetchContainersCubit();
    context.read<BarangDlmRuanganCubit>().fetchBarangDlmRuanganCubit();

    // _barangDlmRuangan =
    //     DataService.fetchBarangDlmRuanganId(widget.idInsideRuangan);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('InsideRuangan'),
        backgroundColor: Colors.blueGrey,
        actions: [
          IconButton(
              onPressed: () {
                // showSearch(
                //   context: context,
                //   delegate: CustomSearchDelegate(),
                // );
              },
              icon: const Icon(Icons.search)),
          IconButton(
              onPressed: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => EditKamar(),
                //   ),
                // );
              },
              icon: const Icon(Icons.edit)),
        ],
      ),
      body: BlocBuilder<RuanganCubit, RuanganState>(
        builder: (context, state) {
          Ruangan filterRuangan = state.ListOfRuangan.firstWhere(
              (element) => element.id_ruangan == widget.idInsideRuangan);
          final imageUrl = Uri.parse(
                  '${Endpoints.baseUAS}/static/img/${filterRuangan.gambar_ruangan}')
              .toString();
          return Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.zero,
                    child: Image.network(
                      imageUrl,
                      height: 200,
                      width: 350,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) =>
                          const Icon(Icons.error),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: DefaultTabController(
                  length: 2,
                  child: Column(
                    children: [
                      const TabBar(tabs: [
                        Tab(
                          icon: Icon(Icons.storage),
                          child: Text('Container'),
                        ),
                        Tab(
                          icon: Icon(Icons.category),
                          child: Text('Barang'),
                        ),
                      ]),
                      Expanded(
                        child: TabBarView(
                          children: [
                            BlocBuilder<ContainersCubit, ContainersState>(
                              builder: (context, state) {
                                List<Containers> filterContainers =
                                    state.ListOfContainers.where((element) =>
                                        element.id_ruangan ==
                                        widget.idInsideRuangan).toList();
                                return ListView.builder(
                                  itemCount: filterContainers.length,
                                  itemBuilder: (context, index) {
                                    var item = filterContainers[index];
                                    final imageContainers = Uri.parse(
                                            '${Endpoints.baseUAS}/static/img/${item.gambar_containers}')
                                        .toString();
                                    return ContainerWidget(
                                        imageUrl: imageContainers,
                                        containerName: item.nama_containers,
                                        itemCount: 1);
                                  },
                                );
                              },
                            ),
                            BlocBuilder<BarangDlmRuanganCubit,
                                BarangDlmRuanganState>(
                              builder: (context, state) {
                                List<Barang_dlm_ruangan>
                                    filterBarangDlmRuangan =
                                    state.ListOfBarang_dlm_ruangan.where(
                                        (element) =>
                                            element.id_ruangan ==
                                            widget.idInsideRuangan).toList();
                                return ListView.builder(
                                  itemCount: filterBarangDlmRuangan.length,
                                  itemBuilder: (context, index) {
                                    var item = filterBarangDlmRuangan[index];
                                    final imageBarangDlmRuangan = Uri.parse(
                                            '${Endpoints.baseUAS}/static/img/${item.gambar_barang_dlm_ruangan}')
                                        .toString();
                                    return BarangWidget(
                                      imageUrl: imageBarangDlmRuangan,
                                      barangName:
                                          item.nama_barang_dlm_ruangan,
                                    );
                                  },
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.blueGrey,
        child: PopupMenuButton(
          itemBuilder: (context) => [
            const PopupMenuItem(
              value: "tambah_container",
              child: Text("Tambah Container"),
            ),
            const PopupMenuItem(
              value: "tambah_item",
              child: Text("Tambah Item"),
            ),
            const PopupMenuItem(
              value: "hapus_ruangan",
              child: Text("Hapus Ruangan"),
            ),
          ],
          onSelected: (value) {
            switch (value) {
              case "tambah_container":
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const TambahContainerScreen()),
                );
                break;
              case "tambah_item":
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const TambahItemScreen()),
                );
                break;
            }
          },
        ),
      ),
    );
  }
}
