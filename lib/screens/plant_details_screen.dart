import 'package:flutter/material.dart';

class PlantDetailsScreen extends StatelessWidget {
  final String plantName;
  final String status;
  final String lastWatered;

  const PlantDetailsScreen({
    super.key,
    required this.plantName,
    required this.status,
    required this.lastWatered,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('تفاصيل $plantName'), // سيعرض اسم النبتة هنا
        backgroundColor: Colors.green,
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.local_florist, size: 120, color: Colors.green),
            const SizedBox(height: 20),
            Text(
                'الاسم: $plantName',
                style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold)
            ),
            const SizedBox(height: 15),
            Text(
                'الحالة: $status',
                style: TextStyle(
                    fontSize: 20,
                    color: status == 'عطشان' ? Colors.red : Colors.green[800],
                    fontWeight: FontWeight.bold
                )
            ),
            const SizedBox(height: 15),
            Text(
                'آخر ري: $lastWatered',
                style: const TextStyle(fontSize: 18, color: Colors.grey)
            ),
          ],
        ),
      ),
    );
  }
}