import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hometory/components/customSearchDelegate.dart';
import 'package:hometory/cubit/auth/cubit/auth_cubit.dart';
import 'package:hometory/screens/BarangScreen.dart';
import 'package:hometory/screens/HomeScreen.dart';
import 'package:hometory/screens/konfirmasiPro.dart';

class Myhomepage extends StatefulWidget {
  const Myhomepage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyhomepageState createState() => _MyhomepageState();
}

class _MyhomepageState extends State<Myhomepage> {
  int _selectedIndex = 0;
  BottomNavigationBarType _bottomNavType = BottomNavigationBarType.shifting;

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
                      currentAccountPicture: CircleAvatar(
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
                  title: const Text('Want to go premium?'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const KonfirmasiPro(),
                      ),
                    );
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.person),
                  title: const Text('Profile'),
                  onTap: () {
                    Navigator.pushNamed(context, '/inside-ruangan');
                  },
                ),
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
        unselectedItemColor: Colors.blueGrey,
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
