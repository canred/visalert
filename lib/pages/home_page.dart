import 'package:flutter/cupertino.dart';

class HomeTabPage extends StatelessWidget {
  const HomeTabPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Icon(CupertinoIcons.home, size: 60, color: CupertinoColors.activeBlue),
        SizedBox(height: 12),
        Text('首页内容', style: TextStyle(fontSize: 20)),
      ],
    );
  }
}
