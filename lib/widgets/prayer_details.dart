import 'package:flutter/material.dart';

class PrayerDetails extends StatefulWidget {
  const PrayerDetails({
    super.key,
    required this.title,
    required this.duration,
  });

  final String title;
  final int duration;

  @override
  State<PrayerDetails> createState() => _PrayerDetailsState();
}

class _PrayerDetailsState extends State<PrayerDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Text(widget.duration.toString()),
      ),
    );
  }
}
