import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:intl/intl.dart'; // For date formatting

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

  bool isRoundTrip = false;
  DateTime? departureDate;
  DateTime? returnDate;

  Future _selectDepartureDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: departureDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != departureDate) {
      setState(() {
        departureDate = picked;
      });
    }
  }

  Future _selectReturnDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: returnDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
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
                  // Round Trip Option
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
                        style: TextStyle(fontSize: 16, fontFamily: 'Poppins'),
                      ),
                    ],
                  ),
                  // Date Picker Section
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
                  // Return Date (only if Round Trip is selected)
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
                  // Transport Type Selection
                  _buildTransportTypeSelection(),
                  const SizedBox(height: 20),
                  // Search Button
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
            // Popular Destinations
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text('Popular Destinations',
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Poppins')),
            ),
            const SizedBox(height: 10),
            _buildPopularDestinationsCarousel(),
            const SizedBox(height: 20),
          ],
        ),
      ),
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
              fit: BoxFit.cover)),
    );
  }

  static Widget _buildTypingText() {
    return SizedBox(
        width: 250.0,
        child: AnimatedTextKit(
            animatedTexts: [
              TypewriterAnimatedText('Where do you want to go?',
                  textStyle: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Poppins',
                      color: Color.fromARGB(255, 95, 25, 54)),
                  speed: const Duration(milliseconds: 100))
            ],
            totalRepeatCount: 1,
            pause: const Duration(milliseconds: 1000),
            displayFullTextOnTap: true,
            stopPauseOnTap: true));
  }

  Widget _buildSearchBar() {
    return Card(
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
            child: Column(
              children: [
                _buildSearchField(
                    label: 'From',
                    hintText: 'Enter departure city',
                    icon: Icons.location_on),
                const Divider(),
                _buildSearchField(
                    label: 'To',
                    hintText: 'Enter destination city',
                    icon: Icons.location_pin),
              ],
            )));
  }

  Widget _buildSearchField(
      {required String label,
      required String hintText,
      required IconData icon}) {
    return Row(children: [
      Icon(icon, color: Colors.blueAccent),
      const SizedBox(width: 10),
      Expanded(
        child: TextField(
            decoration: InputDecoration(
                labelText: label,
                hintText: hintText,
                border: InputBorder.none,
                labelStyle: const TextStyle(fontFamily: 'Poppins'),
                hintStyle: const TextStyle(fontFamily: 'Poppins'))),
      ),
    ]);
  }

  Widget _buildTransportTypeSelection() {
    return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            _buildTransportOption('Train', 'assets/icons/trains.png'),
            const SizedBox(width: 30),
            _buildTransportOption('Bus', 'assets/icons/buses.png'),
            const SizedBox(width: 30),
            _buildTransportOption('Flight', 'assets/icons/flights.png'),
          ],
        ));
  }

  Widget _buildTransportOption(String label, String iconPath) {
    return Column(children: [
      Image.asset(
        iconPath,
        width: 50,
        height: 50,
      ),
      const SizedBox(height: 8),
      Text(
        label,
        style: const TextStyle(fontSize: 16, fontFamily: 'Poppins'),
      ),
    ]);
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
        ));
  }
}
