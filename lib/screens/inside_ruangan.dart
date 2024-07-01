import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hometory/components/barang_widget.dart';
import 'package:hometory/components/containers_widget.dart';
import 'package:hometory/cubit/auth/cubit/auth_cubit.dart';
import 'package:hometory/cubit/barang_dlm_ruangan/cubit/barang_dlm_ruangan_cubit.dart';
import 'package:hometory/cubit/container/cubit/containers_cubit.dart';
import 'package:hometory/cubit/ruangan_cubit.dart';
import 'package:hometory/dto/barang_dlm_ruangan.dart';
import 'package:hometory/dto/containers.dart';
import 'package:hometory/dto/ruangan.dart';
import 'package:hometory/endpoints/endpoints.dart';
import 'package:hometory/screens/add_container.dart';
import 'package:hometory/screens/add_barang_ruangan.dart';
import 'package:hometory/screens/edit_ruangan.dart';
import 'package:hometory/screens/inside_barang_dlm_ruangan.dart';
import 'package:hometory/screens/inside_container.dart';
import 'package:hometory/services/data_services.dart';

class InsideRuangan extends StatefulWidget {
  const InsideRuangan({super.key, required this.idInsideRuangan});

  final int idInsideRuangan;

  @override
  State<InsideRuangan> createState() => _InsideRuanganState();
}

class _InsideRuanganState extends State<InsideRuangan> {
  int currentPage = 1;

  void _deleteRuangan(int ruanganHapus) async {
    // final int idRuangan = widget.idInsideRuangan;
    // final response =
    final token = context.read<AuthCubit>().state.accessToken;
    await DataService.deleteRuangan(ruanganHapus, token!);
    fetchPop();
    // Navigator.pop(context);
    // if(response.sta)
  }

  void fetchPop() {
    final accessToken = context.read<AuthCubit>().state.accessToken;
    context.read<RuanganCubit>().fetchRuanganCubit(accessToken!);
    Navigator.pop(context);
  }

  @override
  void initState() {
    debugPrint(widget.idInsideRuangan.toString());
    super.initState();
    final accessToken = context.read<AuthCubit>().state.accessToken;
    context.read<RuanganCubit>().fetchRuanganCubit(accessToken!);
    final tokenContainer = context.read<AuthCubit>().state.accessToken;
    context.read<ContainersCubit>().fetchContainersCubit(tokenContainer!);
    final idPengguna = context.read<AuthCubit>().state.idPengguna;
    context.read<BarangDlmRuanganCubit>().fetchBarangDlmRuanganCubit(
        currentPage, "", widget.idInsideRuangan, idPengguna!);
  }

  void _fetchData() {
    final idPengguna = context.read<AuthCubit>().state.idPengguna;
    context.read<BarangDlmRuanganCubit>().fetchBarangDlmRuanganCubit(
        currentPage, "", widget.idInsideRuangan, idPengguna!);
  }

  void _incrementPage() {
    setState(() {
      currentPage++;
      _fetchData();
    });
  }

  void _decrementPage() {
    if (currentPage > 1) {
      setState(() {
        currentPage--;
        _fetchData();
      });
    }
  }

  void _resetPages() {
    if (currentPage > 1) {
      setState(() {
        currentPage = 1;
        _fetchData();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    int? idRuangan = widget.idInsideRuangan;
    return Scaffold(
      appBar: AppBar(
        // title: BlocBuilder<RuanganCubit, RuanganState>(
        //   builder: (context, state) {
        //     Ruangan filterRuangan;
        //     filterRuangan = state.ListOfRuangan.where((element) => elemet);
        //     return const Text("");
        //   },
        // ),
        title: const Text('InsideRuangan'),
        backgroundColor: Colors.blueGrey,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
            _resetPages();
          },
          icon: const Icon(Icons.arrow_back),
        ),
        actions: [
          // IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
          IconButton(
            onPressed: () {
              _deleteRuangan(idRuangan!);
              idRuangan = null;
            },
            icon: const Icon(Icons.delete_sharp),
          ),
          BlocBuilder<RuanganCubit, RuanganState>(
            builder: (context, state) {
              Ruangan? filterRuangan;
              if (idRuangan != null) {
                filterRuangan = state.listOfRuangan
                    .firstWhere((element) => element.idRuangan == idRuangan);
              } else {
                return const SizedBox();
              }
              return IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditRuangan(
                          ruangan: filterRuangan!,
                        ),
                      ),
                    );
                  },
                  icon: const Icon(Icons.edit));
            },
          ),
        ],
      ),
      body: BlocBuilder<RuanganCubit, RuanganState>(
        builder: (context, state) {
          Ruangan? filterRuangan;
          String imageUrl = "assets/images/lemari.jpg";
          if (idRuangan != null) {
            filterRuangan = state.listOfRuangan
                .firstWhere((element) => element.idRuangan == idRuangan);
            imageUrl = Uri.parse(
                    '${Endpoints.baseUAS}/static/img/${filterRuangan.gambarRuangan}')
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
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                Column(
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
                    // Text(filterRuangan!.nama_ruangan)
                  ],
                ),
                Text(
                  filterRuangan.namaRuangan,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
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
                                  List<Containers> filterContainers;
                                  if (idRuangan != null) {
                                    filterContainers = state.listOfContainers
                                        .where((element) =>
                                            element.idRuangan == idRuangan)
                                        .toList();
                                  } else {
                                    return const SizedBox();
                                  }
                                  return ListView.builder(
                                    itemCount: filterContainers.length,
                                    itemBuilder: (context, index) {
                                      var item = filterContainers[index];
                                      final imageContainers = Uri.parse(
                                              '${Endpoints.baseUAS}/static/img/${item.gambarContainer}')
                                          .toString();
                                      return GestureDetector(
                                        onTap: () {
                                          Navigator.push(context,
                                              MaterialPageRoute(
                                            builder: (context) {
                                              return InsideContainer(
                                                idInsideContianer:
                                                    item.idContainer,
                                                idRuangan: item.idRuangan,
                                              );
                                            },
                                          ));
                                        },
                                        child: ContainersWidget(
                                            imageUrl: imageContainers,
                                            containerName: item.namaContainer,
                                            ),
                                      );
                                    },
                                  );
                                },
                              ),
                              Column(children: [
                                Expanded(
                                  child: BlocBuilder<BarangDlmRuanganCubit,
                                      BarangDlmRuanganState>(
                                    builder: (context, state) {
                                      List<BarangDlmRuangan>
                                          filterBarangDlmRuangan;
                                      if (idRuangan != null) {
                                        filterBarangDlmRuangan = state
                                            .listOfBarangDlmRuanganByUser //ini make listbyuserjuga bisa
                                            .where((element) =>
                                                element.idRuangan == idRuangan)
                                            .toList();
                                      } else {
                                        return const SizedBox();
                                      }
                                      return ListView.builder(
                                        itemCount:
                                            filterBarangDlmRuangan.length,
                                        itemBuilder: (context, index) {
                                          var item =
                                              filterBarangDlmRuangan[index];
                                          final imageBarangDlmRuangan = Uri.parse(
                                                  '${Endpoints.baseUAS}/static/img/${item.gambarBarangDlmRuangan}')
                                              .toString();
                                          return GestureDetector(
                                            onTap: () {
                                              Navigator.push(context,
                                                  MaterialPageRoute(
                                                builder: (context) {
                                                  return InsideBarangDlmRuangan(
                                                    idInsideBarangDlmRuangan:
                                                        item.idBarangDlmRuangan,
                                                    idRuangan: item.idRuangan,
                                                    currentPages: currentPage,
                                                  );
                                                },
                                              ));
                                            },
                                            child: BarangWidget(
                                              imageUrl: imageBarangDlmRuangan,
                                              barangName:
                                                  item.namaBarangDlmRuangan,
                                            ),
                                          );
                                        },
                                      );
                                    },
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    IconButton(
                                      icon: const Icon(Icons.arrow_back),
                                      onPressed: _decrementPage,
                                    ),
                                    Text('Page $currentPage'),
                                    IconButton(
                                      icon: const Icon(Icons.arrow_forward),
                                      onPressed: _incrementPage,
                                    ),
                                  ],
                                ),
                              ]),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
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
              child: Text("Tambah Barang"),
            ),
            // const PopupMenuItem(
            //   value: "hapus_ruangan",
            //   child: Text("Hapus Ruangan"),
            // ),
          ],
          onSelected: (value) {
            switch (value) {
              case "tambah_container":
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AddContainer(
                            idInsideRuangan: idRuangan!,
                          )),
                );
                break;
              case "tambah_item":
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AddBarangRuangan(
                            idInsideRuangan: idRuangan!,
                          )),
                );
                break;
            }
          },
        ),
      ),
    );
  }
}