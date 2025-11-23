import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AlertDetailPage extends StatefulWidget {
  final Map<String, dynamic> alert;

  const AlertDetailPage({Key? key, required this.alert}) : super(key: key);

  @override
  State<AlertDetailPage> createState() => _AlertDetailPageState();
}

class _AlertDetailPageState extends State<AlertDetailPage> {
  final TextEditingController _replyController = TextEditingController();

  @override
  void dispose() {
    _replyController.dispose();
    super.dispose();
  }

  void _showReplyBar() {
    showCupertinoModalPopup(
      context: context,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: SafeArea(
              top: false,
              child: Row(
                children: [
                  Expanded(
                    child: CupertinoTextField(
                      controller: _replyController,
                      placeholder: '请输入回复内容...',
                      maxLines: 3,
                      minLines: 1,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 10,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  CupertinoButton(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 10,
                    ),
                    color: CupertinoColors.activeBlue,
                    borderRadius: BorderRadius.circular(8),
                    child: const Text(
                      '发送',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      final text = _replyController.text.trim();
                      if (text.isNotEmpty) {
                        // TODO: 处理发送逻辑
                        print('发送内容: ' + text);
                        Navigator.of(context).pop();
                        _replyController.clear();
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final alert = widget.alert;
    final icon = _getIcon(alert['title']);
    final priority = alert['priority'] ?? '';
    final status = alert['status'] ?? '';
    final time = alert['time'] ?? '';
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(alert['title'] ?? '告警详情'),
        previousPageTitle: '返回',
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.06),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: CupertinoColors.systemRed.withOpacity(0.12),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          icon,
                          color: CupertinoColors.systemRed,
                          size: 28,
                        ),
                      ),
                      const SizedBox(width: 14),
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
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                if (time.isNotEmpty)
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8),
                                    child: Text(
                                      _extractTime(time),
                                      style: const TextStyle(
                                        fontSize: 13,
                                        color: CupertinoColors.systemGrey,
                                      ),
                                    ),
                                  ),
                                if (priority.isNotEmpty)
                                  _buildPriorityTag(priority),
                                const SizedBox(width: 10),
                                if (status.isNotEmpty)
                                  Text(
                                    status,
                                    style: const TextStyle(fontSize: 13),
                                  ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 18),
                  _buildDetailRow('描述', alert['desc'] ?? ''),
                  const Divider(height: 32, color: Color(0xFFF0F1F3)),
                  Row(
                    children: [
                      Expanded(
                        child: _buildDetailRow('处理人', alert['handler'] ?? ''),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: _buildDetailRow(
                          '处理时间',
                          alert['handlerTime'] ?? '',
                        ),
                      ),
                    ],
                  ),
                  const Divider(height: 32, color: Color(0xFFF0F1F3)),
                  _buildDetailRow('最后回复', alert['reply'] ?? ''),
                  const SizedBox(height: 28),
                  Row(
                    children: [
                      Expanded(
                        child: CupertinoButton.filled(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          borderRadius: BorderRadius.circular(8),
                          child: const Text(
                            '接案处理',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          onPressed: () {
                            // TODO: 实现接案处理逻辑
                          },
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: CupertinoButton(
                          color: CupertinoColors.activeBlue,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          borderRadius: BorderRadius.circular(8),
                          child: const Text(
                            '回复',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                          onPressed: _showReplyBar,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: CupertinoButton(
                          color: CupertinoColors.activeBlue,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          borderRadius: BorderRadius.circular(8),
                          child: const Text(
                            '结束案件',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                          onPressed: () {
                            // TODO: 实现结束案件逻辑
                          },
                        ),
                      ),
                    ],
                  ),
                  // 历史处理清单区域
                  if (alert['history'] != null && alert['history'] is List)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 32),
                        const Text(
                          '历史处理记录',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF2D5B88),
                          ),
                        ),
                        const SizedBox(height: 12),
                        ...List.generate((alert['history'] as List).length, (
                          index,
                        ) {
                          final item =
                              (alert['history'] as List)[index]
                                  as Map<String, dynamic>;
                          final handler = item['handler'] ?? '';
                          final time = item['handlerTime'] ?? '';
                          final content = item['reply'] ?? '';
                          String formatTime(String t) {
                            try {
                              final dt = DateTime.parse(t.replaceAll('/', '-'));
                              return '${dt.month.toString().padLeft(2, '0')}-${dt.day.toString().padLeft(2, '0')} ${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}';
                            } catch (_) {
                              return t;
                            }
                          }

                          return Column(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // 头像首字母圆形背景
                                  Container(
                                    width: 36,
                                    height: 36,
                                    decoration: BoxDecoration(
                                      color: const Color(
                                        0xFF2D5B88,
                                      ).withOpacity(0.12),
                                      shape: BoxShape.circle,
                                    ),
                                    alignment: Alignment.center,
                                    child: Text(
                                      handler.isNotEmpty
                                          ? (handler as String).characters.first
                                          : '',
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF2D5B88),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              handler,
                                              style: const TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 15,
                                              ),
                                            ),
                                            const SizedBox(width: 10),
                                            Text(
                                              formatTime(time),
                                              style: const TextStyle(
                                                color:
                                                    CupertinoColors.systemGrey,
                                                fontSize: 13,
                                              ),
                                            ),
                                          ],
                                        ),
                                        if (content.isNotEmpty)
                                          Padding(
                                            padding: const EdgeInsets.only(
                                              top: 6,
                                            ),
                                            child: Text(
                                              content,
                                              style: const TextStyle(
                                                fontSize: 15,
                                                color: Color(0xFF4B5563),
                                              ),
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              if (index !=
                                  (alert['history'] as List).length - 1)
                                const Divider(
                                  height: 24,
                                  color: Color(0xFFE0E3E8),
                                ),
                            ],
                          );
                        }),
                      ],
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  IconData _getIcon(String? title) {
    // 与主页一致的icon映射
    switch (title) {
      case '高温告警':
        return CupertinoIcons.thermometer;
      case '断电告警':
        return CupertinoIcons.bolt;
      case '网络异常':
        return CupertinoIcons.wifi_exclamationmark;
      case '烟雾报警':
        return CupertinoIcons.flame;
      case '门禁异常':
        return CupertinoIcons.lock_slash;
      case '湿度过高':
        return CupertinoIcons.drop;
      case '电池低电量':
        return CupertinoIcons.battery_25;
      case '设备离线':
        return CupertinoIcons.xmark_circle;
      case '异常重启':
        return CupertinoIcons.refresh;
      case '温度恢复':
        return CupertinoIcons.thermometer;
      case '电源恢复':
        return CupertinoIcons.bolt_horizontal;
      case '网络恢复':
        return CupertinoIcons.wifi;
      case '烟雾解除':
        return CupertinoIcons.flame;
      case '门禁恢复':
        return CupertinoIcons.lock_open;
      case '湿度恢复':
        return CupertinoIcons.drop;
      case '电池更换':
        return CupertinoIcons.battery_100;
      case '设备上线':
        return CupertinoIcons.check_mark_circled;
      case '重启成功':
        return CupertinoIcons.refresh_circled;
      default:
        return CupertinoIcons.bell_solid;
    }
  }

  Widget _buildPriorityTag(String priority) {
    List<Color> colors;
    switch (priority) {
      case '高':
        colors = [Color(0xFFFF5E62), Color(0xFFFF9966)];
        break;
      case '中':
        colors = [Color(0xFFFFF200), Color(0xFFFFC371)];
        break;
      default:
        colors = [Color(0xFF43E97B), Color(0xFF38F9D7)];
    }
    return Container(
      constraints: const BoxConstraints(minWidth: 32, maxWidth: 48),
      margin: const EdgeInsets.only(left: 4),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: colors,
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
        priority,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 13,
          fontWeight: FontWeight.w900,
          letterSpacing: 1.2,
          shadows: [
            Shadow(color: Colors.black12, blurRadius: 2, offset: Offset(1, 1)),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, [String value = '']) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (label.isNotEmpty)
            Text(
              '$label: ',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Color(0xFF2D5B88),
              ),
            ),
          if (value.isNotEmpty)
            Expanded(
              child: Text(
                value,
                style: const TextStyle(fontSize: 16, color: Color(0xFF4B5563)),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ),
        ],
      ),
    );
  }

  String _extractTime(String dateTimeStr) {
    try {
      final dateTime = DateTime.parse(dateTimeStr);
      return '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
    } catch (e) {
      return dateTimeStr;
    }
  }
}
