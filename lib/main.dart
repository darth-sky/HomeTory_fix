import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hometory/cubit/auth/cubit/auth_cubit.dart';
import 'package:hometory/cubit/barang_dlm_container/cubit/barang_dlm_container_cubit.dart';
import 'package:hometory/cubit/barang_dlm_ruangan/cubit/barang_dlm_ruangan_cubit.dart';
import 'package:hometory/cubit/container/cubit/containers_cubit.dart';
import 'package:hometory/cubit/pengguna/cubit/pengguna_cubit.dart';
import 'package:hometory/cubit/ruangan_cubit.dart';
import 'package:hometory/endpoints/endpoints.dart';
import 'package:hometory/screens/login_page.dart';
import 'package:hometory/screens/myhomepage.dart';
import 'package:hometory/utils/auth_wrapper.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Endpoints.initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<RuanganCubit>(
          create: (context) => RuanganCubit(),
        ),
        BlocProvider<ContainersCubit>(
          create: (context) => ContainersCubit(),
        ),
        BlocProvider<BarangDlmRuanganCubit>(
          create: (context) => BarangDlmRuanganCubit(),
        ),
        BlocProvider<BarangDlmContainerCubit>(
          create: (context) => BarangDlmContainerCubit(),
        ),
        BlocProvider<AuthCubit>(create: (context) => AuthCubit()),
        BlocProvider<PenggunaCubit>(create: (context) => PenggunaCubit()),
      ],
      child: MaterialApp(
        title: 'HomeTory',
        theme: ThemeData(primarySwatch: Colors.blueGrey),
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (context) => const LoginPage(),
          '/home-screen': (context) => const AuthWrapper(
                  child: Myhomepage(
                title: 'HomeTory',
              )),
        },
      ),
    );
  }
}
