import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart'; // 引入 services 套件以設定系統UI樣式
import 'package:visalert/services/config_service.dart';
import 'package:visalert/pages/home_page.dart';
import 'package:visalert/pages/search_page.dart';
import 'package:visalert/pages/notification_page.dart';
import 'package:visalert/pages/profile_page.dart';
import 'package:visalert/pages/settings_page.dart';

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

  // // 初始化Firebase
  // try {
  //   await Firebase.initializeApp();
  // } catch (e) {
  //   print("Firebase initialization failed: $e");
  //   return;
  // }
  // 設定狀態列樣式，使其背景色跟隨APP主題
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Color.fromRGBO(0, 0, 0, 0), // 透明色，讓背景色可以顯示
      statusBarBrightness: Brightness.light, // iOS狀態列亮度，淺色背景用深色文字
      statusBarIconBrightness: Brightness.dark, // Android狀態列圖標亮度
    ),
  );

  // 初始化推播通知服務（如有）
  // await PushNotificationService().init();

  runApp(PrmsApp(appTitle: appTitle));
}

class PrmsApp extends StatelessWidget {
  final String appTitle;
  const PrmsApp({super.key, required this.appTitle});

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      debugShowCheckedModeBanner: false,
      theme: const CupertinoThemeData(brightness: Brightness.light),
      // home: MainPage(title: 'PRMS APP main'), // 如有主頁可解開
      home: MyHomePage(title: appTitle),
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
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

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
            content = const HomeTabPage();
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
