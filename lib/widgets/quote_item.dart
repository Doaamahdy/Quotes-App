import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quotes_app/controllers/favorite_controller.dart';
import 'package:quotes_app/models/quote.dart';
import 'package:quotes_app/utilities/add_to_favourite.dart';
import 'package:quotes_app/utilities/share_text.dart';

class QuoteLisItem extends StatelessWidget {
  final Quote quote;
  final bool isFavourite;

  const QuoteLisItem(
      {super.key, required this.quote, this.isFavourite = false});

  @override
  Widget build(BuildContext context) {
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
            '"${quote.text}"',
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
                      child: const Icon(Icons.share),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    isFavourite == true
                        ? GestureDetector(
                            onTap: () {
                              FavouriteController favouriteController =
                                  Get.put(FavouriteController());

                              favouriteController.deleteFromFavourite(quote);
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
                  "- ${quote.author!}",
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
