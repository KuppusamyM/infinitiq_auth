



import 'package:intl/intl.dart';

String getFormattedDate(String date,String outputFormat){

  DateFormat dateFormatter = DateFormat("MM/dd/yyyy hh:mm:ss a");
  DateFormat outputFormatter = DateFormat(outputFormat);
  DateTime dateTime = dateFormatter.parse(date);
  return outputFormatter.format(dateTime);

}