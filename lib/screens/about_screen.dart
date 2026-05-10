import 'package:flutter/material.dart';
import 'dart:ui';
import '../utils/constants.dart';
import '../widgets/glass_container.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('فريق التطوير', style: kTitleStyle),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: kAccentColor),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.network(
              'https://images.unsplash.com/photo-1536882240095-0379873feb4e?q=80&w=800&auto=format&fit=crop',
              fit: BoxFit.cover,
            ),
          ),
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 12.0, sigmaY: 12.0),
              child: Container(color: Colors.white.withOpacity(0.3)),
            ),
          ),
          SafeArea(
            child: ListView(
              padding: const EdgeInsets.all(20),
              children: [
                const SizedBox(height: 20),
                const Center(
                  child: Icon(Icons.rocket_launch, size: 80, color: kPrimaryColor),
                ),
                const SizedBox(height: 15),
                const Center(
                  child: Text(
                    'تم بناء هذا التطبيق بشغف بواسطة:',
                    style: kSubtitleStyle,
                  ),
                ),
                const SizedBox(height: 30),
                _buildDeveloperCard('عبدالله عبدالعزيز العمري'),
                const SizedBox(height: 15),
                _buildDeveloperCard('بشار توفيق باسرده'),
                const SizedBox(height: 15),
                _buildDeveloperCard('محمد ياسر باحاج'),
                const SizedBox(height: 40),
                const Center(
                  child: Text(
                    'الإصدار 1.0.0',
                    style: TextStyle(color: Colors.black38, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDeveloperCard(String name) {
    return GlassContainer(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: kPrimaryColor.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.computer, color: kPrimaryColor, size: 28),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: kTitleStyle.copyWith(fontSize: 18),
                ),
                const SizedBox(height: 5),
                const Text(
                  'مهندس برمجيات',
                  style: TextStyle(color: kPrimaryColor, fontWeight: FontWeight.bold, fontSize: 13),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}