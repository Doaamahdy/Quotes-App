import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quotes_app/controllers/favorite_controller.dart';
import 'package:quotes_app/models/quote.dart';
import 'package:share_plus/share_plus.dart';

class QuoteLisItem extends StatelessWidget {
  final Quote quote;
  final bool isFavourite;

  const QuoteLisItem(
      {super.key, required this.quote, this.isFavourite = false});

  @override
  Widget build(BuildContext context) {
    void showSnackbar(String text) {
      Get.snackbar(
        "Snackbar Title", // title
        text, // message
        snackPosition: SnackPosition.BOTTOM, // position of the snackbar
        backgroundColor: Colors.black45, // background color
        colorText: Colors.white, // text color
        borderRadius: 10, // border radius
        margin: EdgeInsets.all(10), // margin
        duration: Duration(seconds: 2), // duration
      );
    }

    void addToFavourite(Quote quote) async {
      print("Here The text Of The Quote");
      print(quote.text);
      FavouriteController controller = Get.put(FavouriteController());
      bool success = await controller.addToFavourite(quote);
      if (!success) {
        showSnackbar("Quote Already Exists in Your Favourites List");
      } else {
        showSnackbar("Quote Added To Your Favourites Lsit");
      }
    }

    void shareText(String text) async {
      await Share.share(text);
    }

    return Container(
      padding: const EdgeInsets.only(right: 15, left: 15, top: 20, bottom: 20),
      width: MediaQuery.of(context).size.width - 50,
      height: 200,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.24),
              blurRadius: 8,
              spreadRadius: 0,
              offset: Offset(0, 3),
            ),
          ]),
      child: Column(
        children: [
          Text(
            quote.text!,
            style: GoogleFonts.lato(
                textStyle: TextStyle(
              color: Colors.black.withOpacity(0.9),
              fontSize: 19,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.bold,
            )),
          ),
          Expanded(child: Container()),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        shareText('"${quote.text}"');
                      },
                      child: Icon(Icons.share),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    isFavourite == true
                        ? GestureDetector(
                            onTap: () {
                              FavouriteController _favouriteController =
                                  Get.put(FavouriteController());

                              _favouriteController.deleteFromFavourite(quote);
                            },
                            child: const Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                          )
                        : GestureDetector(
                            onTap: () {
                              addToFavourite(quote);
                            },
                            child: const Icon(
                              Icons.favorite,
                              color: Colors.red,
                            ),
                          )
                  ],
                ),
                Text(
                  "- " + quote.author!,
                  style: GoogleFonts.lato(
                      textStyle: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 18,
                  )),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
