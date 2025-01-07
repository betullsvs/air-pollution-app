import 'package:flutter/material.dart';
import 'screens/welcome_screen.dart';
import 'notification/notification_service.dart';  // Bildirim servisi için gerekli

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Bildirim servisini başlat
  await NotificationService.initialize();  

  // Bildirim izinlerini kontrol et ve al
  await NotificationService.requestNotificationPermissions();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WelcomeScreen(),  // Ana giriş ekranı olarak WelcomeScreen kullanılıyor
    );
  }
}
