import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
