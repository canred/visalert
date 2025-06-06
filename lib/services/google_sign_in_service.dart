import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GoogleSignInService extends ChangeNotifier {
  static final GoogleSignInService instance = GoogleSignInService._internal();
  factory GoogleSignInService() => instance;
  GoogleSignInService._internal();

  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: <String>['email'],
    // clientId:
    //     '698886460125-grd6pidafvp41vu610i52uenf5e0ac8u.apps.googleusercontent.com',
  );

  String? _userEmail;
  String? get userEmail => _userEmail;

  Future<GoogleSignInAccount?> signIn() async {
    try {
      final account = await _googleSignIn.signIn();
      _userEmail = account?.email;
      final prefs = await SharedPreferences.getInstance();
      if (_userEmail != null) {
        await prefs.setString('userEmail', _userEmail!);
      } else {
        await prefs.remove('userEmail');
      }
      notifyListeners();
      return account;
    } catch (e) {
      print('Google sign in error: $e');
      return null;
    }
  }

  Future<void> signOut() async {
    await _googleSignIn.signOut();
    _userEmail = null;
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('userEmail');
    notifyListeners();
  }

  GoogleSignInAccount? get currentUser => _googleSignIn.currentUser;

  Future<void> init() async {
    final prefs = await SharedPreferences.getInstance();
    _userEmail = prefs.getString('userEmail');
    _googleSignIn.onCurrentUserChanged.listen((account) async {
      _userEmail = account?.email;
      final prefs = await SharedPreferences.getInstance();
      if (_userEmail != null) {
        await prefs.setString('userEmail', _userEmail!);
      } else {
        await prefs.remove('userEmail');
      }
      notifyListeners();
    });
    await _googleSignIn.signInSilently();
    _userEmail =
        _googleSignIn.currentUser?.email ?? prefs.getString('userEmail');
    notifyListeners();
  }
}
