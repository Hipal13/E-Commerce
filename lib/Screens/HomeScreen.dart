import 'dart:convert';
import 'package:e_commerce_app/Screens/ProductDetailScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:shimmer/shimmer.dart';
import 'package:e_commerce_app/Widgets/ProductGridView.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> myCategories = [];
  List<dynamic> products = [];
  bool isLoading = true;
  bool isSorting = false;
  bool isFirstLoad = true;
  String selectedCategory = "All";
  int? selectedItemLimit;
  final List<int> itemLimits = [5, 10, 15, 20];
  bool isAscending = true;
  bool showItemLimitDropdown = true;

  @override
  void initState() {
    super.initState();
    fetchCategories();
    fetchCategoriesProducts("All", selectedItemLimit);
  }

  Future<void> fetchCategories() async {
    Uri url = Uri.parse("https://fakestoreapi.com/products");
    try {
      final response = await http.get(url);
      final List<dynamic> data = json.decode(response.body);
      final List<String> fetchedCategories = ["All"];

      for (var product in data) {
        final String category = product["category"];
        if (!fetchedCategories.contains(category)) {
          fetchedCategories.add(category);
        }
      }
      if (mounted) {
        setState(() {
          myCategories = fetchedCategories;
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to load categories: $e")),
      );
    }
  }

  Future<void> fetchCategoriesProducts(String category, int? limit) async {
    setState(() {
      isLoading = true;
      isSorting = false; // Reset sorting state
    });
    Uri url = Uri.parse("https://fakestoreapi.com/products");
    try {
      final response = await http.get(url);
      final List<dynamic> data = json.decode(response.body);
      final List<dynamic> categoryProducts = [];

      for (var product in data) {
        final String productCategory = product["category"];
        if (category == "All" || productCategory == category) {
          categoryProducts.add(product);
        }
        if (limit != null && categoryProducts.length == limit) {
          break;
        }
      }

      categoryProducts.sort((a, b) {
        if (isAscending) {
          return a["price"].compareTo(b["price"]);
        } else {
          return b["price"].compareTo(a["price"]);
        }
      });

      if (mounted) {
        setState(() {
          selectedCategory = category;
          products = categoryProducts;
          isLoading = false;
          isFirstLoad = false; // Set isFirstLoad to false after first fetch
          showItemLimitDropdown = category == "All";
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to load products: $e")),
      );
    }
  }

  void sortProducts() async {
    setState(() {
      isSorting = true;
    });

    await Future.delayed(const Duration(seconds: 1)); // Simulate network delay

    products.sort((a, b) {
      if (isAscending) {
        return a["price"].compareTo(b["price"]);
      } else {
        return b["price"].compareTo(a["price"]);
      }
    });

    setState(() {
      isSorting = false;
    });
  }

  void showFilterDialog() {
    if (selectedCategory != "All") {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Filter applied to only All Categories.",
            style: GoogleFonts.montserrat(
              color: Colors.black,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: Colors.pinkAccent.shade100,
          duration: Duration(seconds: 3),
        ),
      );
    } else {
      int? tempItemLimit = selectedItemLimit;

      showDialog(
          context: context,
          builder: (context) {
            return StatefulBuilder(
              builder: (context, setState) {
                return AlertDialog(
                  title: Text("Filter Options", style: GoogleFonts.montserrat(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
// Display the current item limit in the dropdown
                      Text("Select Item Limit"),
                      DropdownButton<int?>(
                        value: tempItemLimit,
                        items:
                            itemLimits.map<DropdownMenuItem<int?>>((int value) {
                          return DropdownMenuItem<int?>(
                            value: value,
                            child: Text("$value items"),
                          );
                        }).toList(),
                        onChanged: (int? newValue) {
                          setState(() {
                            tempItemLimit =
                                newValue; // Update temporary item limit
                          });
                        },
                      ),
                    ],
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        setState(() {
                          selectedItemLimit =
                              tempItemLimit; // Apply selected item limit
                          fetchCategoriesProducts(selectedCategory,
                              selectedItemLimit); // Fetch products with the new limit
                        });
                        Navigator.of(context).pop(); // Close the dialog
                      },
                      child: Text("Apply"),
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          selectedItemLimit = null; // Clear the item limit
                          fetchCategoriesProducts(selectedCategory,
                              selectedItemLimit); // Fetch products with no limit
                        });
                        Navigator.of(context).pop(); // Close the dialog
                      },
                      child: Text("Clear"),
                    ),
                  ],
                );
              },
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
            "Hello Fashioner",
            style: GoogleFonts.montserrat(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.filter_list),
              onPressed: showFilterDialog,
            ),
            IconButton(
              icon: Icon(
                isAscending ? Icons.arrow_upward : Icons.arrow_downward,
              ),
              onPressed: () {
                setState(() {
                  isAscending = !isAscending;
                  sortProducts();
                });
              },
            ),
          ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.all(10),
              child: Container(
                height: 180,
                child: Image(
                  image: AssetImage('assets/download.jpeg'),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            SizedBox(
              height: 60,
              child: ListView.builder(
                itemCount: myCategories.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: GestureDetector(
                      onTap: () {
                        if (myCategories[index] == selectedCategory) {
                          return;
                        }
                        setState(() {
                          selectedItemLimit = null;
                          selectedCategory = myCategories[index];
                          fetchCategoriesProducts(
                              myCategories[index], selectedItemLimit);
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: myCategories[index] == selectedCategory
                              ? Colors.black
                              : Colors.black12,
                        ),
                        child: Center(
                          child: Text(
                            myCategories[index],
                            style: TextStyle(
                              fontWeight:
                                  myCategories[index] == selectedCategory
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                              color: myCategories[index] == selectedCategory
                                  ? Colors.white
                                  : Colors.black,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: ProductGridView(
                  products: products,
                  isLoading: isFirstLoad || isSorting,
                  isSorting: isSorting,
                  onProductTap: (product) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductDetailScreen(
                          image: product["image"],
                          title: product["title"],
                          category: product["category"],
                          rating: product["rating"]["rate"],
                          viewer: product["rating"]["count"],
                          description: product["description"],
                          price: product["price"],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
