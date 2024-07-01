import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hometory/components/room_inventory_widget.dart';
import 'package:hometory/cubit/auth/cubit/auth_cubit.dart';
import 'package:hometory/cubit/ruangan_cubit.dart';
import 'package:hometory/endpoints/endpoints.dart';
import 'package:hometory/screens/add_ruangan.dart';
import 'package:hometory/screens/inside_ruangan.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    final accessToken = context.read<AuthCubit>().state.accessToken;
    context.read<RuanganCubit>().fetchRuanganCubit(accessToken!);
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
                final listRuangan = state.listOfRuangan
                    .where((element) => element.idPengguna == idPengguna)
                    .toList();
                return Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/bg 2.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: GridView.builder(
                    // padding: const EdgeInsets.all(20),
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 200,
                      childAspectRatio: 0.9,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20,
                    ),
                    itemCount: listRuangan.length,
                    itemBuilder: (context, index) {
                      final item = listRuangan[index];
                      final imageUrl = Uri.parse(
                              '${Endpoints.baseUAS}/static/img/${item.gambarRuangan}')
                          .toString();
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => InsideRuangan(
                                idInsideRuangan: item.idRuangan,
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
                          roomName: item.namaRuangan,
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
              final listRuangan = state.listOfRuangan
                  .where((element) => element.idPengguna == idPengguna)
                  .toList();
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
                    if (listRuangan.isEmpty) {
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
