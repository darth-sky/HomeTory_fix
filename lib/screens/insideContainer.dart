import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hometory/components/barangWidget.dart';
import 'package:hometory/cubit/barang_dlm_container/cubit/barang_dlm_container_cubit.dart';
import 'package:hometory/cubit/barang_dlm_ruangan/cubit/barang_dlm_ruangan_cubit.dart';
import 'package:hometory/cubit/container/cubit/containers_cubit.dart';
import 'package:hometory/cubit/ruangan_cubit.dart';
import 'package:hometory/dto/barang_dlm_container.dart';
import 'package:hometory/dto/containers.dart';
import 'package:hometory/endpoints/endpoints.dart';
import 'package:hometory/screens/tambahbarangDlmContainer.dart';
import 'package:hometory/screens/tambahcontainerscreen.dart';
import 'package:hometory/services/data_services.dart';

class InsideContainer extends StatefulWidget {
  const InsideContainer({super.key, required this.idInsideContianer});

  final int idInsideContianer;

  @override
  _InsideContainerState createState() => _InsideContainerState();
}

class _InsideContainerState extends State<InsideContainer> {
  @override
  void initState() {
    // debugPrint(widget.idInsideRuangan.toString());
    super.initState();
    context.read<RuanganCubit>().fetchRuanganCubit();
    context.read<ContainersCubit>().fetchContainersCubit();
    context.read<BarangDlmContainerCubit>().fetchBarangDlmContainerCubit();

    // _barangDlmRuangan =
    //     DataService.fetchBarangDlmRuanganId(widget.idInsideRuangan);
  }

  @override
  Widget build(BuildContext context) {
    int? idContainer = widget.idInsideContianer;
    return Scaffold(
      appBar: AppBar(
        title: const Text('insideContainer'),
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
              Text(filterContianer!.nama_containers),
              BlocBuilder<BarangDlmContainerCubit, BarangDlmContainerState>(
                builder: (context, state) {
                  List<Barang_dlm_container> filterBarangDlmContainer;
                  if (idContainer != null) {
                    filterBarangDlmContainer =
                        state.ListOfBarang_dlm_container.where((element) =>
                            element.id_container == idContainer).toList();
                  } else {
                    return const SizedBox();
                  }
                  return Expanded(
                    child: ListView.builder(
                      itemCount: filterBarangDlmContainer.length,
                      itemBuilder: (context, index) {
                        var item = filterBarangDlmContainer[index];
                        final imageBarangDlmContainers = Uri.parse(
                                '${Endpoints.baseUAS}/static/img/${item.gambar_barang_dlm_container}')
                            .toString();
                        return GestureDetector(
                          onTap: () {
                            // Navigator.push(context, MaterialPageRoute(
                            //   builder: (context) {
                            //     return InsideContainer(
                            //       idInsideContianer: item.id_containers,
                            //     );
                            //   },
                            // ));
                          },
                          child: BarangWidget(
                            imageUrl: imageBarangDlmContainers,
                            barangName: item.nama_barang_dlm_container,
                          ),
                        );
                      },
                    ),
                  );
                },
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
              value: "tambah_Barang",
              child: Text("Tambah Barang"),
            ),
            const PopupMenuItem(
              value: "hapus_Container",
              child: Text("Hapus Container"),
            ),
          ],
          onSelected: (value) {
            switch (value) {
              case "tambah_Barang":
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => TambahbarangDlmContainer(
                            idInsideContainer: idContainer!,
                          )),
                );
                break;
              case "hapus_Container":
                DataService.deleteContainer(idContainer!);
                idContainer = null;
                // Navigator.pop(context);
                Navigator.pop(context);
                context.read<ContainersCubit>().fetchContainersCubit();
                break;
            }
          },
        ),
      ),
    );
  }
}
