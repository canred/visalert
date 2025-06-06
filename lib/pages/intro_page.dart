import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../main.dart';
import '../services/google_sign_in_service.dart';

class IntroPage extends StatefulWidget {
  final String appTitle;
  const IntroPage({super.key, required this.appTitle});

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: <String>['email'],
    // 如果你需要在 web 端手动指定 clientId，可以加上：
    //clientId:
    //    '698886460125-grd6pidafvp41vu610i52uenf5e0ac8u.apps.googleusercontent.com',
  );

  Future<void> _finishIntro(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('seen_intro', true);
    Navigator.of(context).pushReplacement(
      CupertinoPageRoute(
        builder: (context) => MyHomePage(title: widget.appTitle),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    GoogleSignInService.instance.addListener(_onUserChanged);
    _googleSignIn.onCurrentUserChanged.listen((account) {
      setState(() {
        // _userEmail = account?.email;
      });
    });
    _googleSignIn.signInSilently();
  }

  @override
  void dispose() {
    GoogleSignInService.instance.removeListener(_onUserChanged);
    super.dispose();
  }

  void _onUserChanged() {
    setState(() {}); // 只需刷新界面即可
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(middle: Text(widget.appTitle)),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              '欢迎使用VisAlert!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            const Text(
              '这里可以介绍APP的主要功能、亮点等。',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            CupertinoButton.filled(
              child: const Text('立即体验'),
              onPressed: () => _finishIntro(context),
            ),
            const SizedBox(height: 20),
            CupertinoButton(
              child: Text(
                GoogleSignInService.instance.userEmail == null ||
                        GoogleSignInService.instance.userEmail!.isEmpty
                    ? '使用 Google 登录'
                    : '已登录: ${GoogleSignInService.instance.userEmail}',
              ),
              onPressed: () async {
                if (GoogleSignInService.instance.userEmail == null ||
                    GoogleSignInService.instance.userEmail!.isEmpty) {
                  await GoogleSignInService.instance.signIn();
                  if (GoogleSignInService.instance.userEmail != null) {
                    showCupertinoDialog(
                      context: context,
                      builder:
                          (_) => CupertinoAlertDialog(
                            title: const Text('登录成功'),
                            content: Text(
                              '欢迎, ${GoogleSignInService.instance.userEmail}',
                            ),
                            actions: [
                              CupertinoDialogAction(
                                child: const Text('确定'),
                                onPressed: () => Navigator.of(context).pop(),
                              ),
                            ],
                          ),
                    );
                  } else {
                    showCupertinoDialog(
                      context: context,
                      builder:
                          (_) => const CupertinoAlertDialog(
                            title: Text('登录失败'),
                            content: Text('请重试'),
                          ),
                    );
                  }
                } else {
                  showCupertinoDialog(
                    context: context,
                    builder:
                        (_) => CupertinoAlertDialog(
                          title: const Text('已登录'),
                          content: Text(
                            '当前账号: ${GoogleSignInService.instance.userEmail}',
                          ),
                          actions: [
                            CupertinoDialogAction(
                              child: const Text('确定'),
                              onPressed: () => Navigator.of(context).pop(),
                            ),
                          ],
                        ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
