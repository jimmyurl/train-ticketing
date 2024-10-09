import 'package:Tikiti/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

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
  String selectedTransport = '';

  Locale _locale = const Locale('en'); // Track current locale

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

  Widget _buildLanguageSwitcher() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20), // Minimized size
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4), // Smaller padding
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildLanguageOption('EN', const Locale('en')),
            const SizedBox(width: 4), // Reduced spacing
            _buildLanguageOption('SW', const Locale('sw')),
          ],
        ),
      ),
    );
  }

  Widget _buildLanguageOption(String label, Locale locale) {
    bool isSelected = _locale.languageCode == locale.languageCode;
    return GestureDetector(
      onTap: () {
        setState(() {
          _locale = locale;
          S.load(locale);
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4), // Smaller size
        decoration: BoxDecoration(
          color: isSelected ? Colors.teal : Colors.transparent,
          borderRadius: BorderRadius.circular(15), // Smaller corners
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.teal,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  Widget _buildTransportTypeSelection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              selectedTransport = 'Bus';
            });
          },
          child: Column(
            children: [
              Image.asset(
                'assets/icons/buses.png',
                height: selectedTransport == 'Bus' ? 60 : 40,
                color: selectedTransport == 'Bus' ? Colors.red : null,
              ),
              const Text('Bus'),
            ],
          ),
        ),
        GestureDetector(
          onTap: () {
            setState(() {
              selectedTransport = 'Train';
            });
          },
          child: Column(
            children: [
              Image.asset(
                'assets/icons/trains.png',
                height: selectedTransport == 'Train' ? 60 : 40,
                color: selectedTransport == 'Train' ? Colors.red : null,
              ),
              const Text('Train'),
            ],
          ),
        ),
        GestureDetector(
          onTap: () {
            setState(() {
              selectedTransport = 'Flight';
            });
          },
          child: Column(
            children: [
              Image.asset(
                'assets/icons/flights.png',
                height: selectedTransport == 'Flight' ? 60 : 40,
                color: selectedTransport == 'Flight' ? Colors.red : null,
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
    final localizations = S.of(context);

    return Scaffold(
      backgroundColor: Colors.teal,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              children: [
                const SizedBox(height: 40),
                // Centered logo
                Center(
                  child: Image.asset(
                    'assets/icons/ticket-logo.png',
                    height: 70,
                  ),
                ),
                const SizedBox(height: 20), // Space between logo and content
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Center(
                    child: Text(
                      localizations.planYourJourney,
                      style: const TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ),
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
                          TextField(
                            controller: fromController,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              hintText: localizations.fromHint,
                              hintStyle: const TextStyle(fontFamily: 'Poppins'),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none,
                              ),
                              prefixIcon: const Icon(
                                Icons.location_on,
                                color: Colors.teal,
                              ),
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
                              prefixIcon: const Icon(
                                Icons.location_on,
                                color: Colors.teal,
                              ),
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
                              prefixIcon: const Icon(
                                Icons.calendar_today,
                                color: Colors.teal,
                              ),
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
                              Text(
                                localizations.returnTrip,
                                style: const TextStyle(fontSize: 16),
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
                                hintStyle: const TextStyle(
                                    fontFamily: 'Poppins'),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide.none),
                                prefixIcon: const Icon(
                                  Icons.calendar_today,
                                  color: Colors.teal,
                                ),
                              ),
                            ),
                          const SizedBox(height: 10),
                          _buildTransportTypeSelection(),
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
            Positioned(
              top: 110, // Below the logo
              right: 20, // To the right-hand corner
              child: _buildLanguageSwitcher(),
            ),
          ],
        ),
      ),
    );
  }
}
