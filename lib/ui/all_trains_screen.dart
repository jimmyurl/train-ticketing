import 'package:flutter/material.dart';
import 'package:sgr_ticketing/utils/data.dart'; // Ensure the correct path to your data.dart
import 'package:sgr_ticketing/utils/app_styles.dart'; // Ensure the correct path to your app_styles.dart

class AllTrainsScreen extends StatelessWidget {
  const AllTrainsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Trains'),
      ),
      body: ListView.builder(
        itemCount: ticketList.length,
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.all(10.0),
            child: ListTile(
              title: Text(
                '${ticketList[index]['from']['name']} to ${ticketList[index]['to']['name']}',
                style: TextStyles.headline2,
              ),
              subtitle: Text(
                'Departure: ${ticketList[index]['dep_time']} | Duration: ${ticketList[index]['time']} | Date: ${ticketList[index]['date']}',
              ),
              trailing: Text('Ticket Number: ${ticketList[index]['number']}'),
              onTap: () {
                // Add navigation to ticket details if needed
              },
            ),
          );
        },
      ),
    );
  }
}
