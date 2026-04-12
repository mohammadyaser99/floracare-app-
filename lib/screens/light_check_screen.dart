import 'package:flutter/material.dart';

class LightCheckScreen extends StatelessWidget {
  const LightCheckScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('فحص الإضاءة ☀️'),
        backgroundColor: Colors.green,
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Card(
            elevation: 8,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                mainAxisSize: MainAxisSize.min, // لكي لا تأخذ البطاقة الشاشة كاملة
                children: [
                  const Icon(Icons.wb_sunny, size: 100, color: Colors.orange),
                  const SizedBox(height: 20),
                  const Text(
                    'هل الإضاءة مناسبة لنبتتك؟',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 15),
                  const Text(
                    'قم بتوجيه كاميرا الجوال نحو المكان الذي تريد وضع النبتة فيه لفحص مستوى الإضاءة.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  const SizedBox(height: 30),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange, // لون مميز للفحص
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                      icon: const Icon(Icons.camera_alt, color: Colors.white),
                      label: const Text('افتح الكاميرا', style: TextStyle(color: Colors.white, fontSize: 18)),
                      onPressed: () {
                        // برمجة فتح الكاميرا  لاحقاً
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('سيتم تفعيل الكاميرا لاحقاً! ')),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}