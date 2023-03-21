const String empty = "";

extension ImageConstantsExtension on String {
  String get toJSON => 'assets/json/$this.json';
  String get toPNG => 'assets/images/$this.png';
  String get toSVG => 'assets/images/$this.svg';
}

extension NonNullString on String? {
  bool isNumeric() {
    if (this == null) {
      return false;
    }
    return double.tryParse(this!) != null;
  }

  String orEmpty() {
    if (this == null) {
      return empty;
    } else {
      return this!;
    }
  }
}

extension StringCasingExtension on String {
  String toCapitalized() =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';

  String toTitleCase() => replaceAll(RegExp(' +'), ' ')
      .split(' ')
      .map((str) => str.toCapitalized())
      .join(' ');
}
