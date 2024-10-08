import 'package:Tikiti/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController fromController = TextEditingController();
  TextEditingController toController = TextEditingController();
  bool isRoundTrip = false;
  DateTime? departureDate;
  DateTime? returnDate;
  String selectedTransport = ''; // Track selected transport type

  // Method to select departure date
  Future<void> _selectDepartureDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: departureDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null && pickedDate != departureDate) {
      setState(() {
        departureDate = pickedDate;
      });
    }
  }

  // Method to select return date
  Future<void> _selectReturnDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: returnDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null && pickedDate != returnDate) {
      setState(() {
        returnDate = pickedDate;
      });
    }
  }

  // Language switcher for changing locale
  Widget _buildLanguageSwitcher() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextButton(
          onPressed: () {
            setState(() {
              // Switch to English
              S.load(const Locale('en'));
            });
          },
          child: const Text('English'),
        ),
        TextButton(
          onPressed: () {
            setState(() {
              // Switch to Swahili
              S.load(const Locale('sw'));
            });
          },
          child: const Text('Swahili'),
        ),
      ],
    );
  }

  // Method to build transport type selection inside the form
  Widget _buildTransportTypeSelection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              selectedTransport = 'Bus'; // Set the selected transport
            });
          },
          child: Column(
            children: [
              Image.asset(
                'assets/icons/buses.png',
                height: selectedTransport == 'Bus' ? 60 : 40, // Change size if selected
                color: selectedTransport == 'Bus' ? Colors.red : null, // Change color if selected
              ),
              const Text('Bus'),
            ],
          ),
        ),
        GestureDetector(
          onTap: () {
            setState(() {
              selectedTransport = 'Train'; // Set the selected transport
            });
          },
          child: Column(
            children: [
              Image.asset(
                'assets/icons/trains.png',
                height: selectedTransport == 'Train' ? 60 : 40, // Change size if selected
                color: selectedTransport == 'Train' ? Colors.red : null, // Change color if selected
              ),
              const Text('Train'),
            ],
          ),
        ),
        GestureDetector(
          onTap: () {
            setState(() {
              selectedTransport = 'Flight'; // Set the selected transport
            });
          },
          child: Column(
            children: [
              Image.asset(
                'assets/icons/flights.png',
                height: selectedTransport == 'Flight' ? 60 : 40, // Change size if selected
                color: selectedTransport == 'Flight' ? Colors.red : null, // Change color if selected
              ),
              const Text('Flight'),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final localizations = S.of(context); // Access localization

    return Scaffold(
      backgroundColor: Colors.teal,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 20),
            _buildLanguageSwitcher(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Image.asset(
                'assets/icons/ticket-logo.png',
                height: 70,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Center(
                child: Text(
                  localizations.planYourJourney,
                  style: const TextStyle(
                      fontSize: 24, color: Colors.white, fontFamily: 'Poppins'),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      TextField(
                        controller: fromController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: localizations.fromHint,
                          hintStyle: const TextStyle(fontFamily: 'Poppins'),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide.none),
                          prefixIcon:
                              const Icon(Icons.location_on, color: Colors.teal),
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        controller: toController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: localizations.toHint,
                          hintStyle: const TextStyle(fontFamily: 'Poppins'),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide.none),
                          prefixIcon:
                              const Icon(Icons.location_on, color: Colors.teal),
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        readOnly: true,
                        onTap: () => _selectDepartureDate(context),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: departureDate == null
                              ? localizations.selectDepartureDate
                              : DateFormat.yMd().format(departureDate!),
                          hintStyle: const TextStyle(fontFamily: 'Poppins'),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide.none),
                          prefixIcon:
                              const Icon(Icons.calendar_today, color: Colors.teal),
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
                                isRoundTrip = value!;
                              });
                            },
                          ),
                          const Text(
                            'Return Trip',
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                      if (isRoundTrip)
                        TextField(
                          readOnly: true,
                          onTap: () => _selectReturnDate(context),
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            hintText: returnDate == null
                                ? localizations.selectReturnDate
                                : DateFormat.yMd().format(returnDate!),
                            hintStyle: const TextStyle(fontFamily: 'Poppins'),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none),
                            prefixIcon:
                                const Icon(Icons.calendar_today, color: Colors.teal),
                          ),
                        ),
                      const SizedBox(height: 10),
                      _buildTransportTypeSelection(), // Transport type icons inside the form
                      const SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () {
                          // Handle search
                        },
                        child: Text(localizations.search),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
