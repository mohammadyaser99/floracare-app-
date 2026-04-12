import 'package:flutter/material.dart';
import '../widgets/plant_card.dart';
import '../data/dummy_data.dart';
import 'add_plant_screen.dart';
import 'weekly_schedule_screen.dart';
import 'light_check_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  void refreshScreen() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('نباتاتي - FloraCare'),
        backgroundColor: Colors.green,
        centerTitle: true,

        actions: [

          IconButton(
            icon: const Icon(Icons.wb_sunny, color: Colors.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const LightCheckScreen()),
              );
            },
          ),
          //  زر التقويم الأسبوعي
          IconButton(
            icon: const Icon(Icons.calendar_month, color: Colors.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const WeeklyScheduleScreen()),
              );
            },
          ),
        ],
      ),

      body: ListView.builder(
        padding: const EdgeInsets.only(top: 10, bottom: 80),
        itemCount: dummyPlants.length,
        itemBuilder: (context, index) {
          final reversedIndex = dummyPlants.length - 1 - index;
          final plant = dummyPlants[reversedIndex];

          return PlantCard(
            plantName: plant['name']!,
            status: plant['status']!,
            lastWatered: plant['lastWatered']!,
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddPlantScreen()),
          );

          if (result == true) {
            refreshScreen();
          }
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}