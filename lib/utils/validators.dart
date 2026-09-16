String? validateName(String? value) {
  if (value == null || value.trim().isEmpty) {
    return "Name is required";
  }
  return null;
}

String? validateInt(String? value) {
  if (value == null || value.trim().isEmpty) {
    return "This field is required";
  }
  if (int.tryParse(value) == null) {
    return "Enter a whole number";
  }
  return null;
}

String? validateYear(String? value) {
  if (value == null || value.trim().isEmpty) {
    return "This field is required";
  }
  final year = int.tryParse(value);
  if (year == null) {
    return "Enter valid year";
  }
  if (year < 1949 || year > 2026) {
    return "Enter valid year";
  }
  return null;
}

String? validatePrice(String? value) {
  if (value == null || value.trim().isEmpty) {
    return "This field is required";
  }
  if (double.tryParse(value) == null) {
    return "Enter a valid price";
  }
  return null;
}
