part of utils;

String formatDate(DateTime date, [String format = 'yyyy.MM.dd HH:mm:ss']) {
  if (date == null) {
    return '-';
  }
  final formatter = DateFormat(format);
  final formatted = formatter.format(date);
  return formatted;
}
