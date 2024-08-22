import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SplashscreenPage extends StatefulWidget {
  const SplashscreenPage({super.key});

  @override
  State<SplashscreenPage> createState() => _SplashscreenPageState();
}

class _SplashscreenPageState extends State<SplashscreenPage> {
  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    // Simulasi pemuatan data
    await Future.delayed(const Duration(seconds: 3));

    // Setelah data selesai dimuat, navigasi ke halaman utama
    // ignore: use_build_context_synchronously
    context.go('/profile-page');
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.blueAccent),
          backgroundColor: Colors.grey,
          strokeWidth: 5.0,
        ),
      ),
    );
  }
}
