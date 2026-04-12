import 'package:flutter/material.dart';
import '../screens/plant_details_screen.dart'; // هذا هو الاستدعاء الذي كان ناقصاً!

class PlantCard extends StatelessWidget {
  final String plantName;
  final String status;
  final String lastWatered;

  const PlantCard({
    super.key,
    required this.plantName,
    required this.status,
    required this.lastWatered,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      // لاحظ هنا: يوجد ListTile واحدة فقط مرتبة بشكل نظيف
      child: ListTile(
        onTap: () {
          // برمجة الانتقال عند الضغط على البطاقة
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PlantDetailsScreen(
                plantName: plantName,
                status: status,
                lastWatered: lastWatered,
              ),
            ),
          );
        },
        contentPadding: const EdgeInsets.all(16),
        leading: CircleAvatar(
          backgroundColor: Colors.green.shade100,
          radius: 30,
          child: const Icon(Icons.local_florist, color: Colors.green, size: 35),
        ),
        title: Text(
          plantName,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 5),
            Text(
                'الحالة: $status',
                style: TextStyle(color: status == 'عطشان' ? Colors.red : Colors.grey[700])
            ),
            Text('آخر ري: $lastWatered', style: const TextStyle(fontSize: 12)),
          ],
        ),
        trailing: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
          onPressed: () {
            // سنبرمج زر "تم الري" لاحقاً
          },
          child: const Text('تم الري', style: TextStyle(color: Colors.white)),
        ),
      ),
    );
  }
}