import 'package:flutter/material.dart';
import 'package:flutter_app/widgets/entry_button.dart';
import 'package:flutter_app/widgets/text_field.dart';

import 'admin_home_screen.dart';

class AdminLoginScreen extends StatelessWidget {
  const AdminLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController adminController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Girişi'),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 77, 110, 140),
        iconTheme: const IconThemeData(
          color: Color.fromARGB(255, 239, 239, 239),
          size: 30,
        ),
        titleTextStyle: const TextStyle(
          fontSize: 23,
          fontWeight: FontWeight.bold,
          color: Color.fromARGB(255, 239, 239, 239),
        ),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/wallpaper1.jpg',
              fit: BoxFit.cover,
            ),
          ),
          Center(
            child: Container(
              padding: const EdgeInsets.all(20),
              margin: const EdgeInsets.symmetric(horizontal: 30),
              width: 500,
              height: 360,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 239, 239, 239),
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 10,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const CircleAvatar(
                    radius: 40,
                    backgroundColor: Color.fromARGB(255, 48, 48, 48),
                    child: Icon(
                      Icons.person,
                      size: 50,
                      color: Color.fromARGB(255, 179, 255, 181),
                    ),
                  ),

                  // Admin Name
                  LoginTextField(
                    controller: adminController,
                    labelText: "Admin Adı",
                    prefixIcon: const Icon(Icons.person),
                  ),

                  // Admin Password
                  LoginTextField(
                      controller: passwordController,
                      labelText: "Şifre",
                      prefixIcon: const Icon(Icons.lock)),

                  const EntryButton(
                      buttonText: "GİRİŞ YAP",
                      pageRoute: AdminHomeScreen(),
                      backgroundColor: Color.fromARGB(255, 179, 255, 181))
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
