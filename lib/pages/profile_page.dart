import 'package:flutter/cupertino.dart';

class ProfileTabPage extends StatelessWidget {
  const ProfileTabPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Icon(
          CupertinoIcons.person,
          size: 60,
          color: CupertinoColors.activeBlue,
        ),
        SizedBox(height: 12),
        Text('我的内容', style: TextStyle(fontSize: 20)),
      ],
    );
  }
}
