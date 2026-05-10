import 'package:flutter/material.dart';
import 'dart:io';

import '../utils/constants.dart';
import '../utils/helpers.dart';
import 'glass_container.dart';

class PlantCard extends StatelessWidget {
  final String plantName;
  final String status;
  final String lastWatered;
  final String imageUrl;
  final bool isFavorite;

  final VoidCallback onFavoriteToggle;
  final VoidCallback onWatering;
  final VoidCallback onTap;

  const PlantCard({
    super.key,
    required this.plantName,
    required this.status,
    required this.lastWatered,
    required this.imageUrl,
    required this.isFavorite,
    required this.onFavoriteToggle,
    required this.onWatering,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: BounceAnimation(
        onTap: onTap,
        child: GlassContainer(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              Hero(
                tag: plantName,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Container(
                    width: 80,
                    height: 80,
                    color: Colors.black.withOpacity(0.05),
                    child: imageUrl.startsWith('http')
                        ? Image.network(
                      imageUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => const Icon(Icons.eco, color: kSecondaryColor),
                    )
                        : Image.file(
                      File(imageUrl),
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => const Icon(Icons.eco, color: kSecondaryColor),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(plantName, style: kTitleStyle.copyWith(fontSize: 18)),
                    const SizedBox(height: 4),
                    Text(status, style: const TextStyle(color: kPrimaryColor, fontSize: 12, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 4),
                    Text('آخر سقي: $lastWatered', style: const TextStyle(color: Colors.black54, fontSize: 11, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              Column(
                children: [
                  IconButton(
                    icon: Icon(
                      isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: isFavorite ? Colors.redAccent : Colors.black38,
                    ),
                    onPressed: onFavoriteToggle,
                  ),
                  BounceAnimation(
                    onTap: onWatering,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.blueAccent.withOpacity(0.2),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.water_drop, color: Colors.blueAccent, size: 20),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}