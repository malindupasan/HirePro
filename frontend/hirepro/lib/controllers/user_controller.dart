

class UserController {
  String getInitials(String name) {
    name = name.trim();
    List<String> names = name.split(' ');
    int size = names.length;
    late String initials;
    if (size > 1) {
      initials = names[0][0] + names[size - 1][0];
    } else {
      initials = names[0][0];
    }
    return initials;
  }
}
