import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hometory/cubit/barang_dlm_ruangan/cubit/barang_dlm_ruangan_cubit.dart';
import 'package:hometory/cubit/container/cubit/containers_cubit.dart';
import 'package:hometory/cubit/ruangan_cubit.dart';
import 'package:hometory/dto/barang_dlm_ruangan.dart';
import 'package:hometory/endpoints/endpoints.dart';

class InsideBarangDlmRuangan extends StatefulWidget {
  const InsideBarangDlmRuangan({super.key, required this.idInsideBarangDlmRuangan});

  final int idInsideBarangDlmRuangan;

  @override
  _InsideBarangDlmRuanganState createState() => _InsideBarangDlmRuanganState();
}

class _InsideBarangDlmRuanganState extends State<InsideBarangDlmRuangan> {

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
    int? idBarangDlmRuangan = widget.idInsideBarangDlmRuangan;
    return Scaffold(
      appBar: AppBar(
        title: const Text('insideBarangDlmRuangan'),
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
      body: BlocBuilder<BarangDlmRuanganCubit, BarangDlmRuanganState>(
        builder: (context, state) {
          Barang_dlm_ruangan? filterBarangDlmRuangan;
          String imageUrl = 'assets/images/lemari.jpg';
          if (idBarangDlmRuangan != null) {
            filterBarangDlmRuangan = state.ListOfBarang_dlm_ruangan.firstWhere((element) => element.id_barang_dlm_ruangan == idBarangDlmRuangan);
            imageUrl = Uri.parse(
                    '${Endpoints.baseUAS}/static/img/${filterBarangDlmRuangan.gambar_barang_dlm_ruangan}')
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
              Text(filterBarangDlmRuangan!.nama_barang_dlm_ruangan),
            ],
          );
        },
      ),
    );
  }
}
