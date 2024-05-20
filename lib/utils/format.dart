class Format {
  static String formatRupiah(int number) {
    final numberString = number.toString();
    String result = '';
    for (int i = 0; i < numberString.length; i++) {
      if (i % 3 == 0 && i != 0) {
        result = '.$result';
      }
      result = numberString[numberString.length - i - 1] + result;
    }
    return 'Rp$result';
  }
}
