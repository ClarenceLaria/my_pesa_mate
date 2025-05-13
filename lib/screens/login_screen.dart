import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Text(
                'Welcome the Kureres ❤',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Finances & Budgeting',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                "Log in securely to manage your \nfamily's finances",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 32),
              Container(
                width: 100,
                height: 250,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 15,
                      offset: const Offset(0, 5),
                      color: Colors.black.withOpacity(0.05),
                    )
                  ],
                ),
                child: GridView.count(
                  crossAxisCount: 2,
                  children: List.generate(4, (_) => _buildDot()),
                ),
              ),
              const SizedBox(height: 28),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Icon(Icons.fingerprint, size: 40),
                      SizedBox(height: 5),
                      Text('Fingerprint Scanner', style: TextStyle(fontSize: 14)),
                    ],
                  ),
                  Column(
                    children: [
                      Icon(Icons.face, size: 40),
                      SizedBox(height: 5),
                      Text('Face Scan', style: TextStyle(fontSize: 14)),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 40),
              const Spacer(),
              const Text(
                'Continue.',
                style: TextStyle(fontSize: 16, color: Colors.black87),
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  // Navigation logic or auth logic
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.greenAccent,
                  padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  elevation: 4,
                ),
                child: const Text(
                  'Continue',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ],
          ),
        )
      ),
    );
  }

  Widget _buildDot() {
  return Container(
    width: 20,
    height: 20,
    margin: const EdgeInsets.all(4),
    decoration: const BoxDecoration(
      color: Colors.greenAccent,
      shape: BoxShape.circle,
    ),
  );
}

}