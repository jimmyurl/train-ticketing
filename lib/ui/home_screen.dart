import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:gap/gap.dart';
import 'package:sgr_ticketing/widgets/tickets.dart'; // Adjust according to your project structure
import 'package:sgr_ticketing/widgets/hotels_sceen.dart'; // Adjust according to your project structure

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String userName =
      "Jimmy"; // Example variable to simulate fetching the user name
  List<dynamic>? ticketList; // Adjust type as needed
  List<dynamic>? hotelList; // Adjust type as needed

  @override
  void initState() {
    super.initState();
    fetchTickets();
    fetchHotels();
  }

  Future<void> fetchTickets() async {
    final client = Supabase.instance.client;

    try {
      // Fetch tickets from 'tickets' table
      final List<dynamic> tickets = await client
          .from('tickets') // Replace 'tickets' with your actual table name
          .select()
          .order('date', ascending: true) // Example ordering
          .limit(10); // Adjust as needed

      // Update state with fetched ticket data
      setState(() {
        ticketList = tickets;
      });
    } catch (error) {
      print('Error fetching tickets: $error');
      // Handle error appropriately, e.g., show a snack bar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error fetching tickets: $error')),
      );
    }
  }

  Future<void> fetchHotels() async {
    final client = Supabase.instance.client;

    try {
      // Fetch hotels from 'hotels' table
      final List<dynamic> hotels = await client
          .from('hotels') // Replace 'hotels' with your actual table name
          .select()
          .limit(10); // Adjust as needed

      // Update state with fetched hotel data
      setState(() {
        hotelList = hotels;
      });
    } catch (error) {
      print('Error fetching hotels: $error');
      // Handle error appropriately, e.g., show a snack bar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error fetching hotels: $error')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5EDDC),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Gap(40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Hello $userName',
                            style: const TextStyle(fontSize: 24)),
                        const Gap(5),
                        const Text('Book Ticket',
                            style: TextStyle(
                                fontSize: 32, fontWeight: FontWeight.bold)),
                      ],
                    ),
                    Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: const DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage('assets/images/logo.png'),
                        ),
                      ),
                    ),
                  ],
                ),
                const Gap(25),
                GestureDetector(
                  onTap: () {
                    // Navigate to search screen
                    Navigator.pushNamed(context, '/search');
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 12),
                    child: Row(
                      children: [
                        const Icon(Icons.search, color: Colors.black),
                        const Gap(5),
                        const Text("Search...", style: TextStyle(fontSize: 16)),
                      ],
                    ),
                  ),
                ),
                const Gap(40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Upcoming trains',
                        style: TextStyle(fontSize: 24)),
                    InkWell(
                      onTap: () {
                        // Navigate to all upcoming trains screen
                        Navigator.pushNamed(context, '/all-trains');
                      },
                      child: const Text('View all',
                          style: TextStyle(fontSize: 16, color: Colors.black)),
                    ),
                  ],
                ),
                const Gap(15),
              ],
            ),
          ),

          // Horizontal Scroll for Upcoming Tickets
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.only(left: 20),
            child: Row(
              children: (ticketList ?? [])
                  .map((ticket) => Tickets(ticket: ticket))
                  .toList(),
            ),
          ),

          const Gap(15),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Hotels', style: TextStyle(fontSize: 24)),
                InkWell(
                  onTap: () {
                    // Navigate to all hotels screen
                    Navigator.pushNamed(context, '/all-hotels');
                  },
                  child: const Text('View all',
                      style: TextStyle(fontSize: 16, color: Colors.black)),
                ),
              ],
            ),
          ),

          const Gap(15),

          // Horizontal Scroll for Hotels
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.only(left: 20),
            child: Row(
              children: (hotelList ?? [])
                  .map((hotel) => HotelsScreen(hotel: hotel))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
