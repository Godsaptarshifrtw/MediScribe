import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const HomeContent(),
    const ProfileScreen(),
  ];

  void _onNavTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _screens[_selectedIndex],
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF9575CD),
        onPressed: () {
          // TODO: Implement image upload functionality
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

  Widget _buildNavItem({required IconData icon, required String label, required int index}) {
    final isSelected = _selectedIndex == index;
    return GestureDetector(
      onTap: () => _onNavTap(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: isSelected ? const Color(0xFF7E57C2) : Colors.black54),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: isSelected ? const Color(0xFF7E57C2) : Colors.black54,
            ),
          ),
        ],
      ),
    );
  }
}

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final titleFont = screenWidth > 600 ? 26.0 : 22.0;
    final subtitleFont = screenWidth > 600 ? 16.0 : 13.0;
    final tilePadding = screenWidth > 600 ? 24.0 : 16.0;

    final List<_Feature> features = [
      _Feature("Select report from Gallery", "Scan and get insights", Icons.upload_file, const Color(0xFF7E57C2)),
      _Feature("Previous Reports", "Quick access to history", Icons.history, const Color(0xFF6A1B9A)),
    ];

    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: tilePadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "MediScribe",
                      style: GoogleFonts.roboto(
                        fontSize: titleFont,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    Builder(
                      builder: (context) {
                        return IconButton(
                          icon: const Icon(Icons.menu, color: Color(0xFF9575CD)),
                          onPressed: () {
                            final RenderBox button = context.findRenderObject() as RenderBox;
                            final RenderBox overlay = Overlay.of(context).context.findRenderObject() as RenderBox;
                            final Offset offset = button.localToGlobal(Offset.zero, ancestor: overlay);
                            final Size size = button.size;
                            showMenu<String>(
                              context: context,
                              position: RelativeRect.fromLTRB(
                                offset.dx,
                                offset.dy + size.height,
                                overlay.size.width - offset.dx - size.width,
                                0,
                              ),
                              items: <PopupMenuEntry<String>>[
                                PopupMenuItem<String>(
                                  value: 'en',
                                  child: Text('English', style: GoogleFonts.roboto()),
                                ),
                                PopupMenuItem<String>(
                                  value: 'hi',
                                  child: Text('हिंदी', style: GoogleFonts.roboto()),
                                ),
                              ],
                              color: const Color(0xFFF3E5F5),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ).then((value) {
                              if (value == 'en') {
                                // TODO: Switch to English
                              } else if (value == 'hi') {
                                // TODO: Switch to Hindi
                              }
                            });
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Column(
                children: features.map((feature) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 28),
                    child: _buildLargeFeatureTile(feature, subtitleFont, tilePadding),
                  );
                }).toList(),
              ),
              const SizedBox(height: 120),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLargeFeatureTile(_Feature feature, double subtitleFont, double tilePadding) {
    return GestureDetector(
      onTap: () {
        // TODO: Navigate to respective screen
      },
      child: Container(
        width: double.infinity,
        height: 110,
        decoration: BoxDecoration(
          color: feature.color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: feature.color.withOpacity(0.2),
            width: 1.2,
          ),
          boxShadow: [
            BoxShadow(
              color: feature.color.withOpacity(0.3),
              blurRadius: 12,
              spreadRadius: 2,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        padding: EdgeInsets.all(tilePadding),
        child: Row(
          children: [
            CircleAvatar(
              radius: 28,
              backgroundColor: feature.color,
              child: Icon(feature.icon, color: Colors.white, size: 28),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    feature.title,
                    style: GoogleFonts.roboto(
                      fontWeight: FontWeight.w600,
                      fontSize: subtitleFont + 4,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    feature.subtitle,
                    style: GoogleFonts.roboto(
                      fontSize: subtitleFont,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
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

class _Feature {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;

  _Feature(this.title, this.subtitle, this.icon, this.color);
}
