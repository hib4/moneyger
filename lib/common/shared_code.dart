import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedCode {
  String? emptyValidator(value) {
    return value.toString().trim().isEmpty ? 'Bidang tidak boleh kosong' : null;
  }

  String? niyValidator(value) {
    return value.toString().length < 10
        ? 'NIY tidak boleh kurang dari 10 angka'
        : null;
  }

  String? emailValidator(value) {
    bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(value);
    return !emailValid ? 'Email tidak valid' : null;
  }

  String? passwordValidator(value) {
    return value.toString().length < 6
        ? 'Kata sandi tidak boleh kurang dari 6 karakter'
        : null;
  }

  Future<bool> setToken(String token, String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(token, value);
  }

  Future<String> getToken(String token) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(token) ?? '';
  }

  String get uid => FirebaseAuth.instance.currentUser!.uid;

  String get day => DateFormat('EEE').format(DateTime.now()).toLowerCase();

  String get formattedDate =>
      '${DateTime.now().weekOfMonth}-${DateFormat('MM-yyy').format(DateTime.now())}';
}

extension DateTimeExtension on DateTime {
  int get weekOfMonth {
    var date = this;
    final firstDayOfTheMonth = DateTime(date.year, date.month, 1);
    int sum = firstDayOfTheMonth.weekday - 1 + date.day;
    if (sum % 7 == 0) {
      return sum ~/ 7;
    } else {
      return sum ~/ 7 + 1;
    }
  }
}
