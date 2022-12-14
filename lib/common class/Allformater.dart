// ignore_for_file: non_constant_identifier_names, no_leading_underscores_for_local_identifiers, file_names

import 'package:intl/intl.dart';

FormatedDate(_date) {
  var inputFormat = DateFormat('dd-MM-yyyy');
  var inputDate = inputFormat.parse(_date);
  var outputFormat = DateFormat('dd MMM yyyy');
  return outputFormat.format(inputDate);
}

final numberFormat = NumberFormat("####0.00", "en_US");
final numberFormatas = NumberFormat.currency();
