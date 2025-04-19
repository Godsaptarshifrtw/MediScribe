import 'dart:io';
import 'package:aignite2025_oops/screens/pdf_preview.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import '../controllers/component_controllers/pdf_controller.dart';

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    final pdfController = Get.find<PdfController>();
    final screenWidth = MediaQuery.of(context).size.width;
    final titleFont = screenWidth > 600 ? 26.0 : 22.0;
    final subtitleFont = screenWidth > 600 ? 16.0 : 13.0;
    final tilePadding = screenWidth > 600 ? 24.0 : 16.0;

    final List<_Feature> features = [
      _Feature("Select report from Gallery", "Scan and get insights",
          Icons.upload_file, const Color(0xFF7E57C2)),
      _Feature("Previous Reports", "Quick access to history", Icons.history,
          const Color(0xFF6A1B9A)),
    ];

    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: tilePadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(titleFont),
              const SizedBox(height: 8),
              ...features.map((f) => Padding(
                padding: const EdgeInsets.only(bottom: 28),
                child: _buildLargeFeatureTile(
                    context, f, subtitleFont, tilePadding, pdfController),
              )),
              const SizedBox(height: 120),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(double fontSize) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "MediScribe",
            style: GoogleFonts.roboto(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          Builder(
            builder: (context) => IconButton(
              icon: const Icon(Icons.menu, color: Color(0xFF9575CD)),
              onPressed: () {
                final RenderBox button = context.findRenderObject() as RenderBox;
                final RenderBox overlay =
                Overlay.of(context).context.findRenderObject() as RenderBox;
                final Offset offset =
                button.localToGlobal(Offset.zero, ancestor: overlay);
                final Size size = button.size;

                showMenu<String>(
                  context: context,
                  position: RelativeRect.fromLTRB(
                    offset.dx,
                    offset.dy + size.height,
                    overlay.size.width - offset.dx - size.width,
                    0,
                  ),
                  items: [
                    PopupMenuItem(value: 'en', child: Text('English')),
                    PopupMenuItem(value: 'hi', child: Text('हिंदी')),
                  ],
                  color: const Color(0xFFF3E5F5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLargeFeatureTile(
      BuildContext context,
      _Feature feature,
      double subtitleFont,
      double tilePadding,
      PdfController pdfController) {
    return GestureDetector(
      onTap: () async {
        if (feature.title == "Select report from Gallery") {
          FilePickerResult? result = await FilePicker.platform.pickFiles(
            type: FileType.custom,
            allowedExtensions: ['pdf'],
          );

          if (result != null && result.files.single.path != null) {
            File file = File(result.files.single.path!);
            pdfController.pickPdf(file);
            Get.to(() => const PdfPreviewScreen());

            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('PDF selected successfully')),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('No PDF selected')),
            );
          }
        } else {
          // TODO: Navigate to Previous Reports screen
        }
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

class _Feature {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;

  _Feature(this.title, this.subtitle, this.icon, this.color);
}
