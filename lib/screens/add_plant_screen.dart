import 'package:flutter/material.dart';
import '../data/dummy_data.dart'; // استدعاء مخزن البيانات لإضافة النبتة الجديدة

class AddPlantScreen extends StatefulWidget {
  const AddPlantScreen({super.key});

  @override
  State<AddPlantScreen> createState() => _AddPlantScreenState();
}

class _AddPlantScreenState extends State<AddPlantScreen> {
  // 1. إنشاء "متحكمات" لالتقاط النص الذي يكتبه المستخدم
  final TextEditingController nameController = TextEditingController();
  final TextEditingController typeController = TextEditingController();

  // 2. دالة (Function) تُنفذ عند الضغط على زر الحفظ
  void saveNewPlant() {
    // التأكد أن الحقول ليست فارغة
    if (nameController.text.isNotEmpty && typeController.text.isNotEmpty) {
      // إضافة النبتة الجديدة إلى مخزن البيانات (dummyPlants)
      setState(() {
        dummyPlants.add({
          'name': nameController.text, // الاسم من الحقل الأول
          'status': 'تم الري', // حالة افتراضية
          'lastWatered': 'الآن', // تاريخ افتراضي
        });
      });
      // العودة للشاشة الرئيسية بعد الحفظ
      Navigator.pop(context, true);
    } else {
      // إظهار رسالة تنبيه إذا كانت الحقول فارغة
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('الرجاء إدخال اسم ونوع النبتة!')),
      );
    }
  }

  //  تنظيف الذاكرة عند الخروج من الشاشة
  @override
  void dispose() {
    nameController.dispose();
    typeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('إضافة نبتة جديدة'),
        backgroundColor: Colors.green,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: nameController, // ربط الحقل بالمتحكم الأول
              decoration: const InputDecoration(
                labelText: 'اسم النبتة (مثلاً: طماطم، ملوخية)',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.eco),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: typeController, // ربط الحقل بالمتحكم الثاني
              decoration: const InputDecoration(
                labelText: 'النوع (خضروات، زهور، أشجار)',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.category),
              ),
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                onPressed: saveNewPlant, // استدعاء دالة الحفظ عند الضغط
                child: const Text('حفظ النبتة', style: TextStyle(color: Colors.white, fontSize: 18)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}