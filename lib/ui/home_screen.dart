import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isRoundTrip = false;
  DateTime? departureDate;
  DateTime? returnDate;

  final TextEditingController fromController = TextEditingController();
  final TextEditingController toController = TextEditingController();

  // Track the selected transport type
  String selectedTransport = 'Train';

  Future<void> _selectDepartureDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    if (picked != null && picked != departureDate) {
      setState(() {
        departureDate = picked;
      });
    }
  }

  Future<void> _selectReturnDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: departureDate ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    if (picked != null && picked != returnDate) {
      setState(() {
        returnDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Image.asset(
                'assets/icons/ticket-logo.png',
                height: 70,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Center(child: _buildTypingText()),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      // 'From' Field
                      TextField(
                        controller: fromController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'From (Departure)',
                          hintStyle: const TextStyle(fontFamily: 'Poppins'),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                          prefixIcon:
                              const Icon(Icons.location_on, color: Colors.teal),
                        ),
                      ),
                      const SizedBox(height: 10),
                      // 'To' Field
                      TextField(
                        controller: toController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'To (Destination)',
                          hintStyle: const TextStyle(fontFamily: 'Poppins'),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                          prefixIcon:
                              const Icon(Icons.location_on, color: Colors.teal),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Checkbox(
                            value: isRoundTrip,
                            onChanged: (bool? value) {
                              setState(() {
                                isRoundTrip = value ?? false;
                              });
                            },
                          ),
                          const Text(
                            'Round Trip',
                            style: TextStyle(
                                fontSize: 16,
                                fontFamily: 'Poppins',
                                color: Colors.white),
                          ),
                        ],
                      ),
                      GestureDetector(
                        onTap: () => _selectDepartureDate(context),
                        child: Card(
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 12.0, horizontal: 12.0),
                            child: Row(
                              children: [
                                const Icon(Icons.calendar_today,
                                    color: Colors.blueAccent),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Text(
                                    departureDate != null
                                        ? "Departure: ${DateFormat.yMMMd().format(departureDate!)}"
                                        : "Select departure date",
                                    style:
                                        const TextStyle(fontFamily: 'Poppins'),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      if (isRoundTrip) ...[
                        const SizedBox(height: 10),
                        GestureDetector(
                          onTap: () => _selectReturnDate(context),
                          child: Card(
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 12.0, horizontal: 12.0),
                              child: Row(
                                children: [
                                  const Icon(Icons.calendar_today,
                                      color: Colors.blueAccent),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Text(
                                      returnDate != null
                                          ? "Return: ${DateFormat.yMMMd().format(returnDate!)}"
                                          : "Select return date",
                                      style: const TextStyle(
                                          fontFamily: 'Poppins'),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                      const SizedBox(height: 10),
                      _buildTransportTypeSelection(),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          // Handle Search Action
                        },
                        child: const Text('Search',
                            style:
                                TextStyle(fontSize: 18, fontFamily: 'Poppins')),
                        style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                                vertical: 12.0, horizontal: 24.0),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8))),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildTypingText() {
    return AnimatedTextKit(
      animatedTexts: [
        TypewriterAnimatedText(
          'Plan your journey effortlessly...',
          textStyle: const TextStyle(
            fontFamily: 'Poppins',
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          speed: const Duration(milliseconds: 100),
        ),
      ],
      isRepeatingAnimation: false,
    );
  }

  Widget _buildTransportTypeSelection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildTransportOption('Train', 'assets/icons/trains.png'),
        _buildTransportOption('Bus', 'assets/icons/buses.png'),
        _buildTransportOption('Flight', 'assets/icons/flights.png'),
      ],
    );
  }

  Widget _buildTransportOption(String label, String iconPath) {
    final bool isSelected = label == selectedTransport;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedTransport = label; // Update selected transport option
        });
      },
      child: Column(
        children: [
          Image.asset(
            iconPath,
            height: isSelected ? 70 : 50, // Enlarge the selected icon
            width: isSelected ? 70 : 50, // Enlarge the selected icon
          ),
          const SizedBox(height: 5),
          Text(
            label,
            style: TextStyle(
              fontFamily: 'Poppins',
              color: isSelected
                  ? Colors.teal
                  : Colors.black, // Highlight the selected option
              fontSize: isSelected ? 18 : 16,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
