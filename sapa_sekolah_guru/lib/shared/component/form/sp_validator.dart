class SPValidator {
  static String? validateEmail(String? value) {
    if (value?.isEmpty ?? false) {
      return "Tidak boleh kosong";
    } else if (!RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
    ).hasMatch(value!)) {
      return "E-mail tidak sesuai format";
    }
    return null;
  }

  static String? validateEmpty(String? value) {
    if (value?.isEmpty ?? false) {
      return "Tidak boleh kosong";
    }
    return null;
  }
}
