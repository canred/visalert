import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart'; // 引入 services 套件以設定系統UI樣式
import 'package:visalert/services/config_service.dart';
import 'package:visalert/pages/search_page.dart';
import 'package:visalert/pages/notification_page.dart';
import 'package:visalert/pages/profile_page.dart';
import 'package:visalert/pages/settings_page.dart';
import 'package:visalert/pages/alert_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'pages/intro_page.dart';

// import 'package:prmsapp/services/messaging_service.dart'; // 如有推播服務可解開
// import 'package:prmsapp/pages/main_page.dart'; // 如有主頁可解開
// import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // 確保Flutter綁定已初始化

  // 架构化加载配置
  final configService = ConfigService();
  await configService.load();
  final String appTitle = configService.getString(
    'APP_TITLE',
    defaultValue: 'App',
  );

  final prefs = await SharedPreferences.getInstance();
  final bool seenIntro = prefs.getBool('seen_intro') ?? false;

  runApp(PrmsApp(appTitle: appTitle, showIntro: !seenIntro));
}

class PrmsApp extends StatelessWidget {
  final String appTitle;
  final bool showIntro;
  const PrmsApp({super.key, required this.appTitle, this.showIntro = false});

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      debugShowCheckedModeBanner: false,
      theme: const CupertinoThemeData(brightness: Brightness.light),
      home:
          showIntro
              ? IntroPage(appTitle: appTitle)
              : MyHomePage(title: appTitle),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(CupertinoIcons.home), label: '首页'),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.search),
            label: '搜索',
          ),
          BottomNavigationBarItem(icon: Icon(CupertinoIcons.bell), label: '通知'),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.person),
            label: '我的',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.settings),
            label: '设置',
          ),
        ],
        activeColor: CupertinoColors.activeBlue,
        inactiveColor: CupertinoColors.inactiveGray,
        backgroundColor: CupertinoColors.systemGrey6,
        iconSize: 26,
      ),
      tabBuilder: (context, index) {
        Widget content;
        switch (index) {
          case 0:
            content = const AlertTabPage();
            break;
          case 1:
            content = const SearchTabPage();
            break;
          case 2:
            content = const NotificationTabPage();
            break;
          case 3:
            content = const ProfileTabPage();
            break;
          case 4:
            content = const SettingsTabPage();
            break;
          default:
            content = const Center(child: Text('未知Tab'));
        }
        return CupertinoTabView(
          builder: (context) {
            return CupertinoPageScaffold(
              navigationBar: CupertinoNavigationBar(middle: Text(widget.title)),
              child: Center(child: content),
            );
          },
        );
      },
    );
  }
}
