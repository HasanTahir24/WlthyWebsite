import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';
import 'pages/landing_page.dart';
import 'theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const WlthyApp());
}

class WlthyApp extends StatelessWidget {
  const WlthyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'wlthy — clarity-first wealth tracking',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      home: const LandingPage(),
    );
  }
}
