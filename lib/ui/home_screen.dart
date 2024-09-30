import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isRoundTrip = false;
  DateTime? departureDate;
  DateTime? returnDate;

  final List<String> popularDestinationsImages = [
    'https://example.com/image1.jpg',
    'https://example.com/image2.jpg',
    'https://example.com/image3.jpg',
  ];

  Future<void> _selectDepartureDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    if (picked != null && picked != departureDate)
      setState(() {
        departureDate = picked;
      });
  }

  Future<void> _selectReturnDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: departureDate ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    if (picked != null && picked != returnDate)
      setState(() {
        returnDate = picked;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal, // Set teal background color here
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 20),
            // Logo Section
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Image.asset(
                'assets/icons/ticket-logo.png',
                height: 100,
              ),
            ),
            // Typing Effect Slogan
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Center(child: _buildTypingText()),
            ),
            // Search Section
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  _buildSearchBar(),
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
                                style: const TextStyle(fontFamily: 'Poppins'),
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
                                  style: const TextStyle(fontFamily: 'Poppins'),
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
                        style: TextStyle(fontSize: 18, fontFamily: 'Poppins')),
                    style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            vertical: 12.0, horizontal: 24.0),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8))),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text('Popular Destinations',
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Poppins',
                      color: Colors.white)),
            ),
            const SizedBox(height: 10),
            _buildPopularDestinationsCarousel(),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildTypingText() {
    // Typing effect or animation can be added here.
    return const Text(
      'Plan your journey effortlessly...',
      style: TextStyle(
        fontFamily: 'Poppins',
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    );
  }

  Widget _buildSearchBar() {
    return TextField(
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        hintText: 'Where do you want to go?',
        hintStyle: const TextStyle(fontFamily: 'Poppins'),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        prefixIcon: const Icon(Icons.search, color: Colors.teal),
      ),
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
    return Column(
      children: [
        Image.asset(
          iconPath,
          width: 50,
          height: 50,
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(
              fontSize: 16, fontFamily: 'Poppins', color: Colors.white),
        ),
      ],
    );
  }

  Widget _buildPopularDestinationsCarousel() {
    return CarouselSlider.builder(
      itemCount: popularDestinationsImages.length,
      itemBuilder: (context, index, realIndex) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 8.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(
              image: NetworkImage(popularDestinationsImages[index]),
              fit: BoxFit.cover,
            ),
          ),
        );
      },
      options: CarouselOptions(
        height: 180,
        enlargeCenterPage: true,
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 3),
      ),
    );
  }
}
