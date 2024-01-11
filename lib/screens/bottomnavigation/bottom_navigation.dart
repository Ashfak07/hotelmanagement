import 'package:flutter/material.dart';
import 'package:hotelmanagement/controller/food_add_controller/food_add_controller.dart';
import 'package:hotelmanagement/screens/food_item_screen/food_item_screen.dart';
import 'package:hotelmanagement/screens/inventory_screen/inventory_screen.dart';
import 'package:hotelmanagement/screens/home_screen/home_screen.dart';
import 'package:hotelmanagement/screens/order_screen/order_screen.dart';

class Bottomnavigation extends StatefulWidget {
  const Bottomnavigation({super.key});

  @override
  State<Bottomnavigation> createState() => _BottomnavigationState();
}

class _BottomnavigationState extends State<Bottomnavigation> {
  int currentindex = 0;
  @override
  Widget build(BuildContext context) {
    final List _pages = [
      HomeScreen(),
      FoodItemsScreen(),
      IventoryScreen(),
      OrderScreen()
    ];
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentindex,
          type: BottomNavigationBarType.fixed,
          onTap: (value) {
            setState(() {
              currentindex = value;
            });
          },
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.dashboard), label: 'Dashboard'),
            BottomNavigationBarItem(
                icon: Icon(Icons.food_bank_outlined), label: 'Food items'),
            BottomNavigationBarItem(
                icon: Icon(Icons.inventory), label: 'Inventory'),
            BottomNavigationBarItem(
                icon: Icon(Icons.soup_kitchen), label: 'Orders'),
          ]),
      body: _pages[currentindex],
    );
  }
}
