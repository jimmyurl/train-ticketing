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
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildLanguageOption('EN', const Locale('en')),
            const SizedBox(width: 8),
            _buildLanguageOption('SW', const Locale('sw')),
          ],
        ),
      ),
    );
  }

  Widget _buildLanguageOption(String label, Locale locale) {
    bool isSelected = _locale.languageCode == locale.languageCode; // Compare with current locale
    return GestureDetector(
      onTap: () {
        setState(() {
          _locale = locale;
          S.load(locale); // Load the selected locale
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? Colors.teal : Colors.transparent,
          borderRadius: BorderRadius.circular(25),
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 40),
            Align(
              alignment: Alignment.center,
              child: _buildLanguageSwitcher(),
            ),
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
                            hintStyle: const TextStyle(fontFamily: 'Poppins'),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none),
                            prefixIcon:
                                const Icon(Icons.calendar_today, color: Colors.teal),
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
      ),
    );
  }
}
