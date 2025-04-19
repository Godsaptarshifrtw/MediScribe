import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'home_content.dart';
import '/controllers/component_controllers/pdf_controller.dart';
import '/controllers/component_controllers/image_controller.dart';
import 'img_preview.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final RxInt _selectedIndex = 0.obs;

  final List<Widget> _screens = [
    const HomeContent(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Obx(() => _screens[_selectedIndex.value]),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF9575CD),
        onPressed: () async {
          final picker = ImagePicker();
          final pickedFile = await picker.pickImage(source: ImageSource.camera);

          if (pickedFile != null) {
            final imageFile = File(pickedFile.path);
            Get.find<ImageController>().pickImage(imageFile);

            // Show snackbar
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Image captured successfully')),
            );

            // TODO: Navigate to preview screen if desired
             Get.to(() => ImagePreviewScreen());
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('No image captured')),
            );
          }
        },
        elevation: 8,
        child: const Icon(Icons.add, color: Colors.white, size: 28),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 8.0,
        color: const Color(0xFFF3E5F5),
        elevation: 8,
        child: SafeArea(
          top: false,
          child: SizedBox(
            height: 48,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildNavItem(icon: Icons.home, label: 'Home', index: 0),
                const SizedBox(width: 48),
                _buildNavItem(icon: Icons.person, label: 'Profile', index: 1),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required IconData icon,
    required String label,
    required int index,
  }) {
    return Obx(() {
      final isSelected = _selectedIndex.value == index;
      return GestureDetector(
        onTap: () => _selectedIndex.value = index,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 26,
              color: isSelected ? const Color(0xFF7E57C2) : Colors.black54,
            ),
            Text(
              label,
              style: TextStyle(
                fontSize: 13,
                color: isSelected ? const Color(0xFF7E57C2) : Colors.black54,
              ),
            ),
          ],
        ),
      );
    });
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Profile Screen'),
    );
  }
}
