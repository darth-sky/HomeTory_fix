import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hometory/components/barang_widget.dart';
import 'package:hometory/cubit/auth/cubit/auth_cubit.dart';
import 'package:hometory/cubit/barang_dlm_container/cubit/barang_dlm_container_cubit.dart';
import 'package:hometory/cubit/container/cubit/containers_cubit.dart';
import 'package:hometory/cubit/ruangan_cubit.dart';
import 'package:hometory/dto/barang_dlm_container.dart';
import 'package:hometory/dto/containers.dart';
import 'package:hometory/endpoints/endpoints.dart';
import 'package:hometory/screens/add_barang_container.dart';
import 'package:hometory/screens/edit_container.dart';
import 'package:hometory/screens/inside_barang_container.dart';
import 'package:hometory/screens/inside_ruangan.dart';
import 'package:hometory/services/data_services.dart';

class InsideContainer extends StatefulWidget {
  const InsideContainer(
      {super.key, required this.idRuangan, required this.idInsideContianer});

  final int idInsideContianer;
  final int idRuangan;

  @override
  State<InsideContainer> createState() => _InsideContainerState();
}

class _InsideContainerState extends State<InsideContainer> {
  int currentPage = 1;

  @override
  void initState() {
    super.initState();
    final accessToken = context.read<AuthCubit>().state.accessToken;
    context.read<RuanganCubit>().fetchRuanganCubit(accessToken!);
    context.read<ContainersCubit>().fetchContainersCubit(accessToken);
    _fetchData();
  }

  void _fetchData() {
    final idPengguna = context.read<AuthCubit>().state.idPengguna;
    context.read<BarangDlmContainerCubit>().fetchBarangDlmContainerCubit(
        currentPage, "", widget.idInsideContianer, idPengguna!);
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
    int? idContainer = widget.idInsideContianer;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inside Container'),
        backgroundColor: Colors.blueGrey,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
            _resetPages();
          },
          icon: const Icon(Icons.arrow_back),
        ),
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
                        'Apakah Anda yakin ingin menghapus container ini?'),
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
                // ignore: use_build_context_synchronously
                final token = context.read<AuthCubit>().state.accessToken;
                DataService.deleteContainer(
                  idContainer!,
                  token!
                );
                idContainer = null;
                // ignore: use_build_context_synchronously
                context.read<ContainersCubit>().fetchContainersCubit(token);
                // ignore: use_build_context_synchronously
                Navigator.pop(context);
                Navigator.pushReplacement(
                  // ignore: use_build_context_synchronously
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        InsideRuangan(idInsideRuangan: widget.idRuangan),
                  ),
                );
              }
            },
            icon: const Icon(Icons.delete_sharp),
          ),
          BlocBuilder<ContainersCubit, ContainersState>(
            builder: (context, state) {
              Containers? filterContainer;
              // String imageUrl = 'assets/images/pfp.jpg'; // Default image
              if (idContainer != null) {
                filterContainer = state.listOfContainers.firstWhere(
                    (element) => element.idContainer == idContainer);
                // imageUrl = Uri.parse(
                //         '${Endpoints.baseUAS}/static/img/${filterContainer.gambarContainer}')
                //     .toString();
              }
              return IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditContainer(
                        containers: filterContainer!,
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
      body: BlocBuilder<ContainersCubit, ContainersState>(
        builder: (context, state) {
          Containers? filterContianer;
          String imageUrl = 'assets/images/lemari.jpg';
          if (idContainer != null) {
            filterContianer = state.listOfContainers
                .firstWhere((element) => element.idContainer == idContainer);
            imageUrl = Uri.parse(
                    '${Endpoints.baseUAS}/static/img/${filterContianer.gambarContainer}')
                .toString();
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
                Text(
                  filterContianer?.namaContainer ?? 'no name',
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Expanded(
                  child: BlocBuilder<BarangDlmContainerCubit,
                      BarangDlmContainerState>(
                    builder: (context, state) {
                      List<BarangDlmContainer> filterBarangDlmContainer;
                      if (idContainer != null) {
                        filterBarangDlmContainer = state
                            .listOfBarangDlmContainer
                            .where(
                                (element) => element.idContainer == idContainer)
                            .toList();
                      } else {
                        return const SizedBox();
                      }
                      return ListView.builder(
                        itemCount: filterBarangDlmContainer.length,
                        itemBuilder: (context, index) {
                          var item = filterBarangDlmContainer[index];
                          final imageBarangDlmContainers = Uri.parse(
                                  '${Endpoints.baseUAS}/static/img/${item.gambarBarangDlmContainer}')
                              .toString();
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(
                                builder: (context) {
                                  return InsideBarangDlmContainer(
                                    idContainer: item.idContainer,
                                    idInsideBarangDlmContainer:
                                        item.idBarangDlmContainer,
                                    currentPages: currentPage,
                                  );
                                },
                              ));
                            },
                            child: BarangWidget(
                              imageUrl: imageBarangDlmContainers,
                              barangName: item.namaBarangDlmContainer,
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
              value: "tambah_Barang",
              child: Text("Tambah Barang"),
            ),
          ],
          onSelected: (value) {
            switch (value) {
              case "tambah_Barang":
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AddBarangContainer(
                            idInsideContainer: idContainer!,
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
