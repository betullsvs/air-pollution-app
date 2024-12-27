import 'package:flutter/material.dart';
import 'package:flutter_app/screens/admin_login_screen.dart';
import 'package:flutter_app/screens/user_login_screen.dart';
import 'package:flutter_app/widgets/entry_button.dart';

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
          const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 350),
                Text(
                  'AIR POLLUTION APP',
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 48, 48, 48),
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 50),

                //UserButton
                EntryButton(
                    buttonText: "Kullanıcı",
                    pageRoute: UserLoginScreen(),
                    backgroundColor: Color.fromARGB(255, 179, 255, 181)),
                SizedBox(height: 30),

                //AdminButton
                EntryButton(
                    buttonText: "Admin",
                    pageRoute: AdminLoginScreen(),
                    backgroundColor: Color.fromARGB(255, 135, 201, 255)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
