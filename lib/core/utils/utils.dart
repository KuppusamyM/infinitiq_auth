import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:intl/intl.dart';

String getHashedValue(String text) {
  final hash =
      sha512.convert(utf8.encode(text));
  return hash.toString();
}

String getFormattedString(int value,int formatLength,String valueToBePadded){
  return value.toString().padLeft(formatLength, valueToBePadded);
}

String dateFormattedDate(String? date){
  if(date == null) return "";
  DateTime tempDate =  DateFormat("yyyy-MM-dd'T'HH:mm:ss").parse(date);

  return DateFormat("dd MMMM").format(tempDate);
}
