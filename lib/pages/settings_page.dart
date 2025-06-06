import 'package:flutter/cupertino.dart';
import 'package:visalert/services/google_sign_in_service.dart';

class SettingsTabPage extends StatelessWidget {
  const SettingsTabPage({super.key});

  @override
  Widget build(BuildContext context) {
    final GoogleSignInService _googleSignInService = GoogleSignInService();
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const Text('设置'),
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          child: const Text('使用Google账号登入', style: TextStyle(fontSize: 14)),
          onPressed: () async {
            final user = _googleSignInService.currentUser;
            if (user != null) {
              showCupertinoDialog(
                context: context,
                builder:
                    (_) => CupertinoAlertDialog(
                      title: const Text('已登录'),
                      content: Text(
                        '当前账号: \\${user.displayName ?? user.email}',
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
              final newUser = await _googleSignInService.signIn();
              if (newUser != null) {
                showCupertinoDialog(
                  context: context,
                  builder:
                      (_) => CupertinoAlertDialog(
                        title: const Text('登录成功'),
                        content: Text(
                          '欢迎, \\${newUser.displayName ?? newUser.email}',
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
            }
          },
        ),
      ),
      child: Column(
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
      ),
    );
  }
}
