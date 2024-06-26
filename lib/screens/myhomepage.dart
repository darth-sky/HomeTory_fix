import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hometory/components/customSearchDelegate.dart';
import 'package:hometory/cubit/auth/cubit/auth_cubit.dart';
import 'package:hometory/dto/pengguna.dart';
import 'package:hometory/screens/BarangScreen.dart';
import 'package:hometory/screens/HomeScreen.dart';
import 'package:hometory/screens/ProfileScreen.dart';
import 'package:hometory/screens/google_map_page.dart';
import 'package:hometory/screens/konfirmasiPro.dart';
import 'package:hometory/services/data_services.dart';

class Myhomepage extends StatefulWidget {
  const Myhomepage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyhomepageState createState() => _MyhomepageState();
}

class _MyhomepageState extends State<Myhomepage> {
  Future<List<Pengguna>>? _pengguna;
  int _selectedIndex = 0;
  BottomNavigationBarType _bottomNavType = BottomNavigationBarType.shifting;

  @override
  void initState() {
    super.initState();
    final idPengguna = context.read<AuthCubit>().state.idPengguna;
    _pengguna = DataService.fetchUserById(idPengguna.toString());
  }

  final List<Widget> _screens = [
    const HomeScreen(),
    const BarangScreen(),
  ];

  final List<String> _appBarTitles = const [
    'Ruangan',
    'Barang',
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final authCubit = BlocProvider.of<AuthCubit>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(_appBarTitles[_selectedIndex]),
        backgroundColor: Colors.blueGrey,
      ),
      body: _screens[_selectedIndex],
      drawer: Drawer(
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                BlocBuilder<AuthCubit, AuthState>(
                  builder: (context, state) {
                    return UserAccountsDrawerHeader(
                      accountName: Text(state.username),
                      accountEmail: Text(state.roles),
                      currentAccountPicture: const CircleAvatar(
                        backgroundImage: AssetImage('assets/images/pfp.jpg'),
                      ),
                      decoration: const BoxDecoration(color: Colors.blueGrey),
                    );
                  },
                ),
                const Divider(
                  height: 10,
                ),
                ListTile(
                  leading: const Icon(Icons.card_giftcard),
                  title: const Text('Want to be a pro user?'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const KonfirmasiPro(),
                      ),
                    );
                  },
                ),
                FutureBuilder<List<Pengguna>>(
                  future: _pengguna,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final data = snapshot.data!;
                      return Container(
                        // Tambahkan Container sebagai parent
                        height: 45, // Atur tinggi Container sesuai kebutuhan
                        child: ListView.builder(
                          itemCount: data.length,
                          itemBuilder: (context, index) {
                            final item = data[index];
                            return ListTile(
                              leading: const Icon(Icons.person),
                              title: const Text('Profile'),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ProfileScreen(
                                      pengguna: item,
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      );
                    } else if (snapshot.hasError) {
                      return Text("error lokasi: ${snapshot.error}");
                    }
                    return const Center(
                        child:
                            CircularProgressIndicator()); // Tambahkan Center jika perlu
                  },
                ),
                FutureBuilder<List<Pengguna>>(
                  future: _pengguna,
                  builder: (context, snapshot) {
                    final idPengguna =
                        context.read<AuthCubit>().state.idPengguna;
                    if (snapshot.hasData) {
                      final data = snapshot.data!;
                      return Container(
                        // Tambahkan Container sebagai parent
                        height: 45, // Atur tinggi Container sesuai kebutuhan
                        child: ListView.builder(
                          itemCount: data.length,
                          itemBuilder: (context, index) {
                            final item = data[index];
                            return ListTile(
                              leading: const Icon(Icons.home_work),
                              title: const Text('Status Properti'),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => GoogleMapPage(
                                      user: item,
                                      idPengguna: idPengguna!,
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      );
                    } else if (snapshot.hasError) {
                      return Text("error lokasi: ${snapshot.error}");
                    }
                    return const Center(
                        child:
                            CircularProgressIndicator()); // Tambahkan Center jika perlu
                  },
                ),

                // ListTile(
                //   leading: const Icon(Icons.card_giftcard),
                //   title: const Text('google map'),
                //   onTap: () {
                //     Navigator.push(
                //       context,
                //       MaterialPageRoute(
                //         builder: (context) => const GoogleMapPage(),
                //       ),
                //     );
                //   },
                // ),
                // ListTile(
                //   leading: const Icon(Icons.person),
                //   title: const Text('Profile'),
                //   onTap: () {
                //     Navigator.pushNamed(context, '/inside-ruangan');
                //   },
                // ),
                ListTile(
                  leading: const Icon(Icons.logout),
                  title: const Text("Logout"),
                  onTap: () {
                    authCubit.logout();
                    Navigator.pushReplacementNamed(context, '/');
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blueGrey,
        unselectedItemColor: Colors.black54,
        // backgroundColor: Colors.black,
        type: _bottomNavType,
        onTap: _onItemTapped,
        items: _navBarItems,
      ),
    );
  }
}

const _navBarItems = [
  BottomNavigationBarItem(
    icon: Icon(Icons.meeting_room_outlined),
    activeIcon: Icon(Icons.meeting_room),
    label: 'Ruangan',
  ),
  BottomNavigationBarItem(
    icon: Icon(Icons.category_outlined),
    activeIcon: Icon(Icons.category),
    label: 'Barang',
  ),
];
