class AddressController {
  String? addressFieldValidator(String? name) {
    if (name!.isEmpty) {
      return "Name can't be empty";
    }

    return null;
  }
}
