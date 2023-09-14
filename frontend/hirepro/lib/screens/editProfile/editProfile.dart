class EditProfile {
  
  String getInitials(String name) {
    List<String> names = name.split(' ');
    int size = names.length;
    String initials = names[0][0] + names[size - 1][0];
    return initials;
  }
}
