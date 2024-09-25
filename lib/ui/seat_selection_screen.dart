// ui/seat_selection_screen.dart
import 'package:flutter/material.dart';

class SeatSelectionScreen extends StatelessWidget {
  final int trainId;

  const SeatSelectionScreen({Key? key, required this.trainId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Seat Selection for Train $trainId'),
      ),
      body: Center(
        child: Text('Select seats for train $trainId'),
      ),
    );
  }
}
