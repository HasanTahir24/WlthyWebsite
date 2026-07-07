import 'package:flutter/material.dart';

import 'pages/landing_page.dart';
import 'theme/app_theme.dart';

void main() {
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
