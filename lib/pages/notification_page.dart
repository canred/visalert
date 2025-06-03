import 'package:flutter/cupertino.dart';

class NotificationTabPage extends StatelessWidget {
  const NotificationTabPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Icon(CupertinoIcons.bell, size: 60, color: CupertinoColors.activeBlue),
        SizedBox(height: 12),
        Text('通知内容', style: TextStyle(fontSize: 20)),
      ],
    );
  }
}
