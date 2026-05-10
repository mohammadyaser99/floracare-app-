import 'package:flutter/material.dart';
import 'dart:ui';

import '../utils/constants.dart';
import '../widgets/glass_container.dart';
import '../utils/helpers.dart';

class LightCheckScreen extends StatefulWidget {
  const LightCheckScreen({super.key});

  @override
  State<LightCheckScreen> createState() => _LightCheckScreenState();
}

class _LightCheckScreenState extends State<LightCheckScreen> {
  bool isYellow = false;
  bool isDry = false;
  bool inShade = false;

  String diagnosis = 'أجب عن الأسئلة بالأعلى واضغط على زر الفحص لمعرفة حالة نبتتك 🌿';

  void _generateDiagnosis() {
    setState(() {
      if (isYellow && isDry) {
        diagnosis = '⚠️ النبتة عطشى جداً!\nالأوراق الصفراء والتربة الجافة تعني أنها تحتاج للماء فوراً.';
      } else if (isYellow && !isDry) {
        diagnosis = '⚠️ احذر! ري زائد!\nالتربة رطبة والأوراق صفراء، النبتة تختنق بالماء. توقف عن السقي ودعها تجف.';
      } else if (inShade && !isYellow) {
        diagnosis = '💡 النبتة بصحة جيدة، ولكن وجودها في الظل الدائم سيضعف نموها. وفر لها إضاءة غير مباشرة.';
      } else if (!isYellow && isDry) {
        diagnosis = '💧 التربة جافة حان وقت السقي.\nنبتتك بخير، فقط أعطها حصتها من الماء.';
      } else {
        diagnosis = '✅ نبتتك في حالة ممتازة!\nاستمر في هذه العناية الرائعة ولا تغير شيئاً.';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('مساعد الفحص السريع 🩺', style: kTitleStyle),
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
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: GlassContainer(
                  padding: const EdgeInsets.all(25),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.health_and_safety, size: 70, color: kPrimaryColor),
                      const SizedBox(height: 15),
                      const Text(
                        'أجب بنعم أو لا:',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: kAccentColor),
                      ),
                      const SizedBox(height: 20),
                      SwitchListTile(
                        title: const Text('هل أوراق النبتة صفراء أو باهتة؟', style: TextStyle(fontWeight: FontWeight.bold)),
                        value: isYellow,
                        activeColor: kPrimaryColor,
                        onChanged: (val) => setState(() => isYellow = val),
                      ),
                      SwitchListTile(
                        title: const Text('هل التربة جافة تماماً عند لمسها؟', style: TextStyle(fontWeight: FontWeight.bold)),
                        value: isDry,
                        activeColor: kPrimaryColor,
                        onChanged: (val) => setState(() => isDry = val),
                      ),
                      SwitchListTile(
                        title: const Text('هل النبتة موجودة في الظل الدائم؟', style: TextStyle(fontWeight: FontWeight.bold)),
                        value: inShade,
                        activeColor: kPrimaryColor,
                        onChanged: (val) => setState(() => inShade = val),
                      ),
                      const SizedBox(height: 20),
                      const Divider(color: Colors.black26),
                      const SizedBox(height: 15),
                      Text(
                        diagnosis,
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: kAccentColor, fontSize: 16, height: 1.5, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 25),
                      BounceAnimation(
                        onTap: _generateDiagnosis,
                        child: Container(
                          width: double.infinity,
                          height: 55,
                          decoration: BoxDecoration(
                            color: kPrimaryColor,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: const Center(
                            child: Text('حلل حالة النبتة 🩺', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}