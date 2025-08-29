class BackgroundManager {
  static const List<String> themeFolders = [
    "pastel",
    "warm",
    "sky",
    "earth",
    "spring",
    "candy",
  ];

  static List<String> getBackgroundsForRange(int minValue, int maxValue, {int theme = 0}) {
    List<String> selectedBackgrounds = [];
    String folder = themeFolders[theme % themeFolders.length];

    for (int i = minValue; i <= maxValue; i++) {
      selectedBackgrounds.add('assets/images/$folder/dice-$i.png');
    }

    return selectedBackgrounds;
  }
}
