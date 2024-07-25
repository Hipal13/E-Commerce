import 'package:e_commerce_app/Model/productModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen(
      {super.key,
      required this.image,
      required this.title,
      required this.category,
      required this.rating,
      required this.viewer,
      required this.description,
      required this.price});
  final String image;
  final String title;
  final String category;
  final num rating;
  final int viewer;
  final String description;
  final num price;

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  bool isLoaded = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: Text(
              "Article Details",
              style: GoogleFonts.montserrat(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            centerTitle: true,
          ),
          backgroundColor: Colors.white,
          body: isLoaded == true
              ? Center(child: CircularProgressIndicator())
              : ListView(padding: EdgeInsets.all(10), shrinkWrap: true, children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Container(
                              height: 250,
                              width: 200,
                              child: Hero(
                                tag: widget.image,
                                child: Image(
                                  image: NetworkImage(widget.image),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            widget.title,
                            style: GoogleFonts.montserrat(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Row(
                            children: [

                                Text(
                                  widget.category,
                                  style: GoogleFonts.montserrat(
                                    color: Colors.grey,
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),

                              const SizedBox(width:25),
                              const Icon(
                                Icons.star,
                                color: Colors.orange,
                                size: 20,
                              ),
                              const SizedBox(width: 5),
                              Text(
                                widget.rating.toString(),
                                style: GoogleFonts.montserrat(
                                  color: Colors.black,
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(width: 5),
                              Text(
                                "(${widget.viewer.toString()} Reviews)",
                                style: GoogleFonts.montserrat(
                                  color: Colors.grey,
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Text(
                            "Information",
                            style: GoogleFonts.montserrat(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            widget.description,
                            style: GoogleFonts.montserrat(
                              color: Colors.grey,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "\$ ${widget.price.toString()}",
                                style: GoogleFonts.montserrat(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                width: 200,
                                child: FilledButton.icon(
                                  onPressed:(){
                                  },
                                  icon: Icon(Icons.add),
                                  label: Text("Add To Cart"),
                                  style: FilledButton.styleFrom(
                                      backgroundColor: Colors.black
                                  ),),
                              )
                            ],
                          ),
                        ]),
                  ),
                ])),
    );
  }
}
