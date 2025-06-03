import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'alert_data.dart';

class AlertTabPage extends StatelessWidget {
  const AlertTabPage({super.key});

  // 示例告警数据（100条样本）
  final List<Map<String, String>> alerts = AlertData.alerts;

  // 告警类型与对应icon
  static final Map<String, IconData> alertIcons = AlertData.alertIcons;

  @override
  Widget build(BuildContext context) {
    return CupertinoScrollbar(
      child: Padding(
        padding: const EdgeInsets.only(top: 8), // 给Scrollbar和内容顶部加间距，避免被遮挡
        child: ListView.separated(
          padding: const EdgeInsets.only(
            top: 32,
            left: 16,
            right: 16,
            bottom: 0,
          ),
          itemCount: alerts.length,
          separatorBuilder:
              (context, index) => Container(
                height: 1,
                color: CupertinoColors.systemGrey5,
                margin: const EdgeInsets.only(top: 12), // 增加与上一笔资料的间距
              ),
          itemBuilder: (context, index) {
            final alert = alerts[index];
            final icon =
                alertIcons[alert['title']] ?? CupertinoIcons.bell_solid;
            return CupertinoListTile(
              leading: Icon(icon, color: CupertinoColors.systemRed, size: 32),
              title: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          alert['title'] ?? '',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        if ((alert['time'] ?? '').isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.only(top: 2),
                            child: Text(
                              alert['time'] ?? '',
                              style: const TextStyle(
                                fontSize: 13,
                                color: CupertinoColors.systemGrey,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                  Container(
                    constraints: const BoxConstraints(
                      minWidth: 80,
                      maxWidth: 120,
                    ),
                    margin: const EdgeInsets.only(left: 8),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 0,
                      vertical: 0,
                    ),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors:
                            alert['priority'] == '高'
                                ? [Color(0xFFFF5E62), Color(0xFFFF9966)]
                                : alert['priority'] == '中'
                                ? [Color(0xFFFFF200), Color(0xFFFFC371)]
                                : [Color(0xFF43E97B), Color(0xFF38F9D7)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.06),
                          blurRadius: 8,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        '紧急: ${alert['priority'] ?? ''}',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 1.2,
                          shadows: [
                            Shadow(
                              color: Colors.black.withOpacity(0.08),
                              blurRadius: 2,
                              offset: Offset(1, 1),
                            ),
                          ],
                        ),
                      ),
                    ),
                    height: 32,
                    width: double.infinity,
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
                        '处理人: ${alert['handler']}',
                        style: const TextStyle(fontSize: 13),
                      ),

                      const SizedBox(width: 12),
                      Text(
                        '处理时间: ${alert['handlerTime'] ?? ''}',
                        style: const TextStyle(
                          fontSize: 13,
                          color: CupertinoColors.systemGrey2,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        '状态: ${alert['status'] ?? ''}',
                        style: const TextStyle(fontSize: 13),
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
                // 可在此处理点击事件
              },
            );
          },
        ),
      ),
    );
  }
}
