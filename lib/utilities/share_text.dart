import 'package:share_plus/share_plus.dart';

void shareText(String text) async {
  await Share.share(text);
}
