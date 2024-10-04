import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isRoundTrip = false;
  DateTime? departureDate;
  DateTime? returnDate;
  String? selectedTransport;

  final TextEditingController fromController = TextEditingController();
  final TextEditingController toController = TextEditingController();

  final List<String> popularDestinationsImages = [
    'https://www.skyscrapercity.com/threads/dodoma-dodoma-city-hotel-10-fls.2201464/',
    'https://www.ghrshotels.com/en/hotel/flomi-hotel.ih1812727',
    'https://www.facebook.com/photo.php?fbid=5839764002704636&id=157303284284098&set=a.159892260691867',
  ];

  // Method to build transport type selection
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

  // Method to build each transport option with animation
  Widget _buildTransportOption(String label, String iconPath) {
    bool isSelected = selectedTransport == label;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedTransport = label;
        });
      },
      child: Column(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            height: isSelected ? 60 : 50,
            width: isSelected ? 60 : 50,
            child: Image.asset(
              iconPath,
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            label,
            style: TextStyle(
              fontFamily: 'Poppins',
              color: isSelected ? Colors.teal : Colors.black,
              fontSize: 16,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  // Method to build a carousel for popular destinations
  Widget _buildPopularDestinationsCarousel() {
    return CarouselSlider(
      options: CarouselOptions(
        height: 200,
        enlargeCenterPage: true,
        autoPlay: true,
      ),
      items: popularDestinationsImages.map((imageUrl) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 5.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: NetworkImage(imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
            );
          },
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Screen'),
      ),
      body: Column(
        children: [
          SizedBox(height: 20),
          _buildTransportTypeSelection(),
          SizedBox(height: 20),
          _buildPopularDestinationsCarousel(),
        ],
      ),
    );
  }
}
