import 'package:flutter/foundation.dart';

void globalPrint(String text)
{
  if (kDebugMode) {
    print(text);
  }
}