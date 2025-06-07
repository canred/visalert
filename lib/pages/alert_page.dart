import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'alert_data.dart';
import 'alert_detail_page.dart';
import '../services/google_sign_in_service.dart';

class AlertTabPage extends StatefulWidget {
  const AlertTabPage({super.key});

  @override
  State<AlertTabPage> createState() => _AlertTabPageState();
}

class _AlertTabPageState extends State<AlertTabPage> {
  @override
  void initState() {
    super.initState();
    GoogleSignInService.instance.addListener(_onUserChanged);
  }

  @override
  void dispose() {
    GoogleSignInService.instance.removeListener(_onUserChanged);
    super.dispose();
  }

  void _onUserChanged() {
    setState(() {}); // 只需刷新界面即可
  }

  // 示例告警数据（100条样本）
  final List<Map<String, String>> alerts = AlertData.alerts;

  // 告警类型与对应icon
  static final Map<String, IconData> alertIcons = AlertData.alertIcons;

  @override
  Widget build(BuildContext context) {
    final _userEmail = GoogleSignInService.instance.userEmail;
    return Stack(
      children: [
        CupertinoScrollbar(
          child: Padding(
            padding: const EdgeInsets.only(top: 66), // 给Scrollbar和内容顶部加间距，避免被遮挡
            child: ListView.separated(
              padding: const EdgeInsets.only(
                top: 0,
                left: 0,
                right: 0,
                bottom: 0,
              ),
              itemCount: alerts.length,
              separatorBuilder:
                  (context, index) => Container(
                    height: 1,
                    color: CupertinoColors.systemGrey5,
                    margin: const EdgeInsets.only(top: 6), // 增加与上一笔资料的间距
                  ),
              itemBuilder: (context, index) {
                final alert = alerts[index];
                final icon =
                    alertIcons[alert['title']] ?? CupertinoIcons.bell_solid;
                return CupertinoListTile(
                  leading: SizedBox(
                    width: 32, // 控制左侧区域宽度，防止过宽
                    child: Icon(
                      icon,
                      color: CupertinoColors.systemRed,
                      size: 24,
                    ),
                  ),
                  title: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Flexible(
                                  child: Text(
                                    alert['title'] ?? '',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                if ((alert['time'] ?? '').isNotEmpty)
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8),
                                    child: Text(
                                      _extractTime(alert['time'] ?? ''),
                                      style: const TextStyle(
                                        fontSize: 13,
                                        color: CupertinoColors.systemGrey,
                                      ),
                                    ),
                                  ),
                                if ((alert['priority'] ?? '').isNotEmpty)
                                  Container(
                                    constraints: const BoxConstraints(
                                      minWidth: 32,
                                      maxWidth: 48,
                                    ),
                                    margin: const EdgeInsets.only(left: 4),
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 2,
                                    ),
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors:
                                            alert['priority'] == '高'
                                                ? [
                                                  Color(0xFFFF5E62),
                                                  Color(0xFFFF9966),
                                                ]
                                                : alert['priority'] == '中'
                                                ? [
                                                  Color(0xFFFFF200),
                                                  Color(0xFFFFC371),
                                                ]
                                                : [
                                                  Color(0xFF43E97B),
                                                  Color(0xFF38F9D7),
                                                ],
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.06),
                                          blurRadius: 8,
                                          offset: Offset(0, 2),
                                        ),
                                      ],
                                    ),
                                    child: Text(
                                      '${alert['priority'] ?? ''}',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 13,
                                        fontWeight: FontWeight.w900,
                                        letterSpacing: 1.2,
                                        shadows: [
                                          Shadow(
                                            color: Colors.black12,
                                            blurRadius: 2,
                                            offset: Offset(1, 1),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),

                                const SizedBox(width: 12),
                                Text(
                                  '${alert['status'] ?? ''}',
                                  style: const TextStyle(fontSize: 13),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        alert['desc'] ?? '',
                        style: const TextStyle(fontSize: 15),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Text(
                            '${alert['handler']}',
                            style: const TextStyle(fontSize: 13),
                          ),

                          const SizedBox(width: 6),
                          Text(
                            '${_extractTime(alert['handlerTime'] ?? '')}',
                            style: const TextStyle(
                              fontSize: 13,
                              color: CupertinoColors.systemGrey2,
                            ),
                          ),

                          const SizedBox(width: 12),
                          Text(
                            '回复: ${alert['reply'] ?? ''}',
                            style: const TextStyle(
                              fontSize: 13,
                              color: CupertinoColors.activeBlue,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  trailing: Padding(
                    padding: const EdgeInsets.only(right: 4.0), // 轻微右边距，避免贴边
                    child: Icon(
                      CupertinoIcons.right_chevron,
                      color: CupertinoColors.systemGrey,
                      size: 28, // 调大icon尺寸
                    ),
                  ),
                  onTap: () {
                    Navigator.of(context).push(
                      CupertinoPageRoute(
                        builder: (context) => AlertDetailPage(alert: alert),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ),
        Positioned(
          top: 42,
          right: 16,
          child:
              _userEmail != null && _userEmail.isNotEmpty
                  ? Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: CupertinoColors.systemGrey5,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Text(
                      _userEmail,
                      style: const TextStyle(
                        fontSize: 13,
                        color: CupertinoColors.systemGrey,
                      ),
                    ),
                  )
                  : Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: CupertinoColors.systemGrey5,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Text(
                      '未登入',
                      style: TextStyle(
                        fontSize: 13,
                        color: CupertinoColors.systemGrey,
                      ),
                    ),
                  ),
        ),
      ],
    );
  }

  String _extractTime(String dateTimeStr) {
    try {
      // 尝试解析日期时间字符串
      final dateTime = DateTime.parse(dateTimeStr);
      // 格式化为 HH:mm
      return '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
    } catch (e) {
      // 如果解析失败，返回原始字符串
      return dateTimeStr;
    }
  }
}
