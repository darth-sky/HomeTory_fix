import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hometory/components/roomInventoryWidget.dart';
import 'package:hometory/cubit/auth/cubit/auth_cubit.dart';
import 'package:hometory/cubit/ruangan_cubit.dart';
import 'package:hometory/dto/ruangan.dart';
// import 'package:hometory/dto/ruangan.dart';
import 'package:hometory/endpoints/endpoints.dart';
import 'package:hometory/screens/addRuangan.dart';
import 'package:hometory/screens/insideRuangan.dart';
import 'package:hometory/screens/tambahRuanganscreen.dart';
// import 'package:hometory/services/data_services.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    context.read<RuanganCubit>().fetchRuanganCubit();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
          final idPengguna = state.idPengguna;
          return Center(
            child: BlocBuilder<RuanganCubit, RuanganState>(
              builder: (context, state) {
                List<Ruangan> filterRuangan;
                if (idPengguna != null) {
                  filterRuangan = state.ListOfRuangan.where(
                      (element) => element.id_pengguna == idPengguna).toList();
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
                  child: ListView.builder(
                    itemCount: filterRuangan.length,
                    itemBuilder: (context, index) {
                      final item = filterRuangan[index];
                      final imageUrl = Uri.parse(
                              '${Endpoints.baseUAS}/static/img/${item.gambar_ruangan}')
                          .toString();
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => InsideRuangan(
                                idInsideRuangan: item.id_ruangan,
                              ),
                            ),
                          );
                        },
                        child: RoomInventoryWidget(
                          image: Image.network(
                            imageUrl,
                            errorBuilder: (context, error, stackTrace) =>
                                const Icon(Icons.error),
                          ),
                          roomName: item.nama_ruangan,
                          itemCount: 1,
                          containerCount: 1,
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          );
        },
      ),
      floatingActionButton: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
          final idPengguna = state.idPengguna;
          return BlocBuilder<RuanganCubit, RuanganState>(
            builder: (context, state) {
              final roles = context.read<AuthCubit>().state.roles;
              final listRuangan = state.ListOfRuangan.where(
                  (element) => element.id_pengguna == idPengguna).toList();
              return FloatingActionButton(
                onPressed: () {
                  debugPrint('listruangan = ${listRuangan.length}');
                  if (roles == 'pro') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AddRuangan(),
                      ),
                    );
                  } else if (roles == 'biasa') {
                    if (listRuangan.length < 1) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AddRuangan(),
                        ),
                      );
                    } else {
                      debugPrint('hanya yang pro saja');
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text(
                              'Hanya Pengguna Pro yang bisa membuat lebih dari 1 ruangan')));
                      // AlertDialog(
                      //   title: Text('hanya pro saja'),
                      // );
                    }
                  }
                },
                backgroundColor: Colors.blueGrey[300],
                child: const Icon(Icons.add),
              );
            },
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
