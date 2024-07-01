import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hometory/cubit/auth/cubit/auth_cubit.dart';
import 'package:hometory/services/data_services.dart';

class KonfirmasiPro extends StatefulWidget {
  const KonfirmasiPro({super.key});

  @override
  State<KonfirmasiPro> createState() => _KonfirmasiProState();
}

class _KonfirmasiProState extends State<KonfirmasiPro> {
  void scaffoldMsg() {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Anda telah berhasil meng-upgrade ke akun Pro!')));
  }

  void _becomePro(AuthCubit authCubit) async {
    final idPengguna = context.read<AuthCubit>().state.idPengguna;
    final roles = context.read<AuthCubit>().state.roles;

    if (roles != 'pro') {
      final response = await DataService.sendUpdateRole(idPengguna!);
      if (response.statusCode == 200) {
        authCubit.becomePro();
        scaffoldMsg();
      } else {
        debugPrint('gagal karena ${response.statusCode}');
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Akun anda sudah akun Pro!')));
    }
  }

  @override
  Widget build(BuildContext context) {
    final authCubit = BlocProvider.of<AuthCubit>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Konfirmasi Upgrade ke Pro'),
        backgroundColor: Colors.blueGrey,
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/bg 2.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Upgrade ke Pro',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Dengan meng-upgrade ke akun Pro, Anda akan mendapatkan fitur-fitur eksklusif seperti:',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                '- Akses tak terbatas ke semua konten\n'
                '- Bebas iklan\n'
                '- Dukungan pelanggan prioritas\n'
                '- Dan banyak lagi...',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Apakah Anda yakin ingin meng-upgrade ke akun Pro?',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // Logika untuk konfirmasi upgrade
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Konfirmasi'),
                            content: const Text(
                                'Apakah Anda yakin ingin meng-upgrade ke akun Pro?'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text('Batal'),
                              ),
                              TextButton(
                                onPressed: () {
                                  // Logika untuk upgrade
                                  _becomePro(authCubit);
                                  Navigator.of(context).pop();
                                },
                                child: const Text('Ya'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: const Text('Upgrade Sekarang'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
