import 'package:flutter/cupertino.dart';

class SettingsTabPage extends StatelessWidget {
  const SettingsTabPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Icon(
          CupertinoIcons.settings,
          size: 60,
          color: CupertinoColors.activeBlue,
        ),
        SizedBox(height: 12),
        Text('设置内容', style: TextStyle(fontSize: 20)),
      ],
    );
  }
}
