import 'package:flutter/material.dart';
import 'dart:io';

import '../models/item_model.dart';
import '../utils/constants.dart';
import '../widgets/glass_container.dart';

class PlantDetailsScreen extends StatelessWidget {
  final ItemModel plant;

  const PlantDetailsScreen({super.key, required this.plant});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: kAccentColor),
      ),
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        child: Column(
          children: [
            plant.imageUrl.startsWith('http')
                ? Image.network(
              plant.imageUrl,
              width: double.infinity,
              height: 400,
              fit: BoxFit.cover,
            )
                : Image.file(
              File(plant.imageUrl),
              width: double.infinity,
              height: 400,
              fit: BoxFit.cover,
            ),
            Transform.translate(
              offset: const Offset(0, -40),
              child: GlassContainer(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                padding: const EdgeInsets.all(25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      plant.name,
                      style: kTitleStyle.copyWith(fontSize: 28),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Icon(
                          plant.isFavorite ? Icons.favorite : Icons.favorite_border,
                          color: kErrorColor,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          plant.isFavorite ? 'من نباتاتك المفضلة' : 'ليست في المفضلة',
                          style: kSubtitleStyle,
                        ),
                      ],
                    ),
                    const Divider(color: Colors.black12, height: 40),
                    _buildInfoRow(Icons.water_drop, Colors.blueAccent, 'احتياج الري:', plant.waterAmount),
                    const SizedBox(height: 20),
                    _buildInfoRow(Icons.wb_sunny, Colors.orangeAccent, 'احتياج الشمس:', plant.sunlight),
                    const SizedBox(height: 20),
                    _buildInfoRow(Icons.history, kPrimaryColor, 'آخر سقي:', plant.lastWatered),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, Color iconColor, String title, String value) {
    return Row(
      children: [
        Icon(icon, color: iconColor, size: 28),
        const SizedBox(width: 15),
        Text(
          title,
          style: const TextStyle(color: Colors.black54, fontWeight: FontWeight.bold),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            value,
            style: kTitleStyle.copyWith(fontSize: 18),
          ),
        ),
      ],
    );
  }
}