import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController fromController = TextEditingController();
  final TextEditingController toController = TextEditingController();
  DateTime? departureDate;

  List<String> popularDestinationsImages = [];
  List<String> locations = [];

  @override
  void initState() {
    super.initState();
    fetchPopularDestinations();
    fetchLocations();
  }

  Future<void> fetchPopularDestinations() async {
    final response = await Supabase.instance.client
        .from('popular_destinations')
        .select('image_url') // assuming 'image_url' is a column
        .order('id')
        .limit(10)
        .then((value) {
      // Use the data directly from the value
      popularDestinationsImages =
          List<String>.from(value.map((item) => item['image_url']));
    }).catchError((error) {
      // Handle the error appropriately
      print('Error fetching popular destinations: $error');
    });

    setState(() {});
  }

  Future<void> fetchLocations() async {
    final response = await Supabase.instance.client
        .from('locations')
        .select('name') // assuming 'name' is a column
        .order('id')
        .then((value) {
      // Use the data directly from the value
      locations = List<String>.from(value.map((item) => item['name']));
    }).catchError((error) {
      // Handle the error appropriately
      print('Error fetching locations: $error');
    });

    setState(() {});
  }

  void _handleSearch() {
    if (fromController.text.isEmpty ||
        toController.text.isEmpty ||
        departureDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill in all fields')),
      );
      return;
    }
    // Proceed with search logic
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Search form
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  TextField(
                    controller: fromController,
                    decoration: InputDecoration(labelText: 'From'),
                  ),
                  TextField(
                    controller: toController,
                    decoration: InputDecoration(labelText: 'To'),
                  ),
                  // Add a Date Picker for departureDate
                  TextButton(
                    onPressed: () async {
                      final date = await showDatePicker(
                        context: context,
                        initialDate: departureDate ?? DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2101),
                      );
                      if (date != null && date != departureDate) {
                        setState(() {
                          departureDate = date;
                        });
                      }
                    },
                    child: Text(
                      departureDate == null
                          ? 'Select Departure Date'
                          : 'Departure: ${departureDate!.toLocal()}'
                              .split(' ')[0],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: _handleSearch,
                    child: const Text('Search'),
                  ),
                ],
              ),
            ),
            // Popular Destinations Carousel
            _buildPopularDestinationsCarousel(),
          ],
        ),
      ),
    );
  }

  Widget _buildPopularDestinationsCarousel() {
    return CarouselSlider(
      options: CarouselOptions(
        height: 200,
        enlargeCenterPage: true,
        autoPlay: true,
      ),
      items: popularDestinationsImages.map((imageUrl) {
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
      }).toList(),
    );
  }
}
