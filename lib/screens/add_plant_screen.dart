import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:ui';
import 'dart:convert';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/constants.dart';
import '../utils/helpers.dart';
import '../widgets/glass_container.dart';
import '../data/dummy_data.dart';
import '../models/item_model.dart';

class AddPlantScreen extends StatefulWidget {
  const AddPlantScreen({super.key});

  @override
  State<AddPlantScreen> createState() => _AddPlantScreenState();
}

class _AddPlantScreenState extends State<AddPlantScreen> {
  final TextEditingController _nameController = TextEditingController();
  File? _selectedImage;
  final ImagePicker _picker = ImagePicker();

  Future<void> _takePhoto() async {
    try {
      final XFile? photo = await _picker.pickImage(source: ImageSource.camera, imageQuality: 70);

      if (photo != null) {
        setState(() {
          _selectedImage = File(photo.path);
        });
      }
    } catch (e) {
      showCustomSnackBar(context, 'فشل فتح الكاميرا', isError: true);
    }
  }

  Future<void> _savePlant() async {
    if (_nameController.text.isEmpty || _selectedImage == null) {
      showCustomSnackBar(context, 'يرجى إدخال اسم وصورة 📸', isError: true);
      return;
    }

    final newItem = ItemModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: _nameController.text,
      status: 'نبتة جديدة ',
      lastWatered: 'لم يتم السقي بعد',
      imageUrl: _selectedImage!.path,
      isFavorite: false,
      waterAmount: 'متوسط',
      sunlight: 'إضاءة ساطعة',
    );

    setState(() {
      dummyPlants.insert(0, newItem);
    });

    final prefs = await SharedPreferences.getInstance();
    final String plantsString = jsonEncode(dummyPlants.map((p) => p.toJson()).toList());
    await prefs.setString('my_plants', plantsString);

    if (mounted) {
      showCustomSnackBar(context, 'تمت إضافة ${newItem.name} بنجاح! 🎉');
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('إضافة نبتة جديدة ', style: kTitleStyle),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
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
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: GlassContainer(
                padding: const EdgeInsets.all(25),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: _takePhoto,
                      child: Container(
                        height: 200,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.white.withOpacity(0.5)),
                        ),
                        child: _selectedImage != null
                            ? ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.file(_selectedImage!, fit: BoxFit.cover),
                        )
                            : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(Icons.add_a_photo, size: 50, color: kPrimaryColor),
                            SizedBox(height: 10),
                            Text('اضغط لتصوير النبتة ', style: TextStyle(color: kAccentColor, fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 25),
                    TextField(
                      controller: _nameController,
                      style: const TextStyle(color: kAccentColor, fontWeight: FontWeight.bold),
                      decoration: InputDecoration(
                        labelText: 'اسم النبتة',
                        labelStyle: const TextStyle(color: kPrimaryColor, fontWeight: FontWeight.bold),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(color: kPrimaryColor.withOpacity(0.3)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(color: kPrimaryColor, width: 2),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    BounceAnimation(
                      onTap: _savePlant,
                      child: Container(
                        width: double.infinity,
                        height: 55,
                        decoration: BoxDecoration(
                          color: kPrimaryColor,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: const Center(
                          child: Text(
                            'حفظ النبتة ',
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}