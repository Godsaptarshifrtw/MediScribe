import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/page_controllers/register_page_controller.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});

  final registerController = Get.find<RegisterController>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Background with curved image
          ClipPath(
            clipper: BottomCurveClipper(),
            child: Container(
              height: size.height * 0.45,
              width: double.infinity,
              color: Colors.white,
              child: Image.asset(
                'assets/register.jpg', // Use the uploaded image path
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Foreground content
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(top: 250),
              child: Column(
                children: [
                  // Registration Card
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 24),
                    padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 8,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        const Text(
                          "Register",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF6A1B9A),
                          ),
                        ),
                        const SizedBox(height: 24),

                        // Name
                        TextField(
                          decoration: InputDecoration(
                            hintText: "Full Name",
                            prefixIcon: const Icon(Icons.person),
                            filled: true,
                            fillColor: const Color(0xFFF4F4F4),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide.none,
                            ),
                          ),
                          onChanged: (val) => registerController.name.value = val,
                        ),
                        const SizedBox(height: 16),

                        // Email
                        TextField(
                          decoration: InputDecoration(
                            hintText: "Email",
                            prefixIcon: const Icon(Icons.email),
                            filled: true,
                            fillColor: const Color(0xFFF4F4F4),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide.none,
                            ),
                          ),
                          onChanged: (val) => registerController.email.value = val,
                        ),
                        const SizedBox(height: 16),

                        // Age
                        TextField(
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            hintText: "Age",
                            prefixIcon: const Icon(Icons.cake),
                            filled: true,
                            fillColor: const Color(0xFFF4F4F4),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide.none,
                            ),
                          ),
                          onChanged: (val) => registerController.age.value = val,
                        ),
                        const SizedBox(height: 16),

                        // Password
                        TextField(
                          obscureText: true,
                          decoration: InputDecoration(
                            hintText: "Password",
                            prefixIcon: const Icon(Icons.lock),
                            filled: true,
                            fillColor: const Color(0xFFF4F4F4),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide.none,
                            ),
                          ),
                          onChanged: (val) => registerController.password.value = val,
                        ),
                        const SizedBox(height: 24),

                        // Register button
                        Obx(() => SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: registerController.isLoading.value
                                ? null
                                : registerController.register,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF9575CD),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 14),
                            ),
                            child: registerController.isLoading.value
                                ? const CircularProgressIndicator(
                              color: Colors.white,
                            )
                                : const Text(
                              "REGISTER",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        )),
                      ],
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Already registered? Login Now
                  TextButton(
                    onPressed: () {
                      // Navigate to Login page
                    },
                    child: const Text(
                      "Already have an account? Login Now",
                      style: TextStyle(
                        color: Color(0xFF6A1B9A),
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Custom clipper
class BottomCurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height - 60);
    path.quadraticBezierTo(
      size.width / 2,
      size.height,
      size.width,
      size.height - 60,
    );
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
