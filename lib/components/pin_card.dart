import 'package:flutter/material.dart';
import 'package:kurerefinancialplanner_app/auth/pin_storage.dart';
import 'package:kurerefinancialplanner_app/components/entry_point.dart';

class PinCard extends StatefulWidget {
  const PinCard({super.key});

  @override
  State<PinCard> createState() => _PinCardState();
}

class _PinCardState extends State<PinCard> {
  final List<String> _pin = [];
  bool _showKeypad = false;
  final PinService _pinService = PinService();
  bool _isVerifying = true;

  @override
  void initState() {
    super.initState();
    _checkIfPinExists();
  }

  Future<void> _checkIfPinExists() async {
    final exists = await _pinService.isPinSet();
    setState(() {
      _isVerifying = exists;
    });
  }

  void _addDigit(String digit) {
    if (_pin.length < 4) {
      setState(() => _pin.add(digit));

      if (_pin.length == 4) {
        _onPinEntered(_pin.join());
      }
    }
  }

  void _removeDigit() {
    if (_pin.isNotEmpty) {
      setState(() => _pin.removeLast());
    }
  }

  Future<void> _onPinEntered(String pin) async {
    if (_isVerifying) {
      // Validate
      final isValid = await _pinService.validatePin(pin);
      if (isValid) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const EntryPoint()),
        );
      } else {
        _showError('Incorrect PIN');
        setState(() => _pin.clear());
      }
    } else {
      // Save new PIN
      await _pinService.savePin(pin);
      _showSuccess('PIN saved');
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const EntryPoint()),
      );
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.red, behavior: SnackBarBehavior.floating,),
    );
  }

  void _showSuccess(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.green, behavior: SnackBarBehavior.floating,),
    );
  }

  Widget _buildDot(int index) {
    final isFilled = index < _pin.length;
    return Container(
      width: 20,
      height: 20,
      margin: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: isFilled ? Colors.green : Colors.greenAccent,
        shape: BoxShape.circle,
      ),
    );
  }

  Widget _buildNumberPad() {
    const keys = [
      ['1', '2', '3'],
      ['4', '5', '6'],
      ['7', '8', '9'],
      ['<', '0', '✓'],
    ];

    return Column(
      children: keys.map((row) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: row.map((key) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  if (key == '<') {
                    _removeDigit();
                  } else if (key == '✓') {
                    if (_pin.length == 4) {
                      _onPinEntered(_pin.join());
                    }
                  } else {
                    _addDigit(key);
                  }
                },
                style: ElevatedButton.styleFrom(
                  shape: const CircleBorder(),
                  padding: const EdgeInsets.all(20),
                  backgroundColor: Colors.greenAccent,
                ),
                child: Text(
                  key,
                  style: const TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
            );
          }).toList(),
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          _isVerifying ? 'Enter PIN' : 'Set a New PIN: $_pin',
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        GestureDetector(
          onTap: () {
            setState(() {
              _showKeypad = !_showKeypad;
            });
          },
          child: Container(
            width: 100,
            height: 125,
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
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              children: List.generate(4, _buildDot),
            ),
          ),
        ),
        const SizedBox(height: 32),
        if (_showKeypad) _buildNumberPad(),
      ],
    );
  }
}
