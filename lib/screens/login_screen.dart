import 'package:flutter/material.dart';
import 'package:kurerefinancialplanner_app/components/biometrics_modal.dart';
import 'package:kurerefinancialplanner_app/components/entry_point.dart';
import 'package:kurerefinancialplanner_app/components/pin_card.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 24),
          child: IntrinsicHeight(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Welcome to My Pesa Mate',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                const Text(
                  'Finances & Budgeting',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  "Log in securely to manage your \nfamily's finances",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                // Pin Card
                const SizedBox(height: 32),
                const PinCard(),

                //Biometrics
                const SizedBox(height: 32),
                const BiometricsModal(),

                const SizedBox(height: 40),
                const Spacer(),
                
                // navigation buttons
                const SizedBox(height: 40),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      // Navigation logic or auth logic
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const EntryPoint(),
                        ),
                      );
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
                ),
              ],
            ),
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