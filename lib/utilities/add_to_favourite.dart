import 'package:get/get.dart';
import 'package:quotes_app/controllers/favorite_controller.dart';
import 'package:quotes_app/models/quote.dart';
import 'package:quotes_app/utilities/snacker.dart';

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
