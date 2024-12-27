import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/wallpaper.png',
              fit: BoxFit.cover,
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 350),
                const Text(
                  'AIR POLLUTION APP',
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 48, 48, 48),
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 50),
                //UserButton
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 179, 255, 181),
                    fixedSize: const Size(350, 60),
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 60,
                    ),
                  ),
                  child: const Text(
                    'Kullanıcı',
                    style: TextStyle(
                      fontSize: 22,
                      color: Color.fromARGB(255, 48, 48, 48),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                //AdminButton
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 135, 201, 255),
                    fixedSize: const Size(350, 60),
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 60,
                    ),
                  ),
                  child: const Text(
                    'Admin',
                    style: TextStyle(
                      fontSize: 22,
                      color: Color.fromARGB(255, 48, 48, 48),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
