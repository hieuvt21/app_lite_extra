import 'package:flutter/material.dart';

class ThanhHeader extends StatelessWidget {
  final String title;
  final VoidCallback onPosButtonPressed;

  const ThanhHeader({
    super.key,
    required this.title,
    required this.onPosButtonPressed,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final dynamicThemeColor = theme.colorScheme.primary;

    return Container(
      height: 65,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      // YÊU CẦU 1: Xóa đường viền Border bên dưới để tạo khối liền mạch mượt mà
      decoration: BoxDecoration(color: theme.colorScheme.surface),
      child: Row(
        children: [
          Text(
            title.toUpperCase(),
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFF0F172A),
            ),
          ),
          const Spacer(),

          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.notifications_none_rounded,
              color: Color(0xFF64748B),
            ),
          ),
          const SizedBox(width: 12),

          // Thanh dọc phân cách tinh tế
          Container(width: 1, height: 20, color: const Color(0xFFE2E8F0)),
          const SizedBox(width: 16),

          ElevatedButton.icon(
            onPressed: onPosButtonPressed,
            icon: const Icon(
              Icons.wallet_giftcard_rounded,
              color: Colors.white,
              size: 18,
            ),
            label: const Text(
              'POS',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 13,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: dynamicThemeColor,
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
