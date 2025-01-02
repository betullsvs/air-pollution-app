import 'package:flutter/material.dart';
import '../widgets/entry_button.dart';
import '../widgets/text_field.dart';
import 'user_home_screen.dart';

class UserLoginScreen extends StatelessWidget {
  const UserLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController usernameController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Kullanıcı Girişi'),
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
              width: 500,
              height: 360,
              padding: const EdgeInsets.all(20),
              margin: const EdgeInsets.symmetric(horizontal: 30),
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

                  // User Name
                  LoginTextField(
                    controller: usernameController,
                    labelText: "Kullanıcı Adı",
                    prefixIcon: const Icon(Icons.person),
                  ),

                  // User Password
                  LoginTextField(
                    controller: passwordController,
                    labelText: "Şifre",
                    prefixIcon: const Icon(Icons.lock),
                  ),

                  const EntryButton(
                      buttonText: "GİRİŞ YAP",
                      pageRoute: UserHomeScreen(),
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
