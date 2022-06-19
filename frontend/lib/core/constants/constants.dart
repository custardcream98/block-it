class Assets {
  static const String boxIconDir = 'lib/core/assets/icons/box.png';
  static const String paletteIconDir = 'lib/core/assets/icons/palette.png';
  static const String markdownIconDir = 'lib/core/assets/icons/markdown.png';
}

class HiveBoxes {
  static const String memoBox = 'memos';
}

class MemosModelKey {
  static const String generatedTimestampKey = 'memo_generated_on';
  static const String tagKey = 'memo_tag';
  static const String memoKey = 'memo';
  static const String titleKey = 'memo_title';
  static const String colorValueKey = 'memo_colorValue';
  static const String imagePathKey = 'memo_image_path';
  static const String memoWidgetTypeKey = 'memo_widget_type';

  // For Place
  static const String placeNameKey = 'place_name';
  static const String placeAddressKey = 'place_address';
  static const String placeXkey = 'place_x';
  static const String placeYkey = 'place_y';
}

class MemoWidgetType {
  static const int labelLong = 0;
  static const int labelShort = 1;
  static const int squareLarge = 2;
  static const int squareMidium = 3;
  static const int squareSmall = 4;
}
