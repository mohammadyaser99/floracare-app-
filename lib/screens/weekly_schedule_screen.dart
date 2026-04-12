import 'package:flutter/material.dart';
import '../data/dummy_data.dart';

class WeeklyScheduleScreen extends StatefulWidget {
  const WeeklyScheduleScreen({super.key});

  @override
  State<WeeklyScheduleScreen> createState() => _WeeklyScheduleScreenState();
}

class _WeeklyScheduleScreenState extends State<WeeklyScheduleScreen> {
  // متغير يحفظ حالة "الصح" لكل نبتة بناءً على عددها
  // في البداية نجعلها كلها false (لم يتم الري)
  List<bool> isWatered = List.generate(dummyPlants.length, (index) => false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('جدول الري الأسبوعي'),
        backgroundColor: Colors.green,
        centerTitle: true,
      ),

      body: ListView.builder(
        itemCount: dummyPlants.length,
        itemBuilder: (context, index) {
          final plant = dummyPlants[index];

          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: CheckboxListTile(
              title: Text(plant['name']!, style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text('الحالة: ${plant['status']}'),
              secondary: const Icon(Icons.water_drop, color: Colors.blue), // أيقونة قطرة ماء
              activeColor: Colors.green, // لون علامة الصح
              value: isWatered[index], // حالة الصح الحالية
              onChanged: (bool? value) {
                // عند الضغط، نحدث الشاشة ونغير حالة الصح
                setState(() {
                  isWatered[index] = value ?? false;
                });
              },
            ),
          );
        },
      ),
    );
  }
}