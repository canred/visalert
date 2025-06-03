import 'package:flutter/cupertino.dart';

class SearchTabPage extends StatelessWidget {
  const SearchTabPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Icon(
          CupertinoIcons.search,
          size: 60,
          color: CupertinoColors.activeBlue,
        ),
        SizedBox(height: 12),
        Text('搜索内容', style: TextStyle(fontSize: 20)),
      ],
    );
  }
}
