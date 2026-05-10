import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:ui';
import 'package:shared_preferences/shared_preferences.dart';

import '../widgets/plant_card.dart';
import '../data/dummy_data.dart';
import '../utils/constants.dart';
import '../utils/helpers.dart';
import 'plant_details_screen.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  Future<void> _savePlantsToMemory() async {
    final prefs = await SharedPreferences.getInstance();
    final String plantsString = jsonEncode(dummyPlants.map((p) => p.toJson()).toList());
    await prefs.setString('my_plants', plantsString);
  }

  @override
  Widget build(BuildContext context) {
    final favoritePlants = dummyPlants.where((plant) => plant.isFavorite).toList();

    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('المفضلة ', style: kTitleStyle),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
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
              filter: ImageFilter.blur(sigmaX: 25.0, sigmaY: 25.0),
              child: Container(
                color: kBackgroundColor.withOpacity(0.85),
              ),
            ),
          ),
          SafeArea(
            child: favoritePlants.isEmpty
                ? const Center(
              child: Text('لا توجد نباتات في المفضلة بعد! ', style: kSubtitleStyle),
            )
                : ListView.builder(
              padding: const EdgeInsets.only(top: 10, bottom: 20),
              itemCount: favoritePlants.length,
              itemBuilder: (context, index) {
                final plant = favoritePlants[index];

                return PlantCard(
                  plantName: plant.name,
                  status: plant.status,
                  lastWatered: plant.lastWatered,
                  imageUrl: plant.imageUrl,
                  isFavorite: plant.isFavorite,
                  onFavoriteToggle: () async {
                    setState(() {
                      plant.isFavorite = false;
                    });
                    await _savePlantsToMemory();

                    if (mounted) {
                      showCustomSnackBar(context, 'تمت إزالة ${plant.name}', isError: true);
                    }
                  },
                  onWatering: () async {
                    setState(() {
                      plant.lastWatered = 'الآن';
                    });
                    await _savePlantsToMemory();

                    if (mounted) {
                      showCustomSnackBar(context, 'تم سقي ${plant.name} بنجاح 💧');
                    }
                  },
                  onTap: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => PlantDetailsScreen(plant: plant)),
                    );
                    setState(() {});
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}