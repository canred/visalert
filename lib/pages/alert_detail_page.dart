import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AlertDetailPage extends StatelessWidget {
  final Map<String, String> alert;

  const AlertDetailPage({Key? key, required this.alert}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(alert['title'] ?? '告警详情'),
        previousPageTitle: '返回',
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                alert['title'] ?? '',
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 24),
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFF7F9FB), // 表单背景色
                  border: Border.all(color: Colors.grey.shade300, width: 1),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.05),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Table(
                  columnWidths: const {
                    0: FlexColumnWidth(1),
                    1: FlexColumnWidth(1),
                  },
                  border: TableBorder.symmetric(
                    inside: BorderSide(color: Colors.grey.shade200, width: 1),
                  ),
                  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                  children: [
                    TableRow(
                      decoration: const BoxDecoration(
                        color: Color(0xFFEAF1F8),
                      ), // 行背景色
                      children: [
                        _buildCell('优先级:', alert['priority'] ?? ''),
                        _buildCell('时间:', alert['time'] ?? ''),
                      ],
                    ),
                    TableRow(
                      decoration: const BoxDecoration(color: Color(0xFFF7F9FB)),
                      children: [
                        _buildCell('描述:', alert['desc'] ?? ''),
                        _buildCell('处理人:', alert['handler'] ?? ''),
                      ],
                    ),
                    TableRow(
                      decoration: const BoxDecoration(color: Color(0xFFEAF1F8)),
                      children: [
                        _buildCell('处理时间:', alert['handlerTime'] ?? ''),
                        _buildCell('状态:', alert['status'] ?? ''),
                      ],
                    ),
                    TableRow(
                      decoration: const BoxDecoration(color: Color(0xFFF7F9FB)),
                      children: [
                        _buildCell('回复:', alert['reply'] ?? ''),
                        const SizedBox(),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // 在类内添加辅助方法
  Widget _buildCell(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 14.0, horizontal: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Color(0xFF2D5B88), // 字段名颜色
            ),
          ),
          const SizedBox(width: 4),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 16,
                color: Color(0xFF4B5563),
              ), // 字段值颜色
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
