import 'package:flutter/material.dart';
import 'package:mimi_shope/core/theme/theme_extention.dart';

class StatusBadge extends StatelessWidget {
  final String status;
  final AppColors colors;
  final ColorScheme colorScheme;

  const StatusBadge({
    super.key,
    required this.status,
    required this.colors,
    required this.colorScheme,
  });

  @override
  Widget build(BuildContext context) {
    final statusData = _getStatusData();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: statusData.color.withAlpha(12),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        statusData.label,
        style: TextStyle(
          color: statusData.color,
          fontSize: 11,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  _StatusData _getStatusData() {
    switch (status.toLowerCase()) {
      case 'completed':
        return _StatusData(label: 'Completed', color: Colors.green);

      case 'cancelled':
        return _StatusData(label: 'Cancelled', color: Colors.red);

      case 'confirmed':
        return _StatusData(label: 'Confirmed', color: colorScheme.primary);

      case 'preparing':
        return _StatusData(label: 'Preparing', color: colorScheme.primary);

      case 'pending':
      default:
        return _StatusData(label: 'Pending', color: colorScheme.primary);
    }
  }
}

class _StatusData {
  final String label;
  final Color color;

  const _StatusData({required this.label, required this.color});
}
