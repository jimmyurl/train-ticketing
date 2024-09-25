import 'package:flutter/material.dart';
import 'package:gap/gap.dart'; // Ensure this import is included
import 'package:sgr_ticketing/utils/data.dart'; // Adjust according to your project structure
import 'package:sgr_ticketing/utils/app_styles.dart'; // Adjust according to your project structure
import 'package:sgr_ticketing/widgets/tickets.dart'; // Adjust according to your project structure
import 'package:sgr_ticketing/widgets/hotels_sceen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Sample variable to simulate fetching user name
  String userName = "Jimmy"; // This could be dynamically fetched

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.primaryColor,
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
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
                        Text('Hello $userName', style: TextStyles.headline3),
                        const Gap(5),
                        Text('Book Ticket', style: TextStyles.headline1),
                      ],
                    ),
                    Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
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
                      color: ColorManager.white,
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                    child: Row(
                      children: [
                        Icon(Icons.search, color: ColorManager.textColor),
                        const Gap(5),
                        Text("Search...", style: TextStyles.headline4),
                      ],
                    ),
                  ),
                ),
                const Gap(40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Upcoming trains', style: TextStyles.headline2),
                    InkWell(
                      onTap: () {
                        // Navigate to all upcoming trains screen
                        Navigator.pushNamed(context, '/all-trains');
                      },
                      child: Text('View all',
                          style: TextStyles.textStyle
                              .copyWith(color: ColorManager.black1)),
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
            padding: EdgeInsets.only(left: 20),
            child: Row(
              children: (ticketList ?? [])
                  .map((ticket) => Tickets(ticket: ticket))
                  .toList(),
            ),
          ),

          const Gap(15),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Hotels', style: TextStyles.headline2),
                InkWell(
                  onTap: () {
                    // Navigate to all hotels screen
                    Navigator.pushNamed(context, '/all-hotels');
                  },
                  child: Text('View all',
                      style: TextStyles.textStyle
                          .copyWith(color: ColorManager.black1)),
                ),
              ],
            ),
          ),

          const Gap(15),

          // Horizontal Scroll for Hotels
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.only(left: 20),
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
