import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quotes_app/utilities/snacker.dart';

void copyToClipboard(String text) async {
  await Clipboard.setData(ClipboardData(text: text));
  showSnackbar('Copied "$text" to clipboard!');
}
