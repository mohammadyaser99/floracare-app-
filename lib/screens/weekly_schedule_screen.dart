import 'package:flutter/material.dart';
import 'dart:ui';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/constants.dart';
import '../widgets/glass_container.dart';
import '../utils/helpers.dart';
import '../models/item_model.dart';

class WeeklyScheduleScreen extends StatefulWidget {
  const WeeklyScheduleScreen({super.key});

  @override
  State<WeeklyScheduleScreen> createState() => _WeeklyScheduleScreenState();
}

class _WeeklyScheduleScreenState extends State<WeeklyScheduleScreen> {
  final List<String> _days = ['الإثنين', 'الثلاثاء', 'الأربعاء', 'الخميس', 'الجمعة', 'السبت', 'الأحد'];
  final Set<String> _watered = {};
  List<ItemModel> _realPlants = [];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final prefs = await SharedPreferences.getInstance();
    final String? data = prefs.getString('my_plants');

    if (data != null) {
      setState(() {
        _realPlants = (jsonDecode(data) as List).map((i) => ItemModel.fromJson(i)).toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    int todayIndex = DateTime.now().weekday - 1;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('جدول المهام', style: kTitleStyle),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: kAccentColor),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.network(
                'https://images.unsplash.com/photo-1518531933037-91b2f5f229cc?q=80&w=800&auto=format&fit=crop',
                fit: BoxFit.cover
            ),
          ),
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
              child: Container(color: kBackgroundColor.withOpacity(0.6)),
            ),
          ),
          SafeArea(
            child: _realPlants.isEmpty
                ? const Center(child: Text('لا توجد نباتات مضافة حالياً', style: kSubtitleStyle))
                : ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: 7,
              itemBuilder: (context, i) {
                int realIndex = (todayIndex + i) % 7;
                String dayTitle = i == 0 ? 'مهام اليوم' : (i == 1 ? 'مهام الغد' : _days[realIndex]);

                var dayPlants = _realPlants.where((p) => (_realPlants.indexOf(p) + realIndex) % 2 == 0).toList();

                if (dayPlants.isEmpty) dayPlants.add(_realPlants.first);

                return Padding(
                  padding: const EdgeInsets.only(bottom: 25),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          dayTitle,
                          style: TextStyle(
                              color: i == 0 ? kPrimaryColor : Colors.white,
                              fontSize: i == 0 ? 22 : 18,
                              fontWeight: FontWeight.bold
                          )
                      ),
                      const SizedBox(height: 10),
                      GlassContainer(
                        padding: const EdgeInsets.all(8),
                        child: Column(
                          children: dayPlants.map((plant) {
                            String taskId = '${plant.id}_$realIndex';
                            bool isDone = _watered.contains(taskId);

                            return ListTile(
                              contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                              leading: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(
                                  plant.imageUrl,
                                  width: 50,
                                  height: 50,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Container(
                                      width: 50,
                                      height: 50,
                                      color: kPrimaryColor.withOpacity(0.2),
                                      child: const Icon(Icons.eco, color: kPrimaryColor),
                                    );
                                  },
                                ),
                              ),
                              title: Text(
                                  plant.name,
                                  style: TextStyle(
                                      color: isDone ? Colors.white54 : Colors.white,
                                      decoration: isDone ? TextDecoration.lineThrough : null,
                                      fontWeight: FontWeight.bold
                                  )
                              ),
                              subtitle: Text(
                                  dayPlants.indexOf(plant) % 2 == 0 ? 'صباحاً' : 'مساءً',
                                  style: TextStyle(color: isDone ? Colors.white38 : kPrimaryColor)
                              ),
                              trailing: BounceAnimation(
                                onTap: () => setState(() {
                                  isDone ? _watered.remove(taskId) : _watered.add(taskId);
                                }),
                                child: Icon(
                                    isDone ? Icons.check_circle : Icons.water_drop,
                                    color: isDone ? Colors.green : kPrimaryColor,
                                    size: 30
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}