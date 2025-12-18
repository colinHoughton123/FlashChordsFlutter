enum InversionType {
  root,
  first,
  second,
}

extension InversionParsing on InversionType {
  static InversionType fromString(String value) {
    switch (value) {
      case "root":
        return InversionType.root;
      case "first":
        return InversionType.first;
      case "second":
        return InversionType.second;
      default:
        throw Exception("Unknown inversion: $value");
    }
  }

  String get asString {
    switch (this) {
      case InversionType.root:
        return "root";
      case InversionType.first:
        return "first";
      case InversionType.second:
        return "second";
    }
  }
}