import 'package:shared_preferences/shared_preferences.dart';

class PreferencesHelper {
  final SharedPreferences _preferences;

  PreferencesHelper(this._preferences);

  Future<void> saveUserDetails(Map<String, dynamic> userDetails) async {
    await _preferences.setString("token", userDetails['token']);
    await _preferences.setString("name", userDetails['user']['name']);
    await _preferences.setInt("userId", userDetails['user']['id']);
    if (userDetails['user']['image'] != null) {
      await _preferences.setString(
          "profilePicture", userDetails['user']['image']);
    }
  }

  Future<void> saveUserDetailsRegister(Map<String, dynamic> userDetails) async {
    await _preferences.setString("token", userDetails['token']);
    await _preferences.setString("name", userDetails['user']['name']);
    await _preferences.setInt("userId", userDetails['user']['id']);
  }

  Future<String?> getToken() async {
    return _preferences.getString("token");
  }
}
