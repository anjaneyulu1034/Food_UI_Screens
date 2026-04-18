import 'package:flutter/material.dart';

import 'core/theme/app_theme.dart';
import 'screens/home/home_screen.dart';
import 'state/cart_controller.dart';

class FoodDeliveryApp extends StatefulWidget {
  const FoodDeliveryApp({super.key});

  @override
  State<FoodDeliveryApp> createState() => FoodDeliveryAppState();
}

class FoodDeliveryAppState extends State<FoodDeliveryApp> {
  late final CartController cartController;

  @override
  void initState() {
    super.initState();
    cartController = CartController();
  }

  @override
  void dispose() {
    cartController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Food Delivery App',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      home: HomeScreen(controller: cartController),
    );
  }
}
