import 'package:flutter/material.dart';

class SelectScreen extends StatelessWidget {
  const SelectScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Example train data
    final List<Map<String, dynamic>> trains = [
      {'id': 1, 'name': 'Train A'},
      {'id': 2, 'name': 'Train B'},
      {'id': 3, 'name': 'Train C'},
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Select Train')),
      body: ListView.builder(
        itemCount: trains.length,
        itemBuilder: (context, index) {
          final train = trains[index];
          return ListTile(
            title: Text(train['name']),
            onTap: () {
              // Navigate to the SeatSelectionScreen with the selected train ID
              Navigator.pushNamed(
                context,
                '/seat-selection',
                arguments: train['id'],
              );
            },
          );
        },
      ),
    );
  }
}
