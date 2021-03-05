extension StringExtension on String {
  bool get isNotNullOrEmpty => this != null || isNotEmpty;
  bool get isNullOrEmpty => this == null || isEmpty;

  /// Prettify URL.
  String prettifyUrl() {
    final Uri urlObject = Uri.parse(this);

    return urlObject.host +
        ((urlObject.path != '' && urlObject.path != '/') ? urlObject.path : '');
  }

  /// Get initials for a given name.
  String get initials {
    final List<String> names = split(' ');
    String initials = '';
    int numWords = 1;

    if (numWords < names.length) {
      numWords = names.length;
    }
    for (int i = 0; i < numWords; i++) {
      initials += '${names[i][0]}';
    }
    return initials;
  }

  /// Truncate string with ellipsis.
  String truncateWithEllipsis(int cutoff) {
    return (length <= cutoff) ? this : '${substring(0, cutoff)}...';
  }

  /// Capitalize first letter of each word
  String toTitleCases() {
    if (this == null) {
      return null;
    }

    if (this.length <= 1) {
      return this.toUpperCase();
    }

    // Split string into multiple words
    final List<String> words = this.split(' ');

    // Capitalize first letter of each words
    final Iterable<String> capitalizedWords = words.map((String word) {
      final String firstLetter = word.substring(0, 1).toUpperCase();
      final String remainingLetters = word.substring(1);

      return '$firstLetter$remainingLetters';
    });

    // Join/Merge all words back to one String
    return capitalizedWords.join(' ');
  }
}
