import 'package:flutter/material.dart';

class StatusBadgeOrderDetailes extends StatelessWidget {
  final String status;
  final ColorScheme colorScheme;

  const StatusBadgeOrderDetailes({
    super.key,
    required this.status,
    required this.colorScheme,
  });

  @override
  Widget build(BuildContext context) {
    final statusColor = _getColor();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: statusColor.withAlpha(12),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        _formatStatus(),
        style: TextStyle(
          color: statusColor,
          fontSize: 11,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Color _getColor() {
    switch (status.toLowerCase()) {
      case 'completed':
        return Colors.green;

      case 'cancelled':
        return Colors.red;

      default:
        return colorScheme.primary;
    }
  }

  String _formatStatus() {
    if (status.isEmpty) {
      return 'Unknown';
    }

    return status[0].toUpperCase() + status.substring(1);
  }
}
