import 'package:flutter/material.dart';
import 'dart:io';
import 'package:desktop_window/desktop_window.dart';
import 'main_shell.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Giới hạn kích thước tối thiểu cho Desktop (Giữ nguyên như file cũ)
  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    await DesktopWindow.setMinWindowSize(const Size(1280, 720));
  }

  runApp(const OhidoPOSApp());
}

class OhidoPOSApp extends StatelessWidget {
  const OhidoPOSApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'OHIDO POS',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        // Đặt màu nền sáng phẳng đồng bộ
        scaffoldBackgroundColor: const Color(0xFFF8FAFC),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF6366F1),
          primary: const Color(0xFF6366F1),
          surface: Colors.white,
        ),
      ),
      home: const MainShell(),
    );
  }
}
