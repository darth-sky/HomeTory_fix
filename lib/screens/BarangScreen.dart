import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hometory/components/barangWidget.dart';
import 'package:hometory/components/containersWidget.dart';
import 'package:hometory/components/customsearch.dart';
import 'package:hometory/cubit/barang_dlm_container/cubit/barang_dlm_container_cubit.dart';
import 'package:hometory/cubit/barang_dlm_ruangan/cubit/barang_dlm_ruangan_cubit.dart';
import 'package:hometory/cubit/container/cubit/containers_cubit.dart';
import 'package:hometory/dto/barang_dlm_container.dart';
import 'package:hometory/dto/barang_dlm_ruangan.dart';
import 'package:hometory/endpoints/endpoints.dart';
import 'package:hometory/screens/insideBarangDlmRuangan.dart';
import 'package:hometory/screens/insideContainer.dart';

class BarangScreen extends StatefulWidget {
  const BarangScreen({Key? key}) : super(key: key);

  @override
  _BarangScreenState createState() => _BarangScreenState();
}

class _BarangScreenState extends State<BarangScreen> {
  late TextEditingController _searchController;
  int currentPage = 1;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _fetchData();
    context.read<BarangDlmContainerCubit>().fetchBarangDlmContainerCubit();
    context
        .read<BarangDlmRuanganCubit>()
        .fetchBarangDlmRuanganCubit(currentPage, _searchController.text, null);
  }

  void _fetchData() {
    context
        .read<BarangDlmRuanganCubit>()
        .fetchBarangDlmRuanganCubit(currentPage, _searchController.text, null);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/bg 1.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Expanded(
          child: DefaultTabController(
            length: 2,
            child: Column(
              children: [
                const TabBar(tabs: [
                  Tab(
                    icon: Icon(Icons.storage),
                    child: Text('Barang '),
                  ),
                  Tab(
                    icon: Icon(Icons.category),
                    child: Text('Barang '),
                  ),
                ]),
                Expanded(
                  child: TabBarView(
                    children: [
                      BlocBuilder<BarangDlmContainerCubit,
                          BarangDlmContainerState>(
                        builder: (context, state) {
                          List<Barang_dlm_container> barangDlmContainer =
                              state.ListOfBarang_dlm_container;
                          return ListView.builder(
                            itemCount: barangDlmContainer.length,
                            itemBuilder: (context, index) {
                              var item = barangDlmContainer[index];
                              final imageContainers = Uri.parse(
                                      '${Endpoints.baseUAS}/static/img/${item.gambar_barang_dlm_container}')
                                  .toString();
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(
                                    builder: (context) {
                                      return InsideContainer(
                                        idInsideContianer: item.id_container,
                                      );
                                    },
                                  ));
                                },
                                child: BarangWidget(
                                  imageUrl: imageContainers,
                                  barangName: item.nama_barang_dlm_container,
                                ),
                              );
                            },
                          );
                        },
                      ),
                      Column(
                        children: [
                          CustomSearchBox(
                              controller: _searchController,
                              onChanged: (value) => _fetchData(),
                              onClear: () => _fetchData(),
                              hintText: 'search barang dalam ruangan..'),
                          Expanded(
                            child: BlocBuilder<BarangDlmRuanganCubit,
                                BarangDlmRuanganState>(
                              builder: (context, state) {
                                List<Barang_dlm_ruangan> barangDlmRuangan =
                                    state.ListOfBarang_dlm_ruangan;
                                return ListView.builder(
                                  itemCount: barangDlmRuangan.length,
                                  itemBuilder: (context, index) {
                                    var item = barangDlmRuangan[index];
                                    final imageBarangDlmRuangan = Uri.parse(
                                            '${Endpoints.baseUAS}/static/img/${item.gambar_barang_dlm_ruangan}')
                                        .toString();

                                    debugPrint(
                                        'ID ruangan : ${item.id_ruangan.toString()}');
                                    return GestureDetector(
                                      onTap: () {
                                        Navigator.push(context,
                                            MaterialPageRoute(
                                          builder: (context) {
                                            return InsideBarangDlmRuangan(
                                              idInsideBarangDlmRuangan:
                                                  item.id_barang_dlm_ruangan,
                                              idRuangan: item.id_ruangan,
                                              currentPages: currentPage,
                                            );
                                          },
                                        ));
                                      },
                                      child: BarangWidget(
                                        imageUrl: imageBarangDlmRuangan,
                                        barangName:
                                            item.nama_barang_dlm_ruangan,
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
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
