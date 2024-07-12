import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quotes_app/controllers/favorite_controller.dart';
import 'package:quotes_app/models/quote.dart';
import 'package:quotes_app/widgets/quote_item.dart';

class FavouritePage extends StatefulWidget {
  const FavouritePage({super.key});

  @override
  State<FavouritePage> createState() => _FavouritePageState();
}

class _FavouritePageState extends State<FavouritePage> {
  FavouriteController _favouriteController = Get.put(FavouriteController());

  void delete(Quote quote) async {
    await _favouriteController.deleteFromFavourite(quote);
  }

  @override
  void initState() {
    super.initState();
    _favouriteController.getFavourites();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
            onTap: () {
              print("heloooooooooooooooooooos");
              Get.back();
            },
            child: Icon(Icons.arrow_back)),
        title: Text(
          "Favourites",
          style: GoogleFonts.lato(
            textStyle: const TextStyle(
                color: Colors.black, fontWeight: FontWeight.w500, fontSize: 20),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
                margin: const EdgeInsets.only(top: 10),
                width: double.infinity,
                child: Obx(() {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: List.generate(
                      _favouriteController.favouriteQuotes.length,
                      (index) => Container(
                        margin: const EdgeInsets.only(bottom: 30),
                        child: QuoteLisItem(
                          quote: _favouriteController.favouriteQuotes[index],
                        ),
                      ),
                    ),
                  );
                })),
          ],
        ),
      ),
    );
  }
}
