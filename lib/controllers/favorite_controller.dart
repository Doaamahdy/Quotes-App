import 'package:get/get.dart';
import 'package:quotes_app/data.dart';
import 'package:quotes_app/db/db.dart';
import 'package:quotes_app/models/quote.dart';

class FavouriteController extends GetxController {
  var favouriteQuotes = <Quote>[].obs;
  var quotes = <Quote>[].obs;
  @override
  void onReady() {
    super.onReady();
  }

  Future<void> getQuotes() async {
    quotes.assignAll(listOfQuotes.map((data) => Quote.fromJson(data)));
  }

  Future<bool> addToFavourite(Quote quote) async {
    bool isExist = await DBHelper.checkExist(quote);
    if (isExist) {
      return false;
    } else {
      await DBHelper.insert(quote);
      await getFavourites();
      return true;
    }
  }

  Future<void> getFavourites() async {
    List<Map<String, dynamic>> jsonQuotes = await DBHelper.query();
    favouriteQuotes.assignAll(jsonQuotes.map((data) => Quote.fromJson(data)));
  }

  Future<void> deleteFromFavourite(Quote quote) async {
    await DBHelper.delete(quote);
    await getFavourites();
  }
}
