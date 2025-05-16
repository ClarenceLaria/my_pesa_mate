import 'package:flutter/material.dart';
import 'package:kurerefinancialplanner_app/components/entry_point.dart';

class PinCard extends StatefulWidget {
  const PinCard({super.key});

  @override
  State<PinCard> createState() => _PinCardState();
}

class _PinCardState extends State<PinCard> {
  final List<String> _pin = [];
  bool _showKeypad = false;

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

  void _onPinEntered(String pin) {
    debugPrint('Entered PIN: $pin');
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const EntryPoint()),
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
