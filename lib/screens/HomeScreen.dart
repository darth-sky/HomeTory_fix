import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hometory/components/roomInventoryWidget.dart';
import 'package:hometory/cubit/auth/cubit/auth_cubit.dart';
import 'package:hometory/cubit/ruangan_cubit.dart';
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
                final listRuangan = state.ListOfRuangan.where(
                    (element) => element.id_pengguna == idPengguna).toList();
                return Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/bg 1.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: ListView.builder(
                    itemCount: listRuangan.length,
                    itemBuilder: (context, index) {
                      final item = listRuangan[index];
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddRuangan(),
            ),
          );
        },
        backgroundColor: Colors.blueGrey[300],
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
