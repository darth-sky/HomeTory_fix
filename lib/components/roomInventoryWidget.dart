import 'package:flutter/material.dart';

class RoomInventoryWidget extends StatelessWidget {
  final Image image;
  final String roomName;
  final int containerCount;
  final int itemCount;

  const RoomInventoryWidget({
    super.key,
    required this.image,
    required this.roomName,
    required this.itemCount,
    required this.containerCount,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350,
      height: 290,
      margin: const EdgeInsets.all(18),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.blueGrey[100],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 300,
            height: 150,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: image.image,
                fit: BoxFit.fitHeight,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          Text(
            roomName,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 35,
            child: ListTile(
              leading: const Icon(Icons.storage),
              title: Text(
                'Jumlah Container: $containerCount',
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.category),
            title: Text(
              'Jumlah Barang: $itemCount',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
