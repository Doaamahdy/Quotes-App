import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quotes_app/controllers/favorite_controller.dart';
import 'package:quotes_app/initialConfiguration.dart';
import 'package:quotes_app/pages/favourites_page.dart';
import 'package:quotes_app/pages/home_page.dart';
import 'package:quotes_app/pages/quotes_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int currentIndex = 0;
  final List pages = [HomePage(), QuotesPage(), FavouritePage()];
  FavouriteController _favouriteController = Get.put(FavouriteController());
  @override
  void initState() {
    super.initState();
    _favouriteController.getQuotes();
  }

  @override
  Widget build(BuildContext context) {
    void onTap(index) {
      setState(() {
        startPage = index;
      });
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: pages[startPage],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: startPage,
        selectedFontSize: 14,
        unselectedFontSize: 14,
        type: BottomNavigationBarType.fixed,
        onTap: onTap,
        elevation: 10,
        backgroundColor: Colors.white,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey.withOpacity(0.9),
        items: const [
          BottomNavigationBarItem(
              label: "Today", icon: Icon(Icons.calendar_today)),
          BottomNavigationBarItem(label: "Quotes", icon: Icon(Icons.list)),
          BottomNavigationBarItem(
              label: "Favourites", icon: Icon(Icons.favorite_border))
        ],
      ),
    );
  }
}
