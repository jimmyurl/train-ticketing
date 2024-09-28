import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> popularDestinationsImages = [
    'https://www.railwaypro.com/wp/tanzania-inaugurates-morogoro-dodoma-sgr/',
    'https://www.worldnomads.com/travel-safety/africa/tanzania/travel-in-and-around-tanzania',
    'https://aviationweek.com/air-transport/airports-networks/gallery-dar-es-salaam-julius-nyerere-international-airport-terminal',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 30),

            // Header Image
            _buildHeaderImage(),

            // Typing Effect Slogan
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: Center(
                child: _buildTypingText(),
              ),
            ),

            // Search Section
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  _buildSearchBar(),
                  const SizedBox(height: 10),
                  _buildTransportTypeSelection(),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Popular Destinations
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Popular Destinations',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Poppins',
                ),
              ),
            ),
            const SizedBox(height: 10),
            _buildPopularDestinationsCarousel(),

            const SizedBox(height: 20),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildHeaderImage() {
    return Container(
      height: 200,
      width: double.infinity,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(
              'https://www.micato.com/wp-content/uploads/2018/09/mt-kilimanjaro-1110x700.jpg'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  static Widget _buildTypingText() {
    return SizedBox(
      width: 250.0,
      child: AnimatedTextKit(
        animatedTexts: [
          TypewriterAnimatedText(
            'Where do you want to go?',
            textStyle: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              fontFamily: 'Poppins',
              color: Color.fromARGB(255, 95, 25, 54),
            ),
            speed: const Duration(milliseconds: 100),
          ),
        ],
        totalRepeatCount: 1, // Make the typing effect play once
        pause: const Duration(milliseconds: 1000),
        displayFullTextOnTap: true, // Optional: skip animation if tapped
        stopPauseOnTap: true,
      ),
    );
  }

  Widget _buildSearchBar() {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
        child: Column(
          children: [
            _buildSearchField(
              label: 'From',
              hintText: 'Enter departure city',
              icon: Icons.location_on,
            ),
            const Divider(),
            _buildSearchField(
              label: 'To',
              hintText: 'Enter destination city',
              icon: Icons.location_pin,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchField(
      {required String label,
      required String hintText,
      required IconData icon}) {
    return Row(
      children: [
        Icon(icon, color: Colors.blueAccent),
        const SizedBox(width: 10),
        Expanded(
          child: TextField(
            decoration: InputDecoration(
              labelText: label,
              hintText: hintText,
              border: InputBorder.none,
              labelStyle: const TextStyle(
                fontFamily: 'Poppins',
              ),
              hintStyle: const TextStyle(
                fontFamily: 'Poppins',
              ),
            ),
          ),
        ),
      ],
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
          height: 40,
          width: 40,
        ),
        const SizedBox(height: 5),
        Text(
          label,
          style: const TextStyle(fontSize: 16, fontFamily: 'Poppins'),
        ),
      ],
    );
  }

  Widget _buildPopularDestinationsCarousel() {
    return CarouselSlider(
      options: CarouselOptions(
        autoPlay: true,
        enlargeCenterPage: true,
        height: 200,
      ),
      items: popularDestinationsImages.map((imageUrl) {
        return Container(
          margin: const EdgeInsets.all(5.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(
              image: NetworkImage(imageUrl),
              fit: BoxFit.cover,
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildBottomNavigationBar() {
    return BottomNavigationBar(
      currentIndex: 0,
      items: [
        BottomNavigationBarItem(
          icon: ImageIcon(
            AssetImage('assets/icons/home.png'),
            color: Colors.blueAccent,
          ),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: ImageIcon(
            AssetImage('assets/icons/search.png'),
            color: Colors.blueAccent,
          ),
          label: 'Search',
        ),
        BottomNavigationBarItem(
          icon: ImageIcon(
            AssetImage('assets/icons/profile.png'),
            color: Colors.blueAccent,
          ),
          label: 'Profile',
        ),
      ],
    );
  }
}
