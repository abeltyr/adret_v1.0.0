bool isDouble(String s) {
  if (s.isEmpty) {
    return false;
  }
  return double.tryParse(s) != null;
}

bool isInt(String s) {
  if (s.isEmpty) {
    return false;
  }
  return int.tryParse(s) != null;
}
