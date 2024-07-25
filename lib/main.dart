import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Screens/SplashScreen.dart';

void main(){
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}

// showDialog(
// context: context,
// builder: (context) {
// return StatefulBuilder(
// builder: (context, setState) {
// return AlertDialog(
// title: Text("Filter Options"),
// content: Column(
// mainAxisSize: MainAxisSize.min,
// children: [
// // Display the current item limit in the dropdown
// Text("Select Item Limit"),
// DropdownButton<int?>(
// value: tempItemLimit,
// items: itemLimits.map<DropdownMenuItem<int?>>((
// int value) {
// return DropdownMenuItem<int?>(
// value: value,
// child: Text("$value items"),
// );
// }).toList(),
// onChanged: (int? newValue) {
// setState(() {
// tempItemLimit =
// newValue; // Update temporary item limit
// });
// },
// ),
// ],
// ),
// actions: [
// TextButton(
// onPressed: () {
// setState(() {
// selectedItemLimit =
// tempItemLimit; // Apply selected item limit
// fetchCategoriesProducts(selectedCategory,
// selectedItemLimit); // Fetch products with the new limit
// });
// Navigator.of(context).pop(); // Close the dialog
// },
// child: Text("Apply"),
// ),
// TextButton(
// onPressed: () {
// setState(() {
// selectedItemLimit = null; // Clear the item limit
// fetchCategoriesProducts(selectedCategory,
// selectedItemLimit); // Fetch products with no limit
// });
// Navigator.of(context).pop(); // Close the dialog
// },
// child: Text("Clear"),
// ),
// ],
// );
// },
// );
// }
// );
