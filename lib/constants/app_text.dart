class AppText {
  static final userUid = "useruid";
  final emailRegExp = RegExp(
    r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$",
  );
  final passwordRegExp = RegExp(r'^(?=.*[!@#\$&*~]).{6,}$');
}
