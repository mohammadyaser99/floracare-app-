import 'package:flutter/material.dart';
import 'dart:ui';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/constants.dart';
import '../utils/helpers.dart';
import '../widgets/plant_card.dart';
import '../widgets/glass_container.dart';
import '../data/dummy_data.dart';
import '../models/item_model.dart';

import 'favorite_screen.dart';
import 'weekly_schedule_screen.dart';
import 'light_check_screen.dart';
import 'plant_details_screen.dart';
import 'add_plant_screen.dart';
import 'about_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String searchQuery = "";

  @override
  void initState() {
    super.initState();
    _loadPlantsFromMemory();
  }

  Future<void> _loadPlantsFromMemory() async {
    final prefs = await SharedPreferences.getInstance();
    final String? plantsString = prefs.getString('my_plants');

    if (plantsString != null) {
      final List<dynamic> decodedData = jsonDecode(plantsString);
      setState(() {
        dummyPlants.clear();
        dummyPlants.addAll(decodedData.map((item) => ItemModel.fromJson(item)).toList());
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final filteredPlants = dummyPlants.where((plant) {
      return plant.name.toLowerCase().contains(searchQuery.toLowerCase());
    }).toList();

    return Scaffold(
      backgroundColor: Colors.black,
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
              filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
              child: Container(color: kBackgroundColor.withOpacity(0.8)),
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('FloraCare', style: kTitleStyle),
                      Row(
                        children: [
                          BounceAnimation(
                            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const AboutScreen())),
                            child: const Icon(Icons.groups, color: Colors.blueAccent, size: 28),
                          ),
                          const SizedBox(width: 15),
                          BounceAnimation(
                            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const FavoriteScreen())),
                            child: const Icon(Icons.favorite, color: Colors.redAccent, size: 28),
                          ),
                          const SizedBox(width: 15),
                          BounceAnimation(
                            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const WeeklyScheduleScreen())),
                            child: const Icon(Icons.calendar_month, color: kAccentColor, size: 28),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: GlassContainer(
                    child: TextField(
                      onChanged: (value) => setState(() => searchQuery = value),
                      style: const TextStyle(color: kAccentColor, fontWeight: FontWeight.bold),
                      decoration: const InputDecoration(
                        hintText: 'ابحث عن نبتتك...',
                        hintStyle: TextStyle(color: Colors.black45),
                        prefixIcon: Icon(Icons.search, color: kAccentColor),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(vertical: 15),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: BounceAnimation(
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const LightCheckScreen())),
                    child: GlassContainer(
                      padding: const EdgeInsets.all(15),
                      child: Row(
                        children: const [
                          Icon(Icons.health_and_safety, color: kAccentColor, size: 30),
                          SizedBox(width: 15),
                          Text(
                            'مساعد الفحص السريع 🩺',
                            style: TextStyle(color: kAccentColor, fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: filteredPlants.isEmpty
                      ? const Center(child: Text('لا توجد نباتات ', style: kSubtitleStyle))
                      : ListView.builder(
                    itemCount: filteredPlants.length,
                    itemBuilder: (context, index) {
                      final plant = filteredPlants[index];

                      return Dismissible(
                        key: Key(plant.id),
                        direction: DismissDirection.endToStart,
                        onDismissed: (direction) async {
                          setState(() {
                            dummyPlants.remove(plant);
                          });

                          final prefs = await SharedPreferences.getInstance();
                          await prefs.setString('my_plants', jsonEncode(dummyPlants.map((p) => p.toJson()).toList()));

                          if (mounted) {
                            showCustomSnackBar(context, 'تم حذف ${plant.name} بنجاح', isError: true);
                          }
                        },
                        background: Container(
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          color: Colors.redAccent.withOpacity(0.7),
                          child: const Icon(Icons.delete, color: Colors.white, size: 30),
                        ),
                        child: PlantCard(
                          plantName: plant.name,
                          status: plant.status,
                          lastWatered: plant.lastWatered,
                          imageUrl: plant.imageUrl,
                          isFavorite: plant.isFavorite,
                          onFavoriteToggle: () async {
                            setState(() => plant.isFavorite = !plant.isFavorite);
                            final prefs = await SharedPreferences.getInstance();
                            await prefs.setString('my_plants', jsonEncode(dummyPlants.map((p) => p.toJson()).toList()));
                          },
                          onWatering: () async {
                            setState(() => plant.lastWatered = 'الآن');
                            final prefs = await SharedPreferences.getInstance();
                            await prefs.setString('my_plants', jsonEncode(dummyPlants.map((p) => p.toJson()).toList()));
                          },
                          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => PlantDetailsScreen(plant: plant))),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: BounceAnimation(
        onTap: () async {
          await Navigator.push(context, MaterialPageRoute(builder: (context) => const AddPlantScreen()));
          setState(() {});
        },
        child: FloatingActionButton(
          backgroundColor: kSecondaryColor,
          onPressed: null,
          child: const Icon(Icons.add, color: Colors.black87),
        ),
      ),
    );
  }
}