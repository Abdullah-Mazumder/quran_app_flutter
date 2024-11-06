String htmlToText(String htmlString) {
  final RegExp regex = RegExp(r"<[^>]*>");
  return htmlString.replaceAll(regex, "");
}
