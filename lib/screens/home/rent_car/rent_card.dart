import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../../activity_screen.dart';

class RentCarScreen extends StatefulWidget {
  const RentCarScreen({super.key});

  @override
  State<RentCarScreen> createState() => _RentCarScreenState();
}

class _RentCarScreenState extends State<RentCarScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ActivitiesScreen(),
    );
  }
}