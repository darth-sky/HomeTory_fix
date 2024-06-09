import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hometory/components/barangWidget.dart';
import 'package:hometory/cubit/container/cubit/containers_cubit.dart';

class BarangScreen extends StatefulWidget {
  const BarangScreen({Key? key}) : super(key: key);

  @override
  _BarangScreenState createState() => _BarangScreenState();
}

class _BarangScreenState extends State<BarangScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ContainersCubit>().fetchContainersCubit();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Material(
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  // onTap: () {
                  //   Navigator.push(context,
                  //       MaterialPageRoute(builder: (context) => KipasScreen()));
                  // },
                  child: const BarangWidget(
                      imageUrl: 'assets/images/kipas_angin.jpg',
                      barangName: 'Kipas Angin'),
                ),
                GestureDetector(
                  // onTap: () {
                  //   Navigator.push(context,
                  //       MaterialPageRoute(builder: (context) => PoloScreen()));
                  // },
                  child: const BarangWidget(
                      imageUrl: 'assets/images/baju_polo.jpg',
                      barangName: 'Baju Polo FTK'),
                ),
                
              ],
            ),
          ),
        ),
      ),
    );
  }
}
