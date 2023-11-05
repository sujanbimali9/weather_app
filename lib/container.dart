import 'package:flutter/material.dart';

class CustContainer extends StatelessWidget {
  final String time;
  final IconData icon;
  final String weather;
  const CustContainer(
      {super.key,
      required this.time,
      required this.icon,
      required this.weather});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: SizedBox(
          width: 95,
          child: Column(
            children: [
              Text(
                time,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(
                height: 8,
              ),
              Icon(
                icon,
                color: Colors.white,
                size: 40,
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                weather,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
