import 'package:flutter/material.dart';

class ContainerWidget extends StatelessWidget {
  final String imageUrl;
  final String containerName;
  final int itemCount;

  const ContainerWidget({
    Key? key,
    required this.imageUrl,
    required this.containerName,
    required this.itemCount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 356,
      height: 100,
      margin: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.blueGrey[100],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: 100,
            height: 150,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Image.network(
              imageUrl,
              errorBuilder: (context, error, stackTrace) =>
                  const Icon(Icons.error),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            containerName,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const VerticalDivider(
            color: Colors.black,
            thickness: 1,
            width: 20,
            indent: 5,
            endIndent: 5,
          ),
          Container(
            width: 150,
            margin: const EdgeInsets.only(left: 5),
            child: ListTile(
              leading: const Icon(Icons.category),
              title: Text(
                'Jumlah Barang: $itemCount',
                style: const TextStyle(fontSize: 14),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PointItem extends StatelessWidget {
  final IconData icon;
  final String label;

  const PointItem({
    Key? key,
    required this.icon,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(label),
    );
  }
}
