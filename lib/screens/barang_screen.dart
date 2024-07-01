import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hometory/components/barang_widget.dart';
import 'package:hometory/components/customsearch.dart';
import 'package:hometory/cubit/auth/cubit/auth_cubit.dart';
import 'package:hometory/cubit/barang_dlm_container/cubit/barang_dlm_container_cubit.dart';
import 'package:hometory/cubit/barang_dlm_ruangan/cubit/barang_dlm_ruangan_cubit.dart';
import 'package:hometory/dto/barang_dlm_container.dart';
import 'package:hometory/dto/barang_dlm_ruangan.dart';
import 'package:hometory/endpoints/endpoints.dart';
import 'package:hometory/screens/inside_barang_container.dart';
import 'package:hometory/screens/inside_barang_dlm_ruangan.dart';

class BarangScreen extends StatefulWidget {
  const BarangScreen({super.key});

  @override
  State<BarangScreen> createState() => _BarangScreenState();
}

class _BarangScreenState extends State<BarangScreen> {
  late TextEditingController _searchController;
  int currentPage = 1;

  late TextEditingController _searchContainerController;
  int currentControllerPage = 1;

  @override
  void initState() {
    super.initState();
    _searchContainerController = TextEditingController();
    _searchController = TextEditingController();
    _fetchData();
    final idPengguna = context.read<AuthCubit>().state.idPengguna;
    context.read<BarangDlmContainerCubit>().fetchBarangDlmContainerCubit(
        currentControllerPage,
        _searchContainerController.text,
        null,
        idPengguna!);
    context.read<BarangDlmRuanganCubit>().fetchBarangDlmRuanganCubit(
        currentPage, _searchController.text, null, idPengguna);
  }

  void _fetchData() {
    final idPengguna = context.read<AuthCubit>().state.idPengguna;
    context.read<BarangDlmRuanganCubit>().fetchBarangDlmRuanganCubit(
        currentPage, _searchController.text, null, idPengguna!);
    context.read<BarangDlmContainerCubit>().fetchBarangDlmContainerCubit(
        currentControllerPage,
        _searchContainerController.text,
        null,
        idPengguna);
  }

  void _incrementControllerPage() {
    setState(() {
      currentControllerPage++;
      _fetchData();
    });
  }

  void _decrementControllerPage() {
    if (currentControllerPage > 1) {
      setState(() {
        currentControllerPage--;
        _fetchData();
      });
    }
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
            image: AssetImage('assets/images/bg 2.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: DefaultTabController(
          length: 2,
          child: Column(
            children: [
              const TabBar(tabs: [
                Tab(
                  icon: Icon(Icons.storage),
                  child: Text('BarangContainer'),
                ),
                Tab(
                  icon: Icon(Icons.category),
                  child: Text('BarangRuangan'),
                ),
              ]),
              Expanded(
                child: TabBarView(
                  children: [
                    Column(
                      children: [
                        CustomSearchBox(
                          controller: _searchContainerController,
                          onChanged: (value) => _fetchData(),
                          onClear: () => _fetchData(),
                          hintText: 'Search barang dalam container...',
                        ),
                        Expanded(
                          child: BlocBuilder<BarangDlmContainerCubit,
                              BarangDlmContainerState>(
                            builder: (context, state) {
                              List<BarangDlmContainer> barangDlmContainer =
                                  state.listOfBarangDlmContainerByUser;
                              return ListView.builder(
                                itemCount: barangDlmContainer.length,
                                itemBuilder: (context, index) {
                                  var item = barangDlmContainer[index];
                                  final imageContainers = Uri.parse(
                                          '${Endpoints.baseUAS}/static/img/${item.gambarBarangDlmContainer}')
                                      .toString();
                                  return GestureDetector(
                                    onTap: () {
                                      Navigator.push(context,
                                          MaterialPageRoute(
                                        builder: (context) {
                                          return InsideBarangDlmContainer(
                                            idInsideBarangDlmContainer:
                                                item.idBarangDlmContainer,
                                            idContainer: item.idContainer,
                                            currentPages: currentControllerPage,
                                          );
                                        },
                                      ));
                                    },
                                    child: BarangWidget(
                                      imageUrl: imageContainers,
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
                              onPressed: _decrementControllerPage,
                            ),
                            Text('Page $currentControllerPage'),
                            IconButton(
                              icon: const Icon(Icons.arrow_forward),
                              onPressed: _incrementControllerPage,
                            ),
                          ],
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        CustomSearchBox(
                          controller: _searchController,
                          onChanged: (value) => _fetchData(),
                          onClear: () => _fetchData(),
                          hintText: 'Search barang dalam ruangan...',
                        ),
                        Expanded(
                          child: BlocBuilder<BarangDlmRuanganCubit,
                              BarangDlmRuanganState>(
                            builder: (context, state) {
                              List<BarangDlmRuangan> barangDlmRuangan =
                                  state.listOfBarangDlmRuanganByUser;
                              return ListView.builder(
                                itemCount: barangDlmRuangan.length,
                                itemBuilder: (context, index) {
                                  var item = barangDlmRuangan[index];
                                  final imageBarangDlmRuangan = Uri.parse(
                                          '${Endpoints.baseUAS}/static/img/${item.gambarBarangDlmRuangan}')
                                      .toString();
                                  debugPrint(
                                      'ID ruangan : ${item.idRuangan.toString()}');
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
                                      barangName: item.namaBarangDlmRuangan,
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
    );
  }
}
