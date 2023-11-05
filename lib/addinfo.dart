import 'package:flutter/material.dart';

class AddInfo extends StatelessWidget {
  final IconData icon;
  final String data;
  final String amt;
  const AddInfo({
    super.key,
    required this.icon,
    required this.data,
    required this.amt,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: Column(
        children: [
          Icon(
            icon,
            size: 20,
            color: Colors.white,
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            data,
            style: const TextStyle(
              fontSize: 15,
              color: Colors.white,
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            amt.toString(),
            style: const TextStyle(
              fontSize: 15,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
