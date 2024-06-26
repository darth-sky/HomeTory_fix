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
      width: 190,
      // Removed the fixed height
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white70,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize
            .min, // Ensures the column takes up only as much space as needed
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: image.image,
                // fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          // const SizedBox(height: 18),
          Text(
            roomName,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            'Jumlah Container: $containerCount',
            style: const TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
          Text(
            'Jumlah Barang: $itemCount',
            style: const TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
