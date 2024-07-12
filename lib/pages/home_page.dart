import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quotes_app/controllers/favorite_controller.dart';
import 'package:quotes_app/utilities/add_to_favourite.dart';
import 'package:quotes_app/utilities/copy.dart';
import 'package:quotes_app/utilities/exist.dart';
import 'package:quotes_app/utilities/share_text.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FavouriteController _controller = Get.put(FavouriteController());
  int todayQuoteIndex = 0;
  static const String QUOTE_KEY = "quote_key";
  static const String TIMESTAMP_KEY = "timestamp_key";

  Future<void> checkAndUpdateQuote() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? savedQuote = prefs.getInt(QUOTE_KEY);
    int? savedTimestamp = prefs.getInt(TIMESTAMP_KEY);

    int currentTimestamp = DateTime.now().millisecondsSinceEpoch;
    // int oneDayInMillis = 24 * 60 * 60 * 1000;
    int oneDayInMillis = 2 * 60 * 1000;

    if (savedQuote != null && savedTimestamp != null) {
      if (currentTimestamp - savedTimestamp > oneDayInMillis) {
        updateQuote(prefs);
      } else {
        setState(() {
          todayQuoteIndex = savedQuote;
        });
      }
    } else {
      updateQuote(prefs);
    }
  }

  void updateQuote(SharedPreferences prefs) {
    Random random = Random();
    int index = random.nextInt(_controller.quotes.length - 1);

    setState(() {
      todayQuoteIndex = index;
    });
    prefs.setInt(QUOTE_KEY, todayQuoteIndex);
    prefs.setInt(TIMESTAMP_KEY, DateTime.now().millisecondsSinceEpoch);
  }

  @override
  void initState() {
    super.initState();
    checkAndUpdateQuote();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Container(
        margin: const EdgeInsets.only(left: 20, right: 20, top: 50),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Quote Of Today",
                  style: GoogleFonts.lato(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
                GestureDetector(
                  onTap: () {
                    exitApp();
                  },
                  child: const Icon(
                    Icons.exit_to_app,
                    color: Colors.black,
                    weight: 700,
                    size: 30,
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 100,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Good Morning!",
                  style: GoogleFonts.lato(
                    textStyle: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
                  height: 400,
                  width: 350,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [
                        Color.fromARGB(255, 120, 181, 232),
                        Color.fromARGB(255, 217, 147, 229),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      //Text Quote
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            alignment: Alignment.center,
                            width: 300,
                            child: Text(
                              _controller.quotes[todayQuoteIndex].text!,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.lato(
                                color: Colors.white,
                                textStyle: const TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.w500,
                                    fontStyle: FontStyle.italic),
                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      //Author
                      Container(
                        margin: const EdgeInsets.only(right: 10),
                        width: double.maxFinite,
                        child: Text(
                          "- ${_controller.quotes[todayQuoteIndex].author!}",
                          textAlign: TextAlign.right,
                          style: GoogleFonts.lato(
                            color: Colors.white,
                            textStyle: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 50,
                      ),

                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                addToFavourite(
                                    _controller.quotes[todayQuoteIndex]);
                              },
                              child: const Icon(
                                Icons.favorite,
                                color: Colors.red,
                                size: 30,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                copyToClipboard(
                                    '"${_controller.quotes[todayQuoteIndex]}"');
                              },
                              child: const Icon(
                                Icons.copy,
                                color: Colors.white,
                                size: 30,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                shareText(
                                    '"${_controller.quotes[todayQuoteIndex]}"');
                              },
                              child: const Icon(
                                Icons.share,
                                color: Colors.white,
                                size: 30,
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
