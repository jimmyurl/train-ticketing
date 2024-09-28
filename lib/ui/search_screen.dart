import 'package:flutter/material.dart';
import 'package:Tikiti/utils/data.dart'; // Ensure the correct path to your data.dart
import 'package:Tikiti/utils/app_styles.dart'; // Ensure the correct path to your app_styles.dart

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search'),
      ),
      body: ListView.builder(
        itemCount: hotelList.length,
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.all(10.0),
            child: ListTile(
              leading: Image.asset(
                'assets/images/${hotelList[index]['image']}', // Ensure the images are in the correct folder
                width: 100,
                fit: BoxFit.cover,
              ),
              title:
                  Text(hotelList[index]['place'], style: TextStyles.headline2),
              subtitle: Text(
                  '${hotelList[index]['destination']} - \$${hotelList[index]['price']}'),
              onTap: () {
                // Add navigation to hotel details if needed
              },
            ),
          );
        },
      ),
    );
  }
}
