import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quotes_app/controllers/favorite_controller.dart';
import 'package:quotes_app/widgets/quote_item.dart';

class QuotesPage extends StatefulWidget {
  const QuotesPage({super.key});

  @override
  State<QuotesPage> createState() => _QuotesPageState();
}

class _QuotesPageState extends State<QuotesPage> {
  final FavouriteController _quoteController = Get.put(FavouriteController());

  @override
  void initState() {
    super.initState();
    _quoteController.getQuotes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.arrow_back),
        title: Text(
          "More Quotes",
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: List.generate(
                    _quoteController.quotes.length,
                    (index) => Container(
                          margin: const EdgeInsets.only(bottom: 30),
                          child: QuoteLisItem(
                              quote: _quoteController.quotes[index]),
                        )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
