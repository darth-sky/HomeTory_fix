import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hometory/components/barangWidget.dart';
import 'package:hometory/cubit/barang_dlm_container/cubit/barang_dlm_container_cubit.dart';
import 'package:hometory/cubit/container/cubit/containers_cubit.dart';
import 'package:hometory/cubit/ruangan_cubit.dart';
import 'package:hometory/dto/barang_dlm_container.dart';
import 'package:hometory/dto/containers.dart';
import 'package:hometory/endpoints/endpoints.dart';
import 'package:hometory/screens/AddBarangContainer.dart';
import 'package:hometory/screens/EditContainer.dart';
import 'package:hometory/screens/insideBarangContainer.dart';
import 'package:hometory/screens/insideRuangan.dart';
import 'package:hometory/services/data_services.dart';

class InsideContainer extends StatefulWidget {
  const InsideContainer(
      {super.key, required this.idRuangan, required this.idInsideContianer});

  final int idInsideContianer;
  final int idRuangan;

  @override
  _InsideContainerState createState() => _InsideContainerState();
}

class _InsideContainerState extends State<InsideContainer> {
  int currentPage = 1;

  @override
  void initState() {
    super.initState();
    context.read<RuanganCubit>().fetchRuanganCubit();
    context.read<ContainersCubit>().fetchContainersCubit();
    _fetchData();
  }

  void _fetchData() {
    context.read<BarangDlmContainerCubit>().fetchBarangDlmContainerCubit(
        currentPage, "", widget.idInsideContianer, 1);
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
            onPressed: () {
              DataService.deleteContainer(idContainer!);
              idContainer = null;
              context.read<ContainersCubit>().fetchContainersCubit();
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
          BlocBuilder<ContainersCubit, ContainersState>(
            builder: (context, state) {
              Containers? filterContainer;
              String imageUrl = 'assets/images/pfp.jpg'; // Default image
              if (idContainer != null) {
                filterContainer = state.ListOfContainers.firstWhere(
                    (element) => element.id_containers == idContainer);
                imageUrl = Uri.parse(
                        '${Endpoints.baseUAS}/static/img/${filterContainer.gambar_containers}')
                    .toString();
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
            filterContianer = state.ListOfContainers.firstWhere(
                (element) => element.id_containers == idContainer);
            imageUrl = Uri.parse(
                    '${Endpoints.baseUAS}/static/img/${filterContianer.gambar_containers}')
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
                const SizedBox(
                  height: 10,
                ),
                Text(filterContianer!.nama_containers),
                Expanded(
                  child: BlocBuilder<BarangDlmContainerCubit,
                      BarangDlmContainerState>(
                    builder: (context, state) {
                      List<Barang_dlm_container> filterBarangDlmContainer;
                      if (idContainer != null) {
                        filterBarangDlmContainer = state
                            .ListOfBarang_dlm_container
                            .where((element) =>
                                element.id_container == idContainer)
                            .toList();
                      } else {
                        return const SizedBox();
                      }
                      return ListView.builder(
                        itemCount: filterBarangDlmContainer.length,
                        itemBuilder: (context, index) {
                          var item = filterBarangDlmContainer[index];
                          final imageBarangDlmContainers = Uri.parse(
                                  '${Endpoints.baseUAS}/static/img/${item.gambar_barang_dlm_container}')
                              .toString();
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(
                                builder: (context) {
                                  return InsideBarangDlmContainer(
                                    idContainer: item.id_container,
                                    idInsideBarangDlmContainer:
                                        item.id_barang_dlm_container,
                                    currentPages: 1,
                                  );
                                },
                              ));
                            },
                            child: BarangWidget(
                              imageUrl: imageBarangDlmContainers,
                              barangName: item.nama_barang_dlm_container,
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
