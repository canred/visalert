import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../main.dart';

class IntroPage extends StatelessWidget {
  final String appTitle;
  const IntroPage({super.key, required this.appTitle});

  Future<void> _finishIntro(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('seen_intro', true);
    Navigator.of(context).pushReplacement(
      CupertinoPageRoute(builder: (context) => MyHomePage(title: appTitle)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(middle: Text(appTitle)),
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
          ],
        ),
      ),
    );
  }
}
