import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hometory/cubit/barang_dlm_ruangan/cubit/barang_dlm_ruangan_cubit.dart';
import 'package:hometory/cubit/container/cubit/containers_cubit.dart';
import 'package:hometory/cubit/ruangan_cubit.dart';
import 'package:hometory/dto/containers.dart';
import 'package:hometory/endpoints/endpoints.dart';

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
    context.read<BarangDlmRuanganCubit>().fetchBarangDlmRuanganCubit();
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
            filterContianer = state.ListOfContainers.firstWhere((element) => element.id_containers == idContainer);
            imageUrl = Uri.parse(
                    '${Endpoints.baseUAS}/static/img/${filterContianer.gambar_containers}')
                .toString();
          }
          return Column(
            children: [
              const SizedBox(height: 10,),
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
            ],
          );
        },
      ),
    );
  }
}
